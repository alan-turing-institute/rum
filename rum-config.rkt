#lang racket/base

(require "azure.rkt"
         net/url)

;; Configuration data for the rum application as registered with the Turing AD instance

(provide RUM-APP
         RUM-OAUTH-ENDPOINT
         MICROSOFT-OAUTH-HOST
)

;; --------------------------------------------------------------------------------------------------

(define RUM-APP
  (azure-app
   "4395f4a7-e455-4f95-8a9f-1fbaef6384f9" ; Tenant id
   "a462354f-fd23-4fdf-94f5-5cce5a6c27c7" ; Client id
   '("Bookings.Read.All")))               ; Permissions

(define RUM-OAUTH-ENDPOINT
  (string-append "/"
                 (azure-app-tenant RUM-APP)
                 "/oauth2/v2.0"))

(define MICROSOFT-OAUTH-HOST "login.microsoftonline.com")


