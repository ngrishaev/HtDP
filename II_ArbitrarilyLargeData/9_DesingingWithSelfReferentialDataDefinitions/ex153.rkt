;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex153) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define TILE-SIZE 15)
(define TILE-COUNT-X 10)
(define TILE-COUNT-Y 20)
(define SQUARE (square TILE-SIZE "outline" "black"))
(define BALOON (circle 3 "solid" "red"))
(define SCENE (empty-scene (add1 (* TILE-SIZE TILE-COUNT-X)) (add1(* TILE-SIZE TILE-COUNT-Y))))
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

; X Y -> Image
; Produces grid of size xXy
(define (draw-grid x y)
  (place-image/align (row x (col y SQUARE)) 0 0 "left" "top" SCENE))

; NotEmpty-List-of-Posn is one of:
; - (cons posn '())
; - (cons posn NotEmpty-List-of-Posn)
; interp.: not empty list of posn
 
; NotEmpty-List-of-Posn -> Image
; Adds baloons on all posn on grid
(define (add-baloons nelop)
  (cond
    [(empty? (rest nelop)) (add-baloon (first nelop) (draw-grid TILE-COUNT-X TILE-COUNT-Y))]
    [else (add-baloon (first nelop) (add-baloons (rest nelop)))]
   ))


; posn -> Image
; adds baloon to posn on grid
(define (add-baloon pos grid)
  (place-image BALOON (* (posn-x pos) TILE-SIZE) (* (posn-y pos) TILE-SIZE) grid)
  )

(add-baloons (cons (make-posn 2 2) (cons (make-posn 1 1) '())))








