#lang racket/base

(require "azure.rkt"
         net/url
         net/http-client
         net/uri-codec
         net/send-url
         json
         racket/port
         racket/string)

;; A simple "device flow" authentication client for Microsoft's identity management system
;; See, eg, https://docs.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-device-code
;; but note that that page gives an incorrect endpoint

;; This is not a general-purpose oauth client. 

(provide
 (struct-out oauth-devicecode))

;; ---------------------------------------------------------------------------------------------------

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

;; Data returned from a call to the token endpoint
;; token-type    : string?
;; scope         : [List-of string?]
;; expires-in    : exact-nonnegative-integer?
;; access-token  : string?
;; id-token      : #f (unsused for now)
;; refresh-token : #f (unused for now)
(struct oauth-token
  (token-type scope expires-in access-token id-token refresh-token)
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
  (let ([device-code (request-device-code #f #f #f)])
    (request-token device-code)))


;; request-device-code : string? string? azure-app? -> oauth-devicecode? 
;; Request a device code for an application
;; endpoint : the authorisation endpoint without the terminating /devicecode
(define (request-device-code host endpoint app)
  (let-values ([(status headers response)
                (http-sendrecv
                 host
                 (string-append endpoint ENDPOINT/DEVICECODE)
                 #:ssl? #t
                 #:method "POST"
                 #:headers (list "Content-Type: application/x-www-form-urlencoded")
                 #:data
                 (alist->form-urlencoded
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
  (println "The authentication server says:")
  (println (oauth-devicecode-message device))
  (send-url (oauth-devicecode-verification-uri device))

  ;; Poll for token
  (let poll ()
    (let-values ([(status headers response)
                  (http-sendrecv
                   host
                   (string-append endpoint DEVICECODE/TOKEN)
                   #:ssl? #t
                   #:method "POST"
                   #:headers (list "Content-Type: application/x-www-form-urlencoded")
                   #:data
                   (alist->form-urlencoded
                    (list (cons 'grant_type TOKEN-GRANTTYPE)
                          (cons 'client_id (azure-app-client app))
                          (cons 'device_code (oauth-deviccode-device-code device)))))])
      (when (not (http-status-OK? status))
        (raise-user-error "Failed to connect to Microsoft authentication server" host))
      )
    
     )




;; http-status-OK? : bytes? -> boolean?
;; Check whether an HTTP status is 200 OK
(define (http-status-OK? status)
  (bytes=? status #"HTTP/1.1 200 OK"))
