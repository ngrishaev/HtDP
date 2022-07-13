;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex140) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

(define (all-true lob)
  (cond
    [(empty? lob) #true]
    [(not (first lob)) #false]
    [else (all-true (rest lob))]
    ))

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

(define (one-true lob)
  (cond
    [(empty? lob) #false]
    [(first lob) #true]
    [else (one-true (rest lob))]
    ))

