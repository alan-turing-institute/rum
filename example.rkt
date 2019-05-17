#lang racket/base

(require "rum-config.rkt"
         "graph.rkt"
         "meeting.rkt"
         gregor)

;; For testing, `example` contains the result of calling graph-getSchedule
(require (only-in "experiments/example.rkt" example))
(define meetings (map parse-schedule-items example))


;; overlap : office-event? office-event? -> (U 'none 'partial 'full)
;; To what extent does the meeting `event` occur during the time period `inverval`?
(define (overlap event interval)
  #f
)

(define BIG-SEP   #\|)     ; Separator for major ticks
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

;; ticks : moment? moment? -> [List-of moment?]
;; Return a list of moments between st and nd, every half-hour. 
;; Assumes st < nd 
(define (ticks st nd)
  ;; Round start time down to the nearest 30 minutes
  (define start-time (time-round-down/30 st))
  ;; Keep adding 30 minutes until the end time is passed
  (let add/30 ([tick start-time])
    (cond
      [(moment>? tick nd) null]
      [else (cons tick (add/30 (+minutes tick 30)))])))

;; Round time down to the nearest 30 minutes
(define (time-round-down/30 tm)
  (moment
   (->year tm)
   (->month tm)
   (->day tm)
   (->hours tm)
   (* 30 (quotient (->minutes tm) 30))
   0
   #:tz (->timezone tm)))




;; Construct the following ASCII table

;;                     |8am  |10   |12   |1pm  |2    |4    |6
;;                     |..:..|..:..|..:..|..:..|..:..|..:..|
;; David Blackwell     |  :  |**:*-|  :  |  :  |  :  |  :  |

;; Given an ordered list of moments of length N and a list of office-event, return a vector of length
;; N - 1, whose elements are 'free, 'busy, or 'partial. 
