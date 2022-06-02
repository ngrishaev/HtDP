;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex64) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; pos -> number
; How many distance need to travel only be horizontal or vertical lines
(check-expect (manhattan-distance (make-posn 5 5)) 10)
(check-expect (manhattan-distance (make-posn 0 0)) 0)
(check-expect (manhattan-distance (make-posn 5 0)) 5)
(check-expect (manhattan-distance (make-posn 0 5)) 5)
(define (manhattan-distance pos)
  (+ (posn-x pos) (posn-y pos)
     )
  )