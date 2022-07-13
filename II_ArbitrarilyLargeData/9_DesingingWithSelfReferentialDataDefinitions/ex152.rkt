;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex152) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define SQUARE (square 10 "outline" "black"))
; N is positive Integer and Zero

; N Image -> Image
; produces a row of N instances of Image
(check-expect (row 0 SQUARE) empty-image)
(check-expect (row 1 SQUARE) SQUARE)
(check-expect (row 2 SQUARE) (beside SQUARE SQUARE))
(check-expect (row 3 SQUARE) (beside SQUARE SQUARE SQUARE))
(define (row n img)
  (cond
    [(zero? n) empty-image]
    [else (beside img (row (sub1 n) img))])
  )

; N Image -> Image
; produces a column of N instances of Image
(check-expect (col 0 SQUARE) empty-image)
(check-expect (col 1 SQUARE) SQUARE)
(check-expect (col 2 SQUARE) (above SQUARE SQUARE))
(check-expect (col 3 SQUARE) (above SQUARE SQUARE SQUARE))
(define (col n img)
  (cond
    [(zero? n) empty-image]
    [else (above img (col (sub1 n) img))])
  )