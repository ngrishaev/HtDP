;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex154) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An RD (short for Russian doll) is one of: 
; – String 
; – (make-layer String RD)

(define-struct layer [color doll])

; RD -> String
; Output Russian Doll as string
(check-expect
  (colors (make-layer "yellow" (make-layer "green" "red")))
  "yellow,green,red")
(check-expect
  (colors (make-layer "green" "red"))
  "green,red")
(check-expect
  (colors "red")
  "red")
(define (colors rd)
  (cond
    [(string? rd) rd]
    [else (string-append (layer-color rd) "," (colors (layer-doll rd)))]
   ))