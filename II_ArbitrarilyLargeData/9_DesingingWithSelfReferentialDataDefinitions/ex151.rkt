;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex151) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; N Number -> Number
; computes (* n x) without using *
 
(check-within (multiply 3 1.54) (* 3 1.54) 0.001)
(check-within (multiply 1 1.54) (* 1 1.54) 0.001)
(check-within (multiply 0 1.54 ) 0 0.001)

(define (multiply n x)
  (cond
    [(zero? n) 0]
    [else (+ (multiply (sub1 n) x) x)]
   ))