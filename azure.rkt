#lang racket/base

;; Common definitions for Active Directory and Office365

(provide
 (struct-out azure-app)    ; A representation of an Azure application
 (struct-out office-room)  ; A meeting room
 ) 

;; ---------------------------------------------------------------------------------------------------

;; The data required to identify the application to the authentication server
;; tenant : string?
;; GUID identifing the AD instance 
;; client : string?
;; GUID identifying the application
;; scope : [List-of string?]
;; Requested permissions
;;
(struct azure-app (tenant client scope) #:transparent)


;; ---------------------------------------------------------------------------------------------------

;; A meeting room
(struct office-room (name email location capacity) #:transparent)

;; A meeting room booking
;; start : 
;; end   :
(struct office-event () #:transparent)
