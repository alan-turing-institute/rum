#lang racket/base

;; Utilities for accessing Office 365 meeting events

(require gregor
         json)

(require "graph.rkt"
         "event.rkt")

(provide
 (struct-out office-room)
 (struct-out office-event) 
 graph-getSchedule)

;; ---------------------------------------------------------------------------------------------------
;; Types

;; Possible values for the "free/busy status" of a room
(define (office-freeBusyStatus? v)
  (ormap (λ (s) (eq? v s))
         '(free tentative busy oof workingElsewhere unknown)))

;; A meeting room
(struct office-room
  (name     ; string? : full name of the room
   email    ; string? : email address of the room (to use as an identifier)
   location ; string? : for information
   capacity ; exact-nonnegative-integer? : nominal room capacity
   ) #:transparent)

;; An Office 365 event
;; a kind of event?
(struct office-event event
  (isPrivate ; boolean? 
   status    ; office-freeBusyStatus?
   subject   ; string? : meeting's subject line
   location  ; string? : full name of the meeting room
   )
  #:transparent)

;; ---------------------------------------------------------------------------------------------------
;; Graph API calls

;; graph-getSchedule : moment? moment? [List-of office-room?] ->
;;                       [List-of [Pair-of office-room? [List-of office-event?]]]
;; Get meeting room events for all `rooms` between `start` and `end`
(define (graph-getSchedule start end rooms)
  (define request
    (hasheq
     'Schedules (map office-room-email rooms)
     'StartTime (moment->dateTimeTimeZone start)
     'EndTime   (moment->dateTimeTimeZone end)
     'availabilityViewInterval 30))
  (define response
    (graph/post "/v1.0/me/calendar/getschedule"
                request))
  ;; The return from the API request is a dictionary, of which we want the "value" component, which is
  ;; a list of room bookings
  (map parse-schedule-items (hash-ref response 'value)))

;; parse-schedule-items : hasheq? -> [Pair-of string? office-event?] 
(define (parse-schedule-items item)
  (cons (hash-ref item 'scheduleId)
        (map parse-office-event (hash-ref item 'scheduleItems))))

;; parse-office-event : hasheq? -> office-event?
(define (parse-office-event evt)
  (office-event
   (dateTimeTimeZone->moment (hash-ref evt 'start)) ; start   
   (dateTimeTimeZone->moment (hash-ref evt 'end))   ; end
   (hash-ref evt 'isPrivate)                        ; isPrivate
   (parse-freeBusyStatus (hash-ref evt 'status))    ; status    
   (hash-ref evt 'subject)                          ; subject 
   (hash-ref evt 'location)                         ; location
   ))

;; parse-freeBusyStatus : string? -> office-freeBusyStatus?
(define (parse-freeBusyStatus st)
  (cond
    [(string=? st "free")             'free]
    [(string=? st "tentative")        'tentative]
    [(string=? st "busy")             'busy]
    [(string=? st "oof")              'oof]
    [(string=? st "workingElsewhere") 'workingElsewhere]
    [(string=? st "unknown")          'unknown]))

