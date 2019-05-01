#lang racket

(require oauth2 oauth2/client)

(define rum
  (client
   "Meeting Room Availability Checker"  ; Service name
   "https://login.microsoftonline.com/4395f4a7-e455-4f95-8a9f-1fbaef6384f9/oauth2/v2.0/authorize" ; Auth uri
   "https://login.microsoftonline.com/4395f4a7-e455-4f95-8a9f-1fbaef6384f9/oauth2/v2.0/token" ; Token uri
   #f
   #f
   "a462354f-fd23-4fdf-94f5-5cce5a6c27c7" ; client id
   #f
   ))

(define response-channel
  (request-authorization-code rum '("Bookings.Read.All")))
 
;; (define authorization-code
;;   (channel-get response-channel))
;; (displayln (format "received auth-code ~a" authorization-code))
 
