;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex142) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
; A List-of-images is one of: 
; – '()
; – (cons Image List-of-images)

; ImageOrFalse is one of:
; – Image
; – #false 

; NaturalNumber List-of-images -> ImageOrFalse
; Return first image from loi that doesnt have size nXn
; If list doesnt conent such image function returns #false

(check-expect (ill-sized? 70
               (cons (square 65 "solid" "blue") '()))
              (square 65 "solid" "blue"))
(check-expect (ill-sized? 65
               (cons (square 65 "solid" "blue") '()))
              #false)
(check-expect (ill-sized? 65
               '())
              #false)
(define (ill-sized? n loi)
  (cond
    [(empty? loi) #false]
    [(or (!= n (image-width (first loi)))(!= n (image-height (first loi)))) (first loi)]
    [else (ill-sized? n (rest loi))]
   )
  )

(define (!= x y)
  (not (= x y))
  )