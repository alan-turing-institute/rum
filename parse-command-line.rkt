#lang racket/base

;; Convert the date specified on the command line to a date?

(require gregor
         racket/match)

(provide parse-command-line-date)

;; string? -> date?
(define (parse-command-line-date dt)
  (let ([dt-norm (string-downcase dt)])
    (match dt-norm
      [(regexp #rx"(sun|mon|tue|wed|thu|fri|sat).*")            (parse/weekday dt-norm)]
      [(regexp #rx"[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]") (parse/iso-8601 dt-norm)]
      [(regexp #rx"[0-9]+")                                     (parse/day dt-norm)]
      [_ (raise-user-error "Date argument not understood.")])))

;; Parse dt as the name of the day of the week, interpreted as the next such date
(define (parse/weekday dt)
  (let ([weekday (car (regexp-match #rx":mon|tue|wed|thu|fri|sat|sun" dt))])
    (match weekday
      ["sun" (the-next-day 0)]
      ["mon" (the-next-day 1)]
      ["tue" (the-next-day 2)]
      ["wed" (the-next-day 3)]
      ["thu" (the-next-day 4)]
      ["fri" (the-next-day 5)]
      ["sat" (the-next-day 6)])))

;; Parse dt as an ISO-8601 date
(define (parse/iso-8601 dt)
  (let ([dts (regexp-match #rx"([0-9][0-9][0-9][0-9])-([0-9][0-9])-([0-9][0-9])" dt)])
    (let ([yr (string->number (cadr dts))]
          [mn (string->number (caddr dts))]
          [dy (string->number (cadddr dts))])
      (date yr mn dy))))

;; Parse dt as the day of the month, interpreted as the current month
(define (parse/day dt)
  (let ([dy (string->number dt)])
    (date (->year (today)) (->month (today)) dy)))

;; 0..6 -> date?
;; Find the next date that falls on a given day of the week
;; 0 = Sunday, ...
(define (the-next-day weekday)
  (define days-forward
    (let ([d (modulo (- weekday (->wday (today))) 7)])
      (if (zero? d)
          7
          d)))
  (+days (today) days-forward))
