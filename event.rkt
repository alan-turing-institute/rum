#lang racket/base

(provide
 (struct-out event))

;; start : moment?
;; end : moment? 
(struct event (start end) #:transparent)
