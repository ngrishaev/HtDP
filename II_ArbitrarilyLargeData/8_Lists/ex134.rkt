#lang racket

; String A-List-Of-Strings -> Boolean
; determines whenewer s occurs on alos
(check-expect (contains? '()) #false)
(define (contains? s alos)
  #false)