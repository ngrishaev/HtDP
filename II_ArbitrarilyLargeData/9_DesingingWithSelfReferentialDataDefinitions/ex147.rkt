;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex147) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An NEList-of-booleans is one of: 
; – (cons boolean '())
; – (cons boolean NEList-of-booleans)
; interpretation non-empty lists of booleans

; List-of-booleans -> Boolean
; Check if is any boolean in list is true
(check-expect
  (one-true (cons #true '()))
  #true)
(check-expect
  (one-true (cons #false '()))
  #false)
(check-expect
  (one-true (cons #false (cons #false '())))
  #false)
(check-expect
  (one-true (cons #false (cons #true '())))
  #true)
(check-expect
  (one-true (cons #true (cons #false '())))
  #true)
(check-expect
  (one-true (cons #true (cons #true '())))
  #true)

(define (one-true ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [(first ne-l) #true]
    [else (one-true (rest ne-l))]
   ))

; List-of-booleans -> Boolean
; Check is every boolean in list is true
(check-expect
  (all-true (cons #true '()))
  #true)
(check-expect
  (all-true (cons #false '()))
  #false)
(check-expect
  (all-true (cons #false (cons #false '())))
  #false)
(check-expect
  (all-true (cons #false (cons #true '())))
  #false)
(check-expect
  (all-true (cons #true (cons #false '())))
  #false)
(check-expect
  (all-true (cons #true (cons #true '())))
  #true)

(define (all-true ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [(not (first ne-l)) #false]
    [else (all-true (rest ne-l))]
   ))