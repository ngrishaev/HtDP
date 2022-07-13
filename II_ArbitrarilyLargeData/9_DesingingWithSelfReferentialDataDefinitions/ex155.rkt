;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex155) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An RD (short for Russian doll) is one of: 
; – String 
; – (make-layer String RD)

(define-struct layer [color doll])

; RD -> String
; Extracts innermost doll color
(check-expect
  (inner (make-layer "yellow" (make-layer "green" "red")))
  "red")
(check-expect
  (inner (make-layer "green" "red"))
  "red")
(check-expect
  (inner "red")
  "red")

(define (inner rd)
  (cond
    [(string? rd) rd]
    [else (inner (layer-doll rd))]
   ))