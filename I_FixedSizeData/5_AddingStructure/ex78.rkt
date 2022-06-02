;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex78) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 1LorN is one of:
;    - 1String "a".."z"
;    - #false

(define-struct 3LWord [l1 l2 l3])
; 3LWord is a structure:
;    (make-3LWord 1LorN-first 1LorN-second 1LorN-third)
; interpretation
; 3LWord is a 3 letter word, where each letter on range 'a'..'z' or #false
;    (make-3LWord "a" "b" "c") - is a 3 letter word "abc".

