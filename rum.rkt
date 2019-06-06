#lang racket/base

(require gregor
         gregor/time 
         racket/string)

(require "rum-config.rkt"
         "graph.rkt"
         "meeting.rkt"
         "schedule.rkt")

;; Authenticate to Azure AD
(graph-authenticate! RUM-APP)

;; Currently should fall on 2-hour boundaries

(define START-TIME
  (with-timezone
    (on-date (time 08 00 00) (today))
    (current-timezone)))

(define END-TIME
  (with-timezone
    (on-date (time 18 00 00) (today))
    (current-timezone)))

;; Retrieve the schedule
(define *schedule* (graph-getSchedule START-TIME END-TIME RUM-ROOMS))

;; Make an association list of room-email . rooms
(define *rooms*
  (map (λ (r) (cons (office-room-email r) r)) RUM-ROOMS))

;; Define the times for which we'd like to see availabilities
(define *ticks* (make-ticks START-TIME END-TIME))

; Display the formatted schedule
(displayln
 (string-join (schedule-format *rooms* *ticks* *schedule*) "\n"))


