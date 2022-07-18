;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex164) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Euro is a Number
; Represent currency in Europe

; A List-of-Euro is one of: 
; – '()
; – (cons Euro List-of-posns)

; Dollar is a Number
; Represent currency in US

; A List-of-Dollar is one of: 
; – '()
; – (cons Dollar List-of-posns)

; List-of-Euro -> List-of-Dollar
; Converts euro to dollar with rate 0.8
(check-expect (convert-euro (cons 1 (cons 10 '())))
              (cons 0.8 (cons 8 '())))
(define (convert-euro lof)
  (cond
    [(empty? lof) '()]
    [else (cons (* (first lof) 0.8) (convert-euro (rest lof)))]
   ))

; EDRate
; Exchange rate for euro -> dollar

(define RATE 0.8)

; List-of-Euro EDRate -> List-of-Dollar
; Converts euro to dollar with given rate
(check-expect (convert-euro* (cons 1 (cons 10 '())) RATE)
              (cons 0.8 (cons 8 '())))
(define (convert-euro* lof rate)
  (cond
    [(empty? lof) '()]
    [else (cons (* (first lof) rate) (convert-euro (rest lof)))]
   ))