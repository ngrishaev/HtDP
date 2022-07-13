;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex134) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; String A-List-Of-Strings -> Boolean
; determines whenewer s occurs on alos
(check-expect (contains? "test" '()) #false)
(check-expect
  (contains? "test" (cons "X" (cons "Y"  (cons "Z" '()))))
  #false)
(check-expect
  (contains? "test" (cons "A" (cons "test" (cons "C" '()))))
  #true)
(check-expect
  (contains? "test" (cons "test" '()))
  #true)
(check-expect
  (contains? "test" (cons "tes" '()))
  #false)


(define (contains? s alos)
  (cond
    [(empty? alos) #false]
    [(string=? s (first alos)) #true]
    [else (contains? s (rest alos))]
   )
  )