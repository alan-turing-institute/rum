#lang racket/base

;; Facilities for dealing with events

(provide
 (struct-out event))

;; start : moment?
;; end : moment? 
(struct event (start end) #:transparent)
