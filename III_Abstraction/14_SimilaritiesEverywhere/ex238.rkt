;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex238) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define LIST1 (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
(define LIST2 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25))

; Nelon -> Number
; determines the largest number on l
(define (sup l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (if (> (first l)
            (sup (rest l)))
         (first l)
         (sup (rest l)))]))

; Nelon -> Number
; determines the largest number on l
(define (sup-max l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (max (first l) (sup-max (rest l)))]
    ))
    

; Nelon -> Number
; determines the largest number on l
(check-expect (best-fit > LIST1) (sup LIST1))
;(check-expect (best-fit > LIST2) (sup LIST2))
(define (sup-1 l)
  (best-fit > l)
  )

; Nelon -> Number
; determines the largest number on l
(check-expect (best-fit > LIST1) (sup LIST1))
;(check-expect (best-fit > LIST2) (sup LIST2))
(define (sup-2 l)
  (best-fit.v2 max l)
  )

; Nelon -> Number
; determines the smallest number on l
(define (inf l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (if (< (first l)
            (inf (rest l)))
         (first l)
         (inf (rest l)))])
  )

; Nelon -> Number
; determines the smallest number on l
(define (inf-min l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (min (first l) (inf-min (rest l)))]
    ))

; Nelon -> Number
; determines the smallest number on l
;(check-expect (best-fit < LIST1) (inf LIST1))
(check-expect (best-fit < LIST2) (inf LIST2))
(define (inf-1 l)
  (best-fit < l)
  )

; Nelon -> Number
; determines the smallest number on l
(check-expect (best-fit < LIST1) (inf LIST1))
(check-expect (best-fit < LIST2) (inf LIST2))
(define (inf-2 l)
  (best-fit.v2 min l)
  )

; Function Nelon -> Number
; Select number based on function f
(define (best-fit f l)
  (cond
    [(empty? (rest l)) (first l)]
    [(f (first l) (best-fit f (rest l))) (first l)]
    [else (best-fit f (rest l))]
    )
  )

; Function Nelon -> Number
; Select number based on function f
(define (best-fit.v2 f l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (f (first l) (best-fit.v2 (rest l)))]
    ))

