;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex188) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct email [from date message])
; An Email Message is a structure: 
;   (make-email String Number String)
; interpretation (make-email f d m) represents text m 
; sent by f, d seconds after the beginning of time

; List-of-emails
; is one of
; '()
; (cons Email List-of-emails)

; Sorts list of emails by their score
; List-of-emails -> List-of-emails
(check-expect (sort-email> (list (make-email "a" 5 "world!") (make-email "b" 1 "Hello ") (make-email "c" 10 "Test")))
              (list (make-email "c" 10 "Test") (make-email "a" 5 "world!") (make-email "b" 1 "Hello "))
              )
(define (sort-email> loe)
  (cond
    [(empty? loe) '()]
    [else (insert-email (first loe) (sort-email> (rest loe)))]))

; Insert email into sorted list of emails
(define (insert-email e loe)
  (cond
    [(empty? loe) (cons e '())]
    [(email>= e (first loe)) (cons e loe)]
    [else (cons (first loe) (insert-email e (rest loe)))]
   ))

(define (email>= e1 e2)
  (>= (email-date e1) (email-date e2)
  ))
