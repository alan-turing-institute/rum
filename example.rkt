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
(define LEADERS   #\.)     ; For horizontal lines

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
  (check-equal? (event-merge (list ev1 ev2 ev3))
                (list (event (moment 2019 05 16 08 00 00) (moment 2019 05 16 08 30 00))
                      (event (moment 2019 05 16 08 45 00) (moment 2019 05 16 09 45 00)))))


(define (availability? v)
  (ormap (λ (s) (eq? v s))
         '(free partial busy)))

;; availabilities : [List-of moment?] [List-of event?] -> [List-of availability?]

;; Given a list of moment? and an ordered list of event?, return a list of of availabilities in the
;; times between the moments
(define (availabilities ticks ev)
  (cond
    [(null? ticks) null]
    [])
  )

;; availability : moment? moment? event? -> availability?
;; Return the availability of the event between the two moments.
(define (availability tick-start tick-end ev)
  (let ([ev-start (event-start ev)]
        [ev-end   (event-end   ev)])
    (cond
      [(moment<=? ev-end tick-start) 'free]
      [(moment<? ev-end tick-end)  'partial]
      [else (cond
              [(moment<=? ev-start tick-start) 'busy]
              [(moment<=? ev-start tick-end) 'partial]
              [else 'free])])))

(module+ test
  (define tocks (make-ticks (moment 2019 05 16 8 0 0) (moment 2019 05 16 10 0 0)))
  ;;
  (define av1 (availabilities tocks ev1))
  (define av2 (availabilities tocks ev2))
  (define av3 (availabilities tocks ev3))
  ;;
  (check-equal? av1 #(busy free free free))
  (check-equal? av2 #(partial free free free))
  (check-equal? av3 #(free partial busy partial)))



;; Construct the following ASCII table

;;                     |8am  |10   |12   |2pm  |4    |6
;;                     |..:..|..:..|..:..|..:..|..:..|
;; David Blackwell     |  :  |**:*-|  :  |  :  |  :  |

;; Given an ordered list of moments of length N and a list of office-event, return a vector of length
;; N - 1, whose elements are 'free, 'busy, or 'partial. 

(define tocks (make-ticks (moment 2019 05 16 08 00 00)
                          (moment 2019 05 16 18 00 00)))

