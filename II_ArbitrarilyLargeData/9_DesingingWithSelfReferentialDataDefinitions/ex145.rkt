;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex145) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures

(define ABSOLUTE0 -272)
; A CTemperature is a Number greater than ABSOLUTE0.


; NEList-of-temperatures -> Boolean
; Aswers if the temperatures are sorted in descending order
(check-expect
  (sorted>? (cons 1 (cons 2 (cons 3 '())))) #false)
(check-expect
  (sorted>? (cons 3 (cons 2 (cons 1 '())))) #true)
(check-expect
  (sorted>? (cons 1 '())) #true)

(define (sorted>? ne-l)
  (cond
    [(empty? (rest ne-l)) #true]
    [(> (second ne-l) (first ne-l)) #false]
    [else (sorted>? (rest ne-l))]
   ))

