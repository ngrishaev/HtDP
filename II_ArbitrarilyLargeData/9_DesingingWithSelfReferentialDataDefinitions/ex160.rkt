;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex160) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Son - Set of numbers
; Son is used when it 
; applies to Son.L and Son.R

; A Son.L is one of: 
; – empty 
; – (cons Number Son.L)  

; A Son.R is one of: 
; – empty 
; – (cons Number Son.R)
; 
; Constraint If s is a Son.R, 
; no number occurs twice in s

; Son
(define es '())
 
; Number Son -> Boolean
; is x in s
(define (in? x s)
  (member? x s))

; Number Son.L -> Son.L
; removes x from s 
(define s1.L
  (cons 1 (cons 1 '())))
 
(check-expect
  (set-.L 1 s1.L) es)
 
(define (set-.L x s)
  (remove-all x s))

; Number Son.R -> Son.R
; removes x from s
(define s1.R
  (cons 1 '()))
 
(check-expect
  (set-.R 1 s1.R) es)
 
(define (set-.R x s)
  (remove x s))


; Number Son.L -> Son.L
; removes x from s 
(define s2.L
  (cons 1 (cons 1 '())))
(define s3.L
  (cons 3 (cons 1 (cons 1 '()))))
(define s4.L
  (cons 1 (cons 3 (cons 1 (cons 1 '())))))
 
(check-expect
  (set+.L 3 s2.L) s3.L)
(check-expect
  (set+.L 1 s3.L) s4.L)

(define (set+.L x s)
  (cons x s)
  )


; Number Son.R -> Son.R
; removes x from s
(define s2.R
  (cons 1 '()))
(define s3.R
  (cons 2 (cons 1 '())))
(define s4.R
  (cons 3 (cons 2 (cons 1 '()))))
 
(check-expect
  (set+.R 1 s2.R) s2.R)
(check-expect
  (set+.R 2 s2.R) s3.R)
 
(define (set+.R x s)
  (cond
    [(in? x s) s]
    [else (cons x s)]
    ))
