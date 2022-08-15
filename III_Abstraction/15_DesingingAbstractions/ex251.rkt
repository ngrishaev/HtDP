;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex251) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of Number] -> Number
; computes the sum of 
; the numbers on l
(define (sum l)
  (fold1 l + 0)
  )
  
; [List-of Number] -> Number
; computes the product of 
; the numbers on l
(define (product l)
  (fold1 l * 1)
)

; [List-of ITEM] Function(ITEM -> ITEM) ITEM -> ITEM
; Computes func over list with base as result for base case
(define (fold1 list func base)
  (cond
    [(empty? list) base]
    [else
     (func (first list)
           (fold1 (rest list) func base))])
  )