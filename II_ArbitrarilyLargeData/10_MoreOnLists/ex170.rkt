;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex170) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct phone [area switch four])
; A Phone is a structure: 
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999. 
; A Four is a Number between 1000 and 9999.

; List-of-phones -> List-of-phones
(check-expect (replace
               (cons (make-phone 100 100 5555) (cons (make-phone 713 100 5555) '())))
              (cons (make-phone 100 100 5555) (cons (make-phone 281 100 5555) '())))
(define (replace lop)
  (cond
    [(empty? lop) '()]
    [(= (phone-area (first lop)) 713) (cons (make-phone 281 (phone-switch (first lop)) (phone-four (first lop))) (replace (rest lop)))]
    [else (cons (first lop) (replace (rest lop)))]
   ))
