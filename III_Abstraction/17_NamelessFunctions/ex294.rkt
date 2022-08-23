;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex294) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [X] X [List-of X] -> [Maybe N]
; determine the index of the first occurrence
; of x in l, #false otherwise
(check-satisfied (index 4 (list 1 2 3)) (is-index? 4 (list 1 2 3)))
(check-satisfied (index 3 (list 1 2 3)) (is-index? 3 (list 1 2 3)))
(check-satisfied (index 2 (list 1 2 3)) (is-index? 2 (list 1 2 3)))
(check-satisfied (index 1 (list 1 2 3)) (is-index? 1 (list 1 2 3)))
(check-satisfied (index 0 (list 1 2 3)) (is-index? 0 (list 1 2 3)))
(define (index x l)
  (cond
    [(empty? l) #false]
    [else (if (equal? (first l) x)
              0
              (local ((define i (index x (rest l))))
                (if (boolean? i) i (+ i 1))))]))

; [X] X [List-of X] -> [[Maybe N] -> Boolean]
(check-expect ((is-index? 1 (list 1 2 3)) 0) #true)
(check-expect ((is-index? 1 (list 1 2 3)) #false) #false)
(check-expect ((is-index? 2 (list 1 2 3)) 1) #true)
(check-expect ((is-index? 3 (list 1 2 3)) 2) #true)
(check-expect ((is-index? 1 (list 1 2 3)) 2) #false)
(check-expect ((is-index? 4 (list 1 2 3)) #false) #true)
(check-expect ((is-index? 4 (list 1 2 3)) 4) #false)
(check-expect ((is-index? 4 (list 1 2 3)) -1) #false)
(define (is-index? x l)
  (local [
          (define (search l0 from)
            (cond
              [(empty? l0) #false]
              [(equal? (first l0) x) #true]
              [(zero? from) #false]
              [else (search (rest l0) (sub1 from))]             
              ))
          ]
    (lambda (mn)
      (cond
        [(boolean? mn) (not (member? x l))]
        [(< mn 0) #false]
        [(> mn (length l)) #false]
        [(not (eq? (list-ref l mn) x)) #false]
        [else (search l mn)]
        )
      )
    )
  )