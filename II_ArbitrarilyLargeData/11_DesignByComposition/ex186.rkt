;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex186) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures

(define ABSOLUTE0 -272)
; A CTemperature is a Number greater than ABSOLUTE0.


; NEList-of-temperatures -> Boolean
; Aswers if the temperatures are sorted in descending order
(check-expect
  (sorted>? (cons 1 (cons 2 (cons 3 '())))) #false)
(check-expect
  (sorted>? (cons 3 (cons 2 (cons 1 '())))) #true)
(check-expect
  (sorted>? (cons 1 '())) #true)

(define (sorted>? ne-l)
  (cond
    [(empty? (rest ne-l)) #true]
    [(> (second ne-l) (first ne-l)) #false]
    [else (sorted>? (rest ne-l))]
   ))



; List-of-numbers -> List-of-numbers 
; rearranges alon in descending order
 
(check-expect (sort> '()) '())
(check-satisfied (sort> (list 3 2 1)) sorted>?)
(check-satisfied (sort> (list 1 2 3)) sorted>?)
(check-satisfied (sort> (list 12 20 -5))
              sorted>?)
 
(define (sort> alon)
  (cond
    [(empty? alon) '()]
    [else
     (insert (first alon) (sort> (rest alon)))]))


; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers alon
(check-satisfied (insert 5 '()) sorted>?)
(check-satisfied (insert 5 (list 6)) sorted>?)
(check-satisfied (insert 5 (list 4)) sorted>?)
(check-satisfied (insert 12 (list 20 -5))
              sorted>?)

(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [(>= n (first l)) (cons n l)]
    [else (cons (first l) (insert n (rest l)))]
    ))
    
