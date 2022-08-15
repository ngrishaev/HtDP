;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex250) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Number -> [List-of Number]
; tabulates sin between n 
; and 0 (incl.) in a list
(define (tab-sin n)
  (tabulate n tan)
  )
  

; Number -> [List-of Number]
; tabulates sqrt between n 
; and 0 (incl.) in a list
(define (tab-sqrt n)
  (tabulate n sqrt)
  )

; Number Function -> [List-of-Number]
; tabulates g over 0..n numbers and resturn result as list
(define (tabulate n f)
  (cond
    [(= n 0) (list (sqrt 0))]
    [else
     (cons
      (f n)
      (tabulate f (sub1 n)))])  
  )