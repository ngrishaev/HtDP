;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex257) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [X] NaturalNumber [NaturalNumber -> X] -> [List-of X]
(check-expect (build-l*st 2 add1) (list 1 2 3))
(define (build-l*st n f)
  (cond
    [(zero? n) (cons (f n) '())]
    [else (add-at-end (build-l*st (sub1 n) f) (f n))]
   ))


; [List-of X] X -> [List-of X]
; Adds p at end of list l
(define (add-at-end l p)
  (cond
    [(empty? l) (cons p '())]
    [else (cons (first l) (add-at-end (rest l) p))]
   ))