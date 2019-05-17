#lang racket/base

(require "azure.rkt"
         "oauth-deviceflow.rkt"
         gregor
         net/uri-codec
         net/http-client
         json
         racket/port)

;; Generic parts of the interface to Microsoft's Graph API

(provide graph-bearer-token
         graph-authenticate!
         graph/post
         moment->dateTimeTimeZone
         dateTimeTimeZone->moment)

;; ---------------------------------------------------------------------------------------------------
;; Types and constants

;; Host address for Microsoft Graph API requests
(define GRAPH-HOST "graph.microsoft.com")

;; A parameter to hold the current oauth-token 
(define graph-bearer-token (make-parameter #f))

;; ---------------------------------------------------------------------------------------------------
;; Interface to the Graph API

;; graph-authenticate : azure-app? -> void?
;; Authenticate to Azure AD. Stores the bearer token in a parameter for subsequent use by calls to the
;; Graph API without needing to be passed explicitly
(define (graph-authenticate! RUM-APP)
  (graph-bearer-token
    (oauth/deviceflow AZURE-OAUTH-HOST (azure-oauth-endpoint RUM-APP) RUM-APP)))

;; graph/post : string? jsexpr? -> jsexpr?
;; Send a POST request to a Graph endpoint
(define (graph/post endpoint data)
  (let-values ([(status headers response)
                (http-sendrecv
                 GRAPH-HOST
                 endpoint
                 #:ssl?    #t
                 #:method  #"POST"
                 #:headers (list
                            "Content-Type: application/json"
                            (string-append "authorization: Bearer "
                                           (oauth-token-access-token (graph-bearer-token))))
                 #:data    (jsexpr->string data))])
    (when (not (http-status-OK? status))
      (raise-user-error "Failed to talk to Microsoft Graph API" status))
    (string->jsexpr (port->string response))))


;; ---------------------------------------------------------------------------------------------------
;; Utility functions (exported)

;; graph-dateTimeTimeZone : moment? -> jsexpr?
;; Convert a gregor moment? to the Graph API "dateTimeTimeZone" structure
(define (moment->dateTimeTimeZone t)
  (hasheq
   'dateTime (datetime->iso8601 (->datetime/utc t))
   'timeZone "UTC"))

;; Convert a dateTimeTimeZone structure to a gregor moment
(define (dateTimeTimeZone->moment dttz)
  (with-timezone
    (iso8601->datetime (hash-ref dttz 'dateTime))
    (hash-ref dttz 'timeZone)))

;; ---------------------------------------------------------------------------------------------------
;; Private utility functions

;; http-status-OK? : bytes? -> boolean?
;; Check whether an HTTP status is 200 OK
(define (http-status-OK? status)
  (bytes=? status #"HTTP/1.1 200 OK"))


