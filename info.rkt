#lang info

(define collection "rum")
(define version "0.2")
(define pkg-desc "Meeting room availability checker for the Turing")
(define pkg-authors '(James Geddes))

(define deps '("base"
               "gregor-lib"
               "net-lib"))

(define racket-launcher-names '("rum"))
(define racket-launcher-libraries '("rum.rkt"))
