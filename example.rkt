#lang racket/base

(require gregor)

(require "rum-config.rkt"
         "graph.rkt"
         "meeting.rkt" ;; provides test-schedule
         "event.rkt"
         "schedule.rkt")


;; Make an association list of room-email . rooms
(define *rooms*
  (map (λ (r) (cons (office-room-email r) r)) RUM-ROOMS))

;; Currently should fall on 2-hour boundaries
(define START-TIME (moment 2019 5 16 8 0 0))
(define END-TIME (moment 2019 5 16 18 0 0))

(define *ticks* (make-ticks (moment 2019 05 16 08 00 00)
                            (moment 2019 05 16 18 00 00)))

(schedule-format *rooms* *ticks* test-schedule)
