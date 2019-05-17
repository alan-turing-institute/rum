#lang racket/base

;; Common definitions for Active Directory and Office 365

(require (only-in gregor moment))

(provide
 AZURE-OAUTH-HOST          ; Host for authentication
 azure-oauth-endpoint      ; azure-app? -> endpoint
 (struct-out azure-app)    ; A representation of an Azure application
 ) 

;; ---------------------------------------------------------------------------------------------------
;; Microsoft's oauth implementation

(define AZURE-OAUTH-HOST "login.microsoftonline.com")
(define AZURE-OAUTH-ENDPOINT "/oauth2/v2.0")
(define (azure-oauth-endpoint app)
  (string-append "/" (azure-app-tenant app) AZURE-OAUTH-ENDPOINT))


;; ---------------------------------------------------------------------------------------------------
;; Active Directory

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
;; Office 365

