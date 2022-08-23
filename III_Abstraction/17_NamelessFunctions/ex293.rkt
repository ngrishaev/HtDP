;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex293) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [X] X [List-of X] -> [Maybe [List-of X]]
; returns the first sublist of l that starts
; with x, #false otherwise
(check-satisfied (find 1 (list 1 2 3)) (found? 1 (list 1 2 3)))
(check-satisfied (find 2 (list 1 2 3)) (found? 2 (list 1 2 3)))
(check-satisfied (find 3 (list 1 2 3)) (found? 3 (list 1 2 3)))
(check-satisfied (find 4 (list 1 2 3)) (found? 4 (list 1 2 3)))
(define (find x l)
  (cond
    [(empty? l) #false]
    [else
     (if (equal? (first l) x) l (find x (rest l)))]))

; [X] X [List-of X] -> [[Maybe [List-of X]] -> Boolean]
; Aswers is ml is not exists or is it first sublist of l started from x
(check-expect ((found? 2 (list 1 2 3)) (list 2 3)) #true)
(check-expect ((found? 2 (list 1 2 3 2 3)) (list 2 3)) #false)
(check-expect ((found? 2 (list 1 2 3 2 3)) (list 2 3 2 3)) #true)
(check-expect ((found? 2 (list 1 2 3)) (list 1 2 3)) #false)
(check-expect ((found? 2 (list 1 3)) #false) #true)
(check-expect ((found? 1 (list 1 3)) #false) #false)
(check-expect ((found? 2 (list 1 3)) (list 4)) #false)
(define (found? x l)
  (lambda (ml)
    (cond
      [(boolean? ml) (not (member? x l))]
      [(boolean? (index-of l (first ml))) #false]
      [(equal? (sublist l (index-of l x)) ml) #true]
      [else #false]
      )
    )
  )

; [X] [List of X] NaturalNumber -> [List of X]
; Returns sublist of l starting from ith position
(check-expect (sublist (list 1 2 3) 0) (list 1 2 3))
(check-expect (sublist (list 1 2 3) 1) (list 2 3))
(check-expect (sublist (list 1 2 3) 2) (list 3))
(define (sublist l i)
  (cond
    [(zero? i) l]
    [else (sublist (rest l) (sub1 i))]
    )
  )

; [X] [List of X] X -> [Maybe [NaturalNumber]]
; Returns index of first occurence of element x in list l
(check-expect (index-of (list 1 2 3) 1) 0)
(check-expect (index-of (list 1 2 3) 2) 1)
(check-expect (index-of (list 1 2 3) 3) 2)
(check-expect (index-of (list 1 2 3) 4) #false)
(define (index-of l x)
  (local
    [
     ; Search element x in list l in position pos
     (define (search l x pos)
       (cond
         [(empty? l) #false]
         [(eq? x (first l)) pos]
         [else (search (rest l) x (add1 pos))]
         )
       )
     ]
    (search l x 0)))