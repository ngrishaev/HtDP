;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex36) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; Image -> Integer
; Calculates image area
; given (square 40 "solid" "blue") return "1600"
; given (rectangle 40 20 "solid" "blue") return "800"
(define (image-area img)
  (* (image-width img)(image-height img))
  )

(image-area (square 40 "solid" "blue"))
(image-area (rectangle 40 20 "solid" "blue"))