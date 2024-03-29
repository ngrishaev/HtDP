;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex143) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-temperatures is one of: 
; – '()
; – (cons CTemperature List-of-temperatures)
 
(define ABSOLUTE0 -272)
; A CTemperature is a Number greater than ABSOLUTE0.

; List-of-temperatures -> Number
; computes the average temperature
(check-expect
  (average (cons 1 (cons 2 (cons 3 '())))) 2)

(define (average alot)
  (/ (sum alot) (how-many alot)))

(check-expect
  (checked-average (cons 1 (cons 2 (cons 3 '())))) 2)
(check-error
  (checked-average '())
  "Cant compute average on empty list")
(define (checked-average alot)
  (cond
    [(empty? alot) (error "Cant compute average on empty list")]
    [else (average alot)]))
 
; List-of-temperatures -> Number 
; adds up the temperatures on the given list 
(define (sum alot)
  (cond
    [(empty? alot) 0]
    [else (+ (first alot) (sum (rest alot)))]))
 
; List-of-temperatures -> Number 
; counts the temperatures on the given list 
(define (how-many alot)
  (cond
    [(empty? alot) 0]
    [else (add1 (how-many (rest alot)))]
  ))