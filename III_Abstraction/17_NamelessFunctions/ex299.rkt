;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex299) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Set is a function: 
;   [Number -> Boolean]
; interpretation if s is a set and n a Number, (s n) 
; produces #true if n is in s, #false otherwise

(define odd-set (lambda(p) (odd? p)))
(define even-set (lambda(p) (even? p)))
(define divisible-by-ten (lambda(p) (= (modulo p 10) 0)))

; Number Set -> Set
; Add number to set
(define (add-element s e)
  (lambda (p) (or (= p e) (s p))
    ))

; Set Set -> Set
; Union two sets
(define (union s1 s2)
  (lambda (p) (or (s1 p) (s2 p))
    ))

; Set Set -> Set
; Intersection of two sets
(define (union s1 s2)
  (lambda (p) (and (s1 p) (s2 p))
    ))