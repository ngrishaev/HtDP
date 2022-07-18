;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex163) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Farenheit is a Number
; Represent temperature in Farenheit

; A List-of-Farenheit is one of: 
; – '()
; – (cons Farenheit List-of-posns)

; Celsius is a Number
; Represent temperature in Celsius

; A List-of-Celsius is one of: 
; – '()
; – (cons Celsius List-of-posns)


; List-of-Farenheit -> List-of-Celsius
; Converts farenheit into celsius
(check-expect (convertFC
               (cons 32 (cons 104 (cons 41 '()))))
              (cons 0 (cons 40 (cons 5 '())))
              )
(define (convertFC lof)
  (cond
    [(empty? lof) '()]
    [else (cons (* (- (first lof) 32) (/ 5 9)) (convertFC (rest lof)))]
    )
  )