;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex172) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-strings is one of
; - '()
; (cons String List-of-strings)

(define los1 (cons "Hello" (cons "world!" '())))
(define los2 (cons "Another" (cons "test" (cons "string" '()))))

; LLN (List of lines) is one of
; - '()
; (cons List-of-strings LLN)

(define LLN (cons los1 (cons los2 '())))


; LLN -> String
; Collapse LLN into one string

(check-expect (collapse LLN) "Hello world!\nAnother test string\n")

(define (collapse lln)
  (cond
    [(empty? lln) ""]
    [else (string-append (collapse-los (first lln)) "\n" (collapse (rest lln)))]
   ))


; LOS -> String
; Collapse LOS into one string
(check-expect (collapse-los los1) "Hello world!")
(check-expect (collapse-los los2) "Another test string")
(define (collapse-los los)
  (cond
    [(empty? los) ""]
    [(empty? (rest los)) (first los)]
    [else (string-append (first los) " " (collapse-los (rest los)))]
    ))

             

