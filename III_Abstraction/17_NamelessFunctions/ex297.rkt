;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex297) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Number Number Posn -> Number
(check-expect (distance-between 0 0 (make-posn 0 0)) 0)
(check-expect (distance-between 0 0 (make-posn 0 1)) 1)
(check-within (distance-between 0 0 (make-posn 1 1)) (sqrt 2) 0.0001)
(check-within (distance-between -1 -1 (make-posn 1 1)) (sqrt 8) 0.0001)
(define (distance-between x y p)
  (sqrt (+ (expt (- x (posn-x p)) 2) (expt (- y (posn-y p)) 2)))
  )