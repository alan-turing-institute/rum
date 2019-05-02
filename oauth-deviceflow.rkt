#lang racket/base

;; A simple authentication client for Microsoft's identity management system using the "device flow"
;; See, eg, https://docs.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-device-code
;; but note that that pages gives an incorrect endpoint

; (provide )




;; The data required to identify the application to the authentication server
(struct oauth-app
  (tenant ; string?
   
   ))
