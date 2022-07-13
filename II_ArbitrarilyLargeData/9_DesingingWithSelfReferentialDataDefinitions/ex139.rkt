;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex139) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-numbers is one of: 
; – '()
; – (cons Number List-of-numbers)

; List-of-numbers -> Booleans
; Determines is all numbers in list positive
(check-expect
  (pos? (cons 10 (cons 20  (cons 30 '()))))
  #true)
(check-expect
  (pos? (cons 30 '()))
  #true)
(check-expect
 (pos? (cons 10 (cons -20  (cons 30 '()))))
  #false)
(check-expect
  (pos? (cons -30 '()))
  #false)
(check-expect
  (pos? '())
  #true)

(define (pos? lon)
  (cond
    [(empty? lon) #true]
    [(<= (first lon) 0) #false]
    [else (pos? (rest lon))]
    ))

; List-of-numbers -> Integer
; Calculate sum of numbers if they are all positive
(check-error
  (checked-sum (cons -30 '()))
  "can sum only positive numbers")
(check-error
  (checked-sum (cons 10 (cons 20  (cons -30 '()))))
  "can sum only positive numbers")
(check-expect
  (checked-sum (cons 10 (cons 20  (cons 30 '()))))
  60)
(check-expect
  (checked-sum (cons 30 '()))
  30)
(check-expect
  (checked-sum '())
  0)
(define (checked-sum lon)
  (if (pos? lon)
      (sum lon)
      (error "can sum only positive numbers")
      ))


; List-of-amounts -> Integer
; Determines total amount
(check-expect
  (sum (cons 10 (cons 20  (cons 30 '()))))
  60)
(check-expect
  (sum (cons 30 '()))
  30)
(check-expect
  (sum '())
  0)

(define (sum loa)
  (cond
    [(empty? loa) 0]
    [else (+ (sum (rest loa)) (first loa))]
    )
  )
