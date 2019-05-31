#lang racket/base

(require "rum-config.rkt"
         "graph.rkt"
         "meeting.rkt"
         "event.rkt"
         gregor)

(module+ test
  (require rackunit))

;; For testing, `test-schedule` contains the result of a call to graph-getSchedule

(define BIG-SEP   #\|)     ; Major ticks
(define SMALL-SEP #\:)     ; Minor ticks
(define FREE      #\space) ; Room free the enture period
(define BUSY      #\*)     ; Room booked the entire period
(define PARTIAL   #\-)     ; Room booked for part of the period
(define LEADER    #\.)     ; For horizontal lines
(define ERR       #\?)     ; For ticks not correctly aligned

;; Make an association list of room-email . rooms
(define rooms
  (map (λ (r) (cons (office-room-email r) r)) RUM-ROOMS))

;; This version makes a table of availabilities between two given times, every 30 minutes.
;; All times are local

(define START-TIME (moment 2019 5 16 8 0 0))
(define END-TIME (moment 2019 5 16 18 0 0))

;; make-ticks : moment? moment? -> [List-of moment?]
;; Return a list of moments between st and nd, every half-hour. 
;; Assumes st < nd 
(define (make-ticks st nd)
  ;; Round start time down to the nearest hour
  (define start-time (time-round-down/hour st))
  ;; Keep adding 30 minutes until the end time is passed
  (let add/30 ([tick start-time])
    (cond
      [(moment>? tick nd) null]
      [else (cons tick (add/30 (+minutes tick 30)))])))

;; Round time down to the nearest hour
(define (time-round-down/hour tm)
  (moment
   (->year tm)
   (->month tm)
   (->day tm)
   (->hours tm)
   0
   0
   #:tz (->timezone tm)))

;; event-merge : List-of event? -> List-of event?
;; Given an unordered list of events, produce a list of non-overlapping events with the same
;; cover. (Note that events are deemed to be closed intervals.)
(define (event-merge events)
  ;; distincts : Working list of output events, non-overlapping, ordered.
  ;; Note that non-overlapping events can be unambiguously ordered by their start times (or their end times)
  (event-merge-helper '() events))

(define (event-merge-helper distincts evts)
  (cond
    [(null? evts) distincts]
    [else (event-merge-helper (merge-into distincts (car evts)) (cdr evts))]))

;; merge-into : merge a single event into an ordered list of non-overlapping events
;; cdr down distincts until the start of evt is temporally prior to the end of the first event in
;; distincts. The elements of distincts before this point do not overlap evt. Then, cdr down the
;; remaining events until the end of evt is beyond the start of the next event. Events after this
;; point do not overlap evt. Then replace evt and the middle events with a single event from the
;; earliest time to the latest.   
(define (merge-into distincts evt)
  (reverse (skip-left-and-merge-into-right '() distincts evt)))

;; NB lefts is constructed in reverse order
(define (skip-left-and-merge-into-right lefts rights evt)
  (if (null? rights)
      (cons evt lefts)
      (let ([next-evt (car rights)])
        (if (moment>? (event-start evt) (event-end next-evt))
            (skip-left-and-merge-into-right (cons next-evt lefts) (cdr rights) evt)
            (merge-into-right lefts rights (struct-copy
                                            event evt
                                            [start (moment-first (event-start evt) (event-start next-evt))]))))))

(define (merge-into-right lefts rights evt)
  (if (null? rights)
      (cons evt lefts)
      (let ([next-evt (car rights)])
        (if (moment<? (event-end evt) (event-start next-evt))
            (prepend-reverse rights (cons evt lefts))
            (merge-into-right lefts (cdr rights) (struct-copy
                                                  event evt
                                                  [end (moment-last (event-end evt) (event-end next-evt))]))))))

;; Return the earliest moment
(define (moment-first e1 e2)
  (if (moment<? e1 e2) e1 e2))

;; Return the latest moment
(define (moment-last e1 e2)
  (if (moment<? e1 e2) e2 e1))

;; Cons the elements of ys, in order, onto the xs (effectively prepending the second
;; list in reverse order onto the first)
(define (prepend-reverse xs ys)
  (if (null? ys)
      xs
      (prepend-reverse (cons (car ys) xs) (cdr ys))))

(module+ test
  (define ev1 (event (moment 2019 05 16 08 00 00) (moment 2019 05 16 08 30 00)))
  (define ev2 (event (moment 2019 05 16 08 15 00) (moment 2019 05 16 08 30 00)))
  (define ev3 (event (moment 2019 05 16 08 45 00) (moment 2019 05 16 09 45 00)))
  ;;
  (define evs (event-merge (list ev1 ev2 ev3)))
  (check-equal? evs
                (list (event (moment 2019 05 16 08 00 00) (moment 2019 05 16 08 30 00))
                      (event (moment 2019 05 16 08 45 00) (moment 2019 05 16 09 45 00)))))


(define (availability? v)
  (ormap (λ (s) (eq? v s))
         '(free partial busy)))

;; availabilities : [List-of moment?] [List-of event?] -> [List-of availability?]
;; Given a list of moment? (of length N > 0) and an ordered list of non-overlapping event?, return a
;; list (of length N - 1) of availabilities in the times between the moments
(define (availabilities ticks events)
  ;; avails allows ticks to be empty
  (define (avails fst ticks events) 
    (if (null? ticks)
        null
        (let ([snd (car ticks)]) ; the interval is [fst, snd]
          (if (null? events)
              (cons 'free (avails snd (cdr ticks) events))
              (let ([evt (car events)])
                (let ([evt-start (event-start evt)]
                      [evt-end   (event-end   evt)])
                  (cond
                    [(moment<=? evt-end fst) ;   [.] |   |
                     (avails fst ticks (cdr events))] 
                    [(moment<?  evt-end snd) ;     [.|.] |
                     ;; skip any other events within this interval 
                     (cons 'partial (avails snd (cdr ticks) (skip snd (cdr events))))] 
                    ;; evt-end >= snd
                    [else
                     (cond
                       [(moment<=? evt-start fst) ; [|...|.] 
                        (cons 'busy    (avails snd (cdr ticks) (cons (clip evt snd) (cdr events))))]
                       [(moment<=? evt-start snd) ;  | [.|.]
                        (cons 'partial (avails snd (cdr ticks) (cons (clip evt snd) (cdr events))))]
                       [else                      ;  |   | [.]
                        (cons 'free (avails snd (cdr ticks) events))])])))))))
  ;; Skip any events lying before tick, returning the remaining events (possibly null), clipped to tick
  (define (skip tick events)
    (if (null? events)
        null
        (let ([evt (car events)])
          (if (moment<=? (event-end (car events)) tick)
              (skip tick (cdr events))
              (cons (clip event tick) (cdr events))))))
  ;; Clip the start of event e to the moment t
  (define (clip e t)
    (struct-copy event e
                 [start (moment-last (event-start e) t)]))
  ;; Body
  (if (null? ticks)
      #f
      (avails (car ticks) (cdr ticks) events)))

(module+ test
  (define tocks (make-ticks (moment 2019 05 16 8 0 0) (moment 2019 05 16 11 0 0)))
  (define avs   (availabilities tocks evs))
   (check-equal? avs '(busy partial busy partial free free)))



;; Construct the following ASCII table

;;                     |8am  |10   |12   |2pm  |4    |6
;;                     |..:..|..:..|..:..|..:..|..:..|
;; David Blackwell     |  :  |**:*-|  :  |  :  |  :  |

;; Given an ordered list of moments of length N and a list of office-event, return a vector of length
;; N - 1, whose elements are 'free, 'busy, or 'partial. 

(define tocks (make-ticks (moment 2019 05 16 08 00 00)
                          (moment 2019 05 16 18 00 00)))

;; Construct the time axis
;; 
(define (format-schedule-ticks ticks)
  #f)

;; Construct the separator row
(define (format-schedule-sep ticks)
  (define (schd ticks)
    (if (null? ticks)
        null
        ;; Trickery to ensure that the final tick isn't followed by a leader
        (append (tick->chars (car ticks))
                (append (if (null? (cdr ticks)) null (list LEADER))
                        (schd (cdr ticks))))))
  ;; Body
  (list->string (schd ticks)))

(define (tick->chars t)
  (cond
    [(= (->minutes t) 30)
     null]
    [(and (= (->minutes t) 0) (= (modulo (->hours t) 2) 1))
     (list SMALL-SEP)]
    [(= (->minutes t) 0)
     (list BIG-SEP)]
    [else
     (list ERR)]))

(define (avail->char a)
  (cond
    [(eq? a 'free) FREE]
    [(eq? a 'busy) BUSY]
    [else          PARTIAL]))

;; Construct a row 
(define (format-schedule-row ticks avs)
  (define (schd ticks avs)
    (if (null? avs)
        (tick->chars (car ticks))
        (append (tick->chars (car ticks))
                (append (if (null? (cdr ticks)) null (list (avail->char (car avs))))
                        (schd (cdr ticks) (cdr avs))))))
  ;; Body
  (list->string (schd ticks avs)))
