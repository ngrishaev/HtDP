;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex267) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of Euros] -> [List-of Dollars]
(define (convert-euro loe)
  (local [
          ; Dollar to euro convertation rate
          (define DOL-TO-EUR 0.9)
          ; Dollar -> Euro
          ; Converts dollars amount into euro
          (define (convert-dol-to-eur d) (* d DOL-TO-EUR))
          ]
    (map convert-dol-to-eur loe)
    )
  )

; [List-of Fahrenheit] -> [List-of Celsius]
(define (convertFC loe)
  (local [
          ; Fahrenheit -> Celsius
          (define (convert-fahrenheit-to-celsius f) (/ (- f 32) 1.8))
          ]
    (map convert-fahrenheit-to-celsius loe)
    )
  )

; [List-of Posn] -> [List-of [List-of Number Number]]
(define (convertFC loe)
  (local [
          ; Posn -> [List-of Number Number]
          (define (convert-posn-to-pair p) (cons (posn-x p) (cons (posn-y -p) '()))
          ]
    (map convert-posn-to-pair loe)
    )
  )