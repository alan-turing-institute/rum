#lang racket/base

(require (only-in  "azure.rkt" azure-app)
         (only-in "meeting.rkt" office-room)
         net/url)

;; Configuration data for the rum application as registered with the Turing AD instance

(provide RUM-APP
         RUM-ROOMS
)

;; --------------------------------------------------------------------------------------------------

(define RUM-APP
  (azure-app
   "4395f4a7-e455-4f95-8a9f-1fbaef6384f9" ; Tenant id
   "a462354f-fd23-4fdf-94f5-5cce5a6c27c7" ; Client id
   '("Calendars.Read.Shared")))           ; Permissions

;; Calendars (with capacity)

;; 1st floor

(define RUM-ROOMS
  (list
   (office-room "Margaret Hamilton"    "margarethamilton@turing.ac.uk"    "1st floor" 6)
   (office-room "Augusta Ada"          "augusta@turing.ac.uk"             "1st floor" 20)
   (office-room "Lovelace"             "lovelace@turing.ac.uk"            "1st floor" 8)
   (office-room "Ursula Franklin"      "ursulafranklin@turing.ac.uk"      "1st floor" 4)
   (office-room "Florence Nightingale" "florencenightingale@turing.ac.uk" "1st floor" 2)
   (office-room "David Blackwell"      "davidblackwell@turing.ac.uk"      "1st floor" 8)
   (office-room "Jack Good"            "jackgood@turing.ac.uk"            "1st floor" 8)

   (office-room "Mary Shelley"         "maryshelley@turing.ac.uk"         "2nd floor" 8)
   (office-room "Isaac Asimov"         "isaacasimov@turing.ac.uk"         "2nd floor" 4)

   (office-room "ACE"                  "ace@turing.ac.uk"                 "4th floor" 4)
   (office-room "Banburismus"          "banburismus@turing.ac.uk"         "4th floor" 4)
   (office-room "Delilah"              "delilah@turing.ac.uk"             "4th floor" 4)
   (office-room "Turingery"            "turingery@turing.ac.uk"           "4th floor" 4)))



