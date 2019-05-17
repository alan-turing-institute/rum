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

(define START-TIME (moment 2019 5 16 8 0 0))
(define END-TIME (moment 2019 5 16 18 0 0))

;; ticks : moment? moment? -> [List-of moment?]
;; Return a list of moments between st and nd, every half-hour. 
;; Assumes st < nd, and fall on the same dae
(define (ticks st nd)
  (define day (->date st))
  ;; Round start time down to the nearest 30 minutes
  (define start-time (time-round-down/30 st))
  ;; Round end time up to the nearest 30 minutes
  (define end-time
    (let ([temp (time-round-down/30 nd)])
      (if (time=? nd temp)
          temp
          (+minutes temp 30))))
  )

;; Round time down to the nearest 30 minutes
(define (time-round-down/30 tm)
  (time (->hours tm) (* 30 (quotient (->mins tm) 30))))

;; Construct the following ASCII table

;;                     |8am  |10   |12   |1pm  |2    |4    |6
;;                     |..:..|..:..|..:..|..:..|..:..|..:..|
;; David Blackwell     |  :  |**:*-|  :  |  :  |  :  |  :  |

;; Given an ordered list of moments of length N and a list of office-event, return a vector of length
;; N - 1, whose elements are 'free, 'busy, or 'partial. 
