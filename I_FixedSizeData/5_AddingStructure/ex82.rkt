;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex82) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 1LorN is one of:
;    - 1String "a".."z"
;    - #false

(define-struct 3LWord [l1 l2 l3])
; 3LWord is a structure:
;    (make-3LWord 1LorN-first 1LorN-second 1LorN-third)
; interpretation
; 3LWord is a 3 letter word, where each letter on range 'a'..'z' or #false
;    (make-3LWord "a" "b" "c") - is a 3 letter word "abc".


; 1LorN 1LorN -> Boolean
; Compare two 1LorN. Return true if they are equialent
(check-expect (1LorN=? "a" "a") #true)
(check-expect (1LorN=? "a" "z") #false)
(check-expect (1LorN=? "a" #false) #false)
(check-expect (1LorN=? #false #false) #true)
(define (1LorN=? l1 l2)
  (cond
    [(string? l1)
     (and (string? l2) (string=? l1 l2))
     ]
    [(and (boolean? l1) (boolean=? l1 #false))
          (and (boolean? l2) (boolean=? l1 l2))
     ])
  )

; 3LWord 3LWord -> Boolean
; Compare two 1LorN. Return true if they are equialent
(check-expect (3LWord=? (make-3LWord "a" "b" "c") (make-3LWord "a" "b" "c")) #true)
(check-expect (3LWord=? (make-3LWord "a" "b" "c") (make-3LWord "a" "b" #false)) #false)
(check-expect (3LWord=? (make-3LWord "a" "b" #false) (make-3LWord "a" "b" #false)) #true)
(define (3LWord=? w1 w2)
  (and  (1LorN=? (3LWord-l1 w1) (3LWord-l1 w2))
        (1LorN=? (3LWord-l2 w1) (3LWord-l2 w2))
        (1LorN=? (3LWord-l3 w1) (3LWord-l3 w2))
   )
  )
