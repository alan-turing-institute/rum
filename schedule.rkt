#lang racket/base

;; A schedule is a list of events. This module provides facailities for normalising schedules (to a
;; minimum set of ordered, non-overlapping events) and for computing availabilities between a list of
;; moment?

(require racket/format
         gregor)

(require "event.rkt"
         "meeting.rkt")

(provide make-ticks
         availability?
         schedule-normalise
         schedule-availabilities
         schedule-format)

;; ---------------------------------------------------------------------------------------------------

(define BIG-SEP   #\|)     ; Major ticks
(define SMALL-SEP #\:)     ; Minor ticks
(define FREE      #\space) ; Room free the enture period
(define BUSY      #\*)     ; Room booked the entire period
(define PARTIAL   #\-)     ; Room booked for part of the period
(define LEADER    #\.)     ; For horizontal lines
(define ERR       #\?)     ; For ticks not correctly aligned

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

;; ---------------------------------------------------------------------------------------------------

;; schedule-normalise : List-of event? -> List-of event?
;; Given an unordered list of events, produce a list of non-overlapping events with the same
;; cover. (Note that events are deemed to be closed intervals.)
(define (schedule-normalise events)
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

;; ---------------------------------------------------------------------------------------------------

;; availability : any/c -> boolean?
(define (availability? v)
  (ormap (λ (s) (eq? v s))
         '(free partial busy)))

;; schedule-availabilities : [List-of moment?] [List-of event?] -> [List-of availability?]
;; Given a list of moment? (of length N > 0) and an ordered list of non-overlapping event?, return a
;; list (of length N - 1) of availabilities in the times between the moments
(define (schedule-availabilities ticks events)
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
                    [(moment<=? evt-end fst)      ; [.] |   |
                     (avails fst ticks (cdr events))] 
                    [(moment<?  evt-end snd)      ;   [.|.] |
                     ;; skip any other events within this interval 
                     (cons 'partial (avails snd (cdr ticks) (skip snd (cdr events))))] 
                    ;; evt-end >= snd
                    [else
                     (cond
                       [(moment<=? evt-start fst) ;   [|...|] 
                        (cons 'busy    (avails snd (cdr ticks) (cons (clip evt snd) (cdr events))))]
                       [(moment<? evt-start snd)  ;    |  [|]
                        (cons 'partial (avails snd (cdr ticks) (cons (clip evt snd) (cdr events))))]
                       [else                      ;    |   | [.]
                        (cons 'free (avails snd (cdr ticks) events))])])))))))
  ;; Skip any events lying before tick, returning the remaining events (possibly null), clipped to tick
  (define (skip tick events)
    (if (null? events)
        null
        (let ([evt (car events)])
          (if (moment<=? (event-end (car events)) tick)
              (skip tick (cdr events))
              (cons (clip evt tick) (cdr events))))))
  ;; Clip the start of event e to the moment t
  (define (clip e t)
    (struct-copy event e
                 [start (moment-last (event-start e) t)]))
  ;; Body
  (if (null? ticks)
      #f
      (avails (car ticks) (cdr ticks) events)))

;; ---------------------------------------------------------------------------------------------------

;; Construct the following ASCII table from a list of ticks and a list of list of availabilities. 

;;                     08    10    12    14    16    18    <- axis
;;                     |..:..|..:..|..:..|..:..|..:..|     <- separator
;; David Blackwell     |  :  |**:*-|  :  |  :  |  :  |     <- schedule row

;; The rules of this table are as follows

;; 1. For the separator:
;; If the tick is a big-time-tick? or a small-time-tick? then emit the corresponding character (| or :). Then
;; emit a leader character (.), unless this is the last tick.

;; 2. For the schedule row:
;; As the separator, but instead of emitting the leader, emit either * or -, depending on the
;; availability, unless this is the last tick (when we will have run out of availabilities)

;; 3. For the axis:
;; If the tick is a big-time-tick? then replace the current maybe-scale-chars with the hour.
;; Do the same as separator, replacing the tick marks with space

;; Typeset the schedules, including axis and labels
;; format-schedule : -> List-of string?
(define (schedule-format rooms ticks schedules)
  (let* ([names           (map (λ (r) (office-room-name (cdr r))) rooms)]
         [max-name-length (apply max (map string-length names))]
         [scheds          (tabulate-schedules ticks schedules)])
    (list* (string-append
            (blanks (+ max-name-length 1))
            (format-schedule-axis ticks)) 
           (string-append
            (blanks (+ max-name-length 1))
            (format-schedule-sep ticks))
           (for/list ([r rooms])
             (string-append
              (pad-left max-name-length (office-room-name (cdr r)))
              " "
              (cdr (assoc (car r) scheds)))))))

(define (blanks k)
  (make-string k #\space))

(define (pad-left l s)
  (~a s #:min-width l #:align 'left))

;; Construct the time axis

(define (make-char-supplier)
  (define chars '())
  (define (set-chars! cs)
    (set! chars cs))
  (define (pop!)
    (if (null? chars)
        #\space
        (begin0 (car chars) (set! chars (cdr chars)))))
  (values set-chars! pop!))

(define (format-schedule-axis ticks)
  ;; A quick and dirty stack which returns space when it runs out
  (define-values (set-chars! pop!) (make-char-supplier))
  ;; NB schd is not tail-recursive
  (define (schd ticks)
    (if (null? ticks)
        null
        (let ([t (car ticks)])
          (when (big-time-tick? t)
            (set-chars! (string->list (number->string (->hours t)))))
          (if (or (big-time-tick? t) (small-time-tick? t))
              (cons (pop!) (cons (pop!) (schd (cdr ticks))))
              (cons (pop!) (schd (cdr ticks)))))))
  
  (list->string (schd ticks)))

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
    [(= (->minutes t) 30) null]
    [(small-time-tick? t) (list SMALL-SEP)]
    [(big-time-tick? t)   (list BIG-SEP)]
    [else                 (list ERR)]))

(define (small-time-tick? t)
  (and (= (->minutes t) 0) (= (modulo (->hours t) 2) 1)))

(define (big-time-tick? t)
  (and (= (->minutes t) 0) (= (modulo (->hours t) 2) 0)))

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


;; tabulate-schedules : [Assoc email (list-of event)) -> [assoc email schedule-string] 
(define (tabulate-schedules ticks schedules)
  (define (stringify-schedule s)
    (format-schedule-row ticks (schedule-availabilities ticks (schedule-normalise s))))
  ;; (pair? email [List-of event]) -> (pair? email string?)
  (define (stringify-room r)
    (cons
     (car r)
     (stringify-schedule (cdr r))))
  ;;
  (map stringify-room schedules))


