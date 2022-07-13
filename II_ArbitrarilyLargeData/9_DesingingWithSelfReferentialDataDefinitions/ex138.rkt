;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex138) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-amounts is one of: 
; – '()
; – (cons PositiveNumber List-of-amounts)

; List-of-amounts -> Integer
; Determines total amount
(check-expect
  (sum (cons 10 (cons 20  (cons 30 '()))))
  60)
(check-expect
  (sum (cons 30 '()))
  30)
(check-expect
  (sum '())
  0)

(define (sum loa)
  (cond
    [(empty? loa) 0]
    [else (+ (sum (rest loa)) (first loa))]
    )
  )

