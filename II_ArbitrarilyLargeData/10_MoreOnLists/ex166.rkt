;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex166) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct employee [name number])
; An Employee is a structure: 
;   (make-employee String Number)
; interpretation (make-employee n num) combines the name 
; n of the employee with his number num


(define-struct work [employee rate hours])
; A (piece of) Work is a structure: 
;   (make-work String Number Number)
; interpretation (make-work n r h) combines the name 
; with the pay rate r and the number of hours h

(define-struct work.v2 [employee rate hours])
; A (piece of) Work is a structure: 
;   (make-work Employee Number Number)
; interpretation (make-work e r h) combines the employee info
; with the pay rate r and the number of hours h

(define-struct paycheck [name amount])
; A Paycheck is a structure: 
;   (make-paycheck String Number)
; interpretation (make-paycheck n a) combines the name n
; for whom is check and amount of money on check a

(define-struct paycheck.v2 [employee amount])
; A Paycheck is a structure: 
;   (make-paycheck String Number)
; interpretation (make-paycheck e a) combines the employee info e
; for whom is check and amount of money on check a

; Low (short for list of works) is one of: 
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the 
; hours worked for a number of employees

; Low.v2 (short for list of works) is one of: 
; – '()
; – (cons Work.v2 Low)
; interpretation an instance of Low represents the 
; hours worked for a number of employees

; Lop (short for list of paychecks) is one of: 
; – '()
; – (cons Paycheck Lop)
; interpretation an instance of Lop represents the 
; paycheck for the employee

; Lop.v2 (short for list of paychecks) is one of: 
; – '()
; – (cons Paycheck.v2 Lop)
; interpretation an instance of Lop represents the 
; paycheck for the employee

; Low -> List-of-numbers
; computes the weekly wages for all weekly work records 
 
(check-expect
  (wage*.v2 (cons (make-work "Robby" 11.95 39) '()))
  (cons (* 11.95 39) '()))
 
(define (wage*.v2 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v2 (first an-low))
                          (wage*.v2 (rest an-low)))]))
 
; Work -> Number
; computes the wage for the given work record w
(define (wage.v2 w)
  (* (work-rate w) (work-hours w)))

; Low -> Lop
; computes the weekly wages for all weekly work records 
 
(check-expect
  (wage*.v3 (cons (make-work "Robby" 11.95 39) '()))
  (cons (make-paycheck "Robby" (* 11.95 39)) '()))

(check-expect
  (wage*.v3
   (cons (make-work "Will" 20.75 33) (cons (make-work "Robby" 11.95 39) '())))
  (cons (make-paycheck "Will" (* 20.75 33)) (cons (make-paycheck "Robby" (* 11.95 39)) '())))
 
(define (wage*.v3 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v3 (first an-low))
                          (wage*.v3 (rest an-low)))]))
 
; Work -> Paycheck
; computes the wage for the given work record w
(define (wage.v3 w)
  (make-paycheck (work-employee w) (* (work-rate w) (work-hours w))))

; Low.v2 -> Lop.v2
; computes the weekly wages for all weekly work records 
 
(check-expect
  (wage*.v4 (cons (make-work (make-employee "Robby" "12345") 11.95 39) '()))
  (cons (make-paycheck (make-employee "Robby" "12345") (* 11.95 39)) '()))

(check-expect
  (wage*.v4
   (cons (make-work (make-employee "Will" "56478") 20.75 33) (cons (make-work (make-employee "Robby" "12345") 11.95 39) '())))
  (cons (make-paycheck (make-employee "Will" "56478") (* 20.75 33)) (cons (make-paycheck (make-employee "Robby" "12345") (* 11.95 39)) '())))
 
(define (wage*.v4 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v4 (first an-low))
                          (wage*.v4 (rest an-low)))]))
 
; Work.v2 -> Paycheck.v2
; computes the wage for the given work record w
(define (wage.v4 w)
  (make-paycheck (work-employee w) (* (work-rate w) (work-hours w))))