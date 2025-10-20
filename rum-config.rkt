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

(define RUM-ROOMS
  (list
   (office-room "Margaret Hamilton"    "margarethamilton@turing.ac.uk"    "1st floor" 12)
   (office-room "Ursula Franklin"      "ursulafranklin@turing.ac.uk"      "1st floor" 6)
   (office-room "Ada Lovelace"         "adalovelace@turing.ac.uk"         "1st floor" 12)
;   (office-room "Lovelace"             "lovelace@turing.ac.uk"            "1st floor" 12)

   (office-room "Joan Clarke"          "joanclarke@turing.ac.uk"          "1st floor" 5)
   (office-room "Marian Rejewski"      "marianrejewski@turing.ac.uk"      "1st floor" 5)
   (office-room "Project Space"        "projectspace@turing.ac.uk"        "1st floor" 4)
   
   (office-room "Florence Nightingale" "florencenightingale@turing.ac.uk" "1st floor" 7)
   (office-room "Mae Jemison"          "maejemison@turing.ac.uk"          "1st floor" 7)
   (office-room "Cipher"               "cipher@turing.ac.uk"              "1st floor" 6)
   (office-room "David Blackwell"      "davidblackwell@turing.ac.uk"      "1st floor" 8)
   (office-room "Jack Good"            "jackgood@turing.ac.uk"            "1st floor" 8)

   (office-room "Mary Shelley"         "maryshelley@turing.ac.uk"         "2nd floor" 12)
   (office-room "Isaac Asimov"         "isaacasimov@turing.ac.uk"         "2nd floor" 4)
   (office-room "Helen Sharman"        "helensharman@turing.ac.uk"        "2nd floor" 4)

   ;; (office-room "ACE"                  "ace@turing.ac.uk"                 "4th floor" 4)
   ;; (office-room "Banburismus"          "banburismus@turing.ac.uk"         "4th floor" 4)
   ;; (office-room "Delilah"              "delilah@turing.ac.uk"             "4th floor" 6)
   ;; (office-room "Turingery"            "turingery@turing.ac.uk"           "4th floor" 6)

   (office-room "Arc"                  "arc-pod@turing.ac.uk"             "Pod" 2)
   (office-room "Beam"                 "beam-pod@turing.ac.uk"            "Pod" 2)
   (office-room "Core"                 "core-pod@turing.ac.uk"            "Pod" 2)
   (office-room "Echo"                 "echo-pod@turing.ac.uk"            "Pod" 2)
   (office-room "Halo"                 "halo-pod@turing.ac.uk"            "Pod" 2)
   (office-room "Logic"                "logic-pod@turing.ac.uk"           "Pod" 3)
   (office-room "Nova"                 "nova-pod@turing.ac.uk"            "Pod" 3)
   (office-room "Pixel"                "pixel-pod@turing.ac.uk"           "Pod" 1)
   (office-room "Pulse"                "pulse-pod@turing.ac.uk"           "Pod" 1)
   (office-room "Quark"                "quark-pod@turing.ac.uk"           "Pod" 1)
   (office-room "Zen"                  "zen-pod@turing.ac.uk"             "Pod" 1)
   
   
   ))



