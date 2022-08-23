;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex295) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define WIDTH 300)
(define HEIGHT 300)
 
; N -> [List-of Posn]
; generates n random Posns in [0,WIDTH) by [0,HEIGHT)
(check-satisfied (random-posns 3) (n-inside-playground? 3))
(check-satisfied (random-posns 0) (n-inside-playground? 0))
(check-satisfied (random-posns 1000) (n-inside-playground? 1000))
(define (random-posns n)
  (build-list
    n
    (lambda (i)
      (make-posn (random WIDTH) (random HEIGHT)))
    ))

; N -> [[List of Posn] -> Boolean]
(check-expect ((n-inside-playground? 0) '()) #true)
(check-expect ((n-inside-playground? 0) (list (make-posn 1 1))) #false)
(check-expect ((n-inside-playground? 1) (list (make-posn 1 1))) #true)
(check-expect ((n-inside-playground? 4) (list (make-posn 0 0) (make-posn 0 (sub1 HEIGHT)) (make-posn (sub1 WIDTH) 0) (make-posn (sub1 WIDTH) (sub1 HEIGHT)))) #true)
(check-expect ((n-inside-playground? 3) (list (make-posn 0 0) (make-posn 0 (sub1 HEIGHT)) (make-posn (sub1 WIDTH) 0) (make-posn (sub1 WIDTH) (sub1 HEIGHT)))) #false)
(check-expect ((n-inside-playground? 4) (list (make-posn 0 0) (make-posn 0 (sub1 HEIGHT)) (make-posn (sub1 WIDTH) 0) (make-posn (sub1 WIDTH) HEIGHT))) #false)
(define (n-inside-playground? n)
  (local [
          ; posn -> boolean
          (define (inside-playground p)
            (and (>= (posn-x p) 0)
                 (>= (posn-y p) 0)
                 (< (posn-x p) WIDTH)
                 (< (posn-y p) HEIGHT))
            )
          ]
    (lambda (lop)
      (cond
        [(!= n (length lop)) #false]
        [else (andmap inside-playground lop)]
        )
      )))


(define (!= x y)
  (not (eq? x y))
  )