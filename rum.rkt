#lang racket/base

(require "rum-config.rkt"
         "graph.rkt"
         "meeting.rkt"
         gregor)

;; overlap : office-event? office-event? -> (U 'none 'partial 'full)
;; To what extent does the meeting `event` occur during the time period `inverval`?
(define (overlap event interval)
  #f
)

;; Authenticate to Azure AD
(graph-authenticate! RUM-APP)

;; Try to read some calendar data
(define START-TIME (moment 2019 5 16 8 0 0))
(define END-TIME (moment 2019 5 16 18 0 0))

(define rooms
  (map office-room-email RUM-ROOMS))

;; Retrieve the schedule
(graph-getSchedule start-time end-time rooms)

