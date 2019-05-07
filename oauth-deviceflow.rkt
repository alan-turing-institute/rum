#lang racket/base

(require "azure.rkt"
         net/url
         net/http-client
         net/uri-codec
         net/sendurl
         json
         racket/port
         racket/string)

;; A simple "device flow" authentication client for Microsoft's identity management system
;; See, eg, https://docs.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-device-code
;; but note that that page gives an incorrect endpoint

;; This is not a general-purpose oauth client. 

(provide
 (struct-out oauth-token) ; Details of the authentication response
 oauth/deviceflow)        ; Request an authentication token

;; ---------------------------------------------------------------------------------------------------

;; Data returned from a call to the token endpoint
;; token-type    : string?
;; scope         : [List-of string?]
;; expires-in    : exact-nonnegative-integer?
;; access-token  : string?
;; id-token      : #f (unused for now)
;; refresh-token : #f (unused for now)
(struct oauth-token
  (token-type scope expires-in access-token id-token refresh-token)
  #:transparent)

;; Data returned from a call to the devicecode endpoint
;; user-code        : string?
;; device-code      : string?
;; verification-uri : url?
;; expires-in       : exact-nonnegative-integer? (in seconds)
;; interval         : exact-nonnegative-integer? (in seconds)
;; message          : string?
(struct oauth-devicecode
  (user-code device-code verification-uri expires-in interval message)
  #:transparent)

;; ---------------------------------------------------------------------------------------------------

(define ENDPOINT/DEVICECODE "/devicecode")
(define ENDPOINT/TOKEN "/token")
(define TOKEN-GRANTTYPE "urn:ietf:params:oauth:grant-type:device_code")

;; oauth/deviceflow
;; Authenticate to Azure AD using the device flow:
;; 1. POST request data to device token endpoint; receive a device code
;; 2. Open a browser to a specified address linked to the device code, so that the user may sign in
;; 3. Poll a known address (using POST) with the device code, handling various responses until
;;    either we give up or we receive a token        
(define (oauth/deviceflow host endpoint app)
  (let ([dc (request-device-code host endpoint app)])
    (request-token host endpoint app dc)))

;; request-device-code : string? string? azure-app? -> oauth-devicecode? 
;; Request a device code for an application
;; endpoint : the authorisation endpoint without the terminating /devicecode
(define (request-device-code host endpoint app)
  (let-values ([(status headers response)
                (http-sendrecv
                 host
                 (string-append endpoint ENDPOINT/DEVICECODE)
                 #:ssl?    #t
                 #:method  "POST"
                 #:headers (list "Content-Type: application/x-www-form-urlencoded")
                 #:data    (alist->form-urlencoded
                            (list (cons 'client_id (azure-app-client app))
                                  (cons 'scope (string-join (azure-app-scope app))))))])
    (when (not (http-status-OK? status))
        (raise-user-error "Failed to connect to Microsoft authentication server" host))
    (parse-device-code-response response)))

;; parse-device-code-response : port? -> oauth-devicecode?
;; Parse the JSON returned by a request for a device code
(define (parse-device-code-response p)
  (let ([js (read-json p)])
    (oauth-devicecode
     (hash-ref js 'user_code)
     (hash-ref js 'device_code)
     (hash-ref js 'verification_uri)
     (string->number (hash-ref js 'expires_in))
     (string->number (hash-ref js 'interval))
     (hash-ref js 'message))))

;; request-token :  string? string? azure-app? oauth-devicecode? -> oauth-token?
;; Open a browser for the user to authenticate and poll given endpoint for an authentication token
(define (request-token host endpoint app device)
  ;; Open browser
  (displayln "The authentication server says:")
  (println (oauth-devicecode-message device))
  (send-url (oauth-devicecode-verification-uri device))

  ;; Poll for token
  ;; If the outcome is success (http-status-OK?), assume that authentication was successful and parse
  ;; the response appropriately. If the outcome is http-status-Bad-Request?, then check again if the
  ;; returned message is "authorization_pending", otherwise throw an exception.
  ;; If would be better to check all possible outcomes (both http status and error message), but
  ;; Microsoft's documentation is unreliable: the http status is not defined and the error codes are
  ;; potentially incorrect. So here we take a very narrow view of success. 
  (let poll ()
    (let-values ([(status headers response)
                  (http-sendrecv
                   host
                   (string-append endpoint ENDPOINT/TOKEN)
                   #:ssl?    #t
                   #:method  "POST"
                   #:headers (list "Content-Type: application/x-www-form-urlencoded")
                   #:data    (alist->form-urlencoded
                              (list (cons 'grant_type TOKEN-GRANTTYPE)
                                    (cons 'client_id (azure-app-client app))
                                    (cons 'device_code (oauth-devicecode-device-code device)))))])
      (cond
        [(http-status-OK? status)  
         (parse-token-response response)] 
        [(and (http-status-Bad-Request? status)
              (microsoft-authorization-pending? response))
         (begin
           (sleep (oauth-devicecode-interval device))
           (poll))]
        [(raise-user-error "Received unhandled response from Microsoft authentication server"
                           host status response)]))))

;; microsoft-authorization-pending? : port? -> boolean?
(define (microsoft-authorization-pending? p)
  (let ([js (read-json p)])
    (string=? (hash-ref js 'error) "authorization_pending")))

;; parse-token-response : port? -> oauth-token?
;; Parse the JSON returned by a request for a device code
(define (parse-token-response p)
  (let ([js (read-json p)])
    (oauth-token
     (hash-ref js 'token_type)
     (string-split (hash-ref js 'scope) #:trim? #f)
     (hash-ref js 'expires_in) ; Gotcha: This time it's a number already!
     (hash-ref js 'access_token)
     (hash-ref js 'id_token #f)
     (hash-ref js 'refresh_token #f))))

;; http-status-OK? : bytes? -> boolean?
;; Check whether an HTTP status is 200 OK
(define (http-status-OK? status)
  (bytes=? status #"HTTP/1.1 200 OK"))

;; http-status-OK? : bytes? -> boolean?
;; Check whether an HTTP status is 400 Bad Request
(define (http-status-Bad-Request? status)
  (bytes=? status #"HTTP/1.1 400 Bad Request"))
