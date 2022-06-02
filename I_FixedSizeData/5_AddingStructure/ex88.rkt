;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex88) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Happines is a number interval 0..100 representing happines

(define-struct VCat [xpos happines])
; An VCat is a structure:
;   (make-VCat Number Happines)
; interpretation (make-editor 100 90) describes a cat
; which is locatet at 100 x coordinate and happy at level 90
; the cursor displayed before