;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex159) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define TILE-SIZE 15)
(define TILE-COUNT-X 10)
(define TILE-COUNT-Y 20)
(define SQUARE (square TILE-SIZE "outline" "black"))
(define BALOON (circle 3 "solid" "red"))
(define SCENE (empty-scene (add1 (* TILE-SIZE TILE-COUNT-X)) (add1(* TILE-SIZE TILE-COUNT-Y))))
; N is positive Integer and Zero


(define-struct pair [balloon# lob])
; A Pair is a structure (make-pair N List-of-posns)
; A List-of-posns is one of: 
; – '()
; – (cons Posn List-of-posns)
; interpretation (make-pair n lob) means n balloons 
; must yet be thrown and added to lob

; BaloonWorld is pair
; interp.: number means how many baloons still have to be thrown and list means thrown baloons

; BaloonWorld -> BaloonWorld 
(define (main w0)
  (big-bang w0
    [on-tick tock 1]
    [to-draw to-image]))

; BaloonWorld -> BaloonWorld 
; Generate new baloon til count ends
(define (tock w)
  (cond
    [(zero? (pair-balloon# w)) w]
    [else (make-pair (sub1 (pair-balloon# w)) (cons (make-posn (random TILE-COUNT-X) (random TILE-COUNT-Y)) (pair-lob w)))]
    ))

; posn Image -> Image
; adds baloon to position "pos" on grid "grid"
(define (add-baloon pos grid)
  (place-image BALOON (+ (* (posn-x pos) TILE-SIZE) (/ TILE-SIZE 2) ) (+ (* (posn-y pos) TILE-SIZE) (/ TILE-SIZE 2) ) grid)
  )

; List-of-Posn -> Image
; Adds baloons on all posn on grid
(define (add-baloons lop)
  (cond
    [(empty? lop) (draw-grid TILE-COUNT-X TILE-COUNT-Y)]
    [else (add-baloon (first lop) (add-baloons (rest lop)))]
   ))

; BaloonWorld -> Image 
; adds each shot y on w at (XSHOTS,y} to BACKGROUND
(define (to-image w)
  (add-baloons (pair-lob w)
               ))

; N Image -> Image
; produces a row of N instances of Image
;(check-expect (row 0 SQUARE) empty-image)
;(check-expect (row 1 SQUARE) SQUARE)
;(check-expect (row 2 SQUARE) (beside SQUARE SQUARE))
;(check-expect (row 3 SQUARE) (beside SQUARE SQUARE SQUARE))
(define (row n img)
  (cond
    [(zero? n) empty-image]
    [else (beside img (row (sub1 n) img))])
  )

; N Image -> Image
; produces a column of N instances of Image
;(check-expect (col 0 SQUARE) empty-image)
;(check-expect (col 1 SQUARE) SQUARE)
;(check-expect (col 2 SQUARE) (above SQUARE SQUARE))
;(check-expect (col 3 SQUARE) (above SQUARE SQUARE SQUARE))
(define (col n img)
  (cond
    [(zero? n) empty-image]
    [else (above img (col (sub1 n) img))])
  )

; X Y -> Image
; Produces grid of size xXy
(define (draw-grid x y)
  (place-image/align (row x (col y SQUARE)) 0 0 "left" "top" SCENE))


(main (make-pair 14 '()));