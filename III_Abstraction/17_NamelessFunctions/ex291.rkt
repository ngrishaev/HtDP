;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex291) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [Number -> Number] -> [List of Number]
; [X Y] [X -> Y] [List of X] -> [List of Y]
(check-expect (map-via-fold f (list 1 2 3)) (list 1 2 3))
(check-expect (map-via-fold f1 (list 1 2 3)) (list 2 4 6))
(define (map-via-fold fu l)
  (foldr (lambda (x base) (cons (fu x) base)) '() l))