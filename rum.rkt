#lang racket/base

(require "oauth-deviceflow.rkt"
         "rum-config.rkt")

;; Test authentication flow

(define tk
  (oauth/deviceflow MICROSOFT-OAUTH-HOST RUM-OAUTH-ENDPOINT RUM-APP))

;; Try to read some calendar data
         
