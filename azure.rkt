#lang racket/base

;; Common definitions for Active Directory / Azure

(provide (struct-out azure-app))

;; The data required to identify the application to the authentication server
;; tenant : string?
;; GUID identifing the AD instance 
;; client : string?
;; GUID identifying the application
;; scope : [List-of string?]
;; Requested permissions
;;
(struct azure-app (tenant client scope) #:transparent)

