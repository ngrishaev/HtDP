;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex252) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

; graphical constants:    
(define emt
  (empty-scene 100 100))
(define dot
  (circle 3 "solid" "red"))

; [List-of Number] -> Number
(define (product l)
  (cond
    [(empty? l) 1]
    [else
     (* (first l)
        (product
          (rest l)))])
  )

; [List-of Number] -> Number
(define ln1 '())
(define ln2 (list 1))
(define ln3 (list 1 2 3 4))
(define ln4 (list 0 1 2 3 4))
(check-expect (product.v2 ln1) (product ln1))
(check-expect (product.v2 ln2) (product ln2))
(check-expect (product.v2 ln3) (product ln3))
(check-expect (product.v2 ln4) (product ln4))
(define (product.v2 l)
  (fold2 l * 1)
  )
  

; [List-of Posn] -> Image
(define (image* l)
  (cond
    [(empty? l) emt]
    [else
     (place-dot
      (first l)
      (image* (rest l)))])
  )

; [List-of Posn] -> Image
(define l1 '())
(define l2 (list (make-posn 0 0)))
(define l3 (list (make-posn 0 0) (make-posn 7 13)))
(check-expect (image*.v2 l1) (image* l1))
(check-expect (image*.v2 l2) (image* l2))
(check-expect (image*.v2 l3) (image* l3))
(define (image*.v2 l)
  (fold2 l place-dot emt)
  )
 
; Posn Image -> Image 
(define (place-dot p img)
  (place-image
     dot
     (posn-x p) (posn-y p)
     img))


; [List-of X] Function(X -> Y) Y -> Y
; Computes func over list with base as result for base case
(define (fold2 list func base)
  (cond
    [(empty? list) base]
    [else
     (func (first list)
           (fold2 (rest list) func base))])
  )
 

