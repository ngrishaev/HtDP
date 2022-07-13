;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex150) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; N is positive Integer and zero

; N -> Number
; computes (+ n pi) without using +
 
(check-within (add-to-pi 3) (+ 3 pi) 0.001)
(check-within (add-to-pi 1) (+ 1 pi) 0.001)
(check-within (add-to-pi 0) pi 0.001)

 
(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [else (add1 (add-to-pi (sub1 n)))]
   ))

; N Number -> Number
; computes (+ n x) without using +
 
(check-within (add 3 1.54) (+ 3 1.54) 0.001)
(check-within (add 1 1.54) (+ 1 1.54) 0.001)
(check-within (add 0 1.54 ) 1.54 0.001)

(define (add n x)
  (cond
    [(zero? n) x]
    [else (add1 (add (sub1 n) x))]
   ))