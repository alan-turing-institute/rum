#lang racket/base

(require gregor
         gregor/time
         racket/cmdline
         racket/string)

(require "rum-config.rkt"
         "parse-command-line.rkt"
         "graph.rkt"
         "meeting.rkt"
         "schedule.rkt")

;; Parse command line
(define the-date (make-parameter (today)))

(command-line
 #:program "rum"
 #:once-any
 [("-d" "--date") dt
                  ("Specify the date for the returned schedule."
                   "Either mon, tue, wed, ... for the next named day,"
                   "a number (interpreted as a date in the current month),"
                   "or a date in YYYY-MM-DD format.")
                  (the-date (parse-command-line-date dt))]
 #:usage-help
 "rum returns a schedule of meeting room availabilities for a given date"
 "(defaulting to today if not date is given)."
 #:ps "Note: Currently, you need to authenticate to Azure each time.")

;; Authenticate to Azure AD
(graph-authenticate! RUM-APP)

;; Currently should fall on 2-hour boundaries

(define START-TIME
  (with-timezone
    (on-date (time 08 00 00) (the-date))
    (current-timezone)))

(define END-TIME
  (with-timezone
    (on-date (time 18 00 00) (the-date))
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
 (string-join (schedule-format *rooms* *ticks* *schedule*) "\n" #:before-first "\n"))


