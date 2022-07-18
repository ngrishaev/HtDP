;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex174) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; EncodedLetter is a encoded letter
; 1String -> EncodedLetter
; converts the given 1String to a 3-letter numeric String
 
(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t")
              (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a")
              (string-append "0" (code1 "a")))
 
(define (encode-letter s)
  (cond
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10)
     (string-append "00" (code1 s))]
    [(< (string->int s) 100)
     (string-append "0" (code1 s))]))
 
; 1String -> String
; converts the given 1String into a String
(check-expect (code1 "z") "122")
(define (code1 c)
  (number->string (string->int c)))

; Word is a string representing word
; EncodedWord is a encoded word
; Letter is a string representing letter in word
; List-of-letters is represent a list of word letters
; List-of-encoded-letters is represent a list of word letters

; Word -> EncodedWord
(define (encode-w w)
  (collapse-los (encode-lol (explode w)) ""))

; List-of-letters -> List-of-encoded-letters
(define (encode-lol lol)
  (cond
    [(empty? lol) '()]
    [else (cons (encode-letter (first lol)) (encode-lol (rest lol)))]
    ))

; LOS String-> String
; Collapse LOS into one string separeted by separator
(define (collapse-los los separator)
  (cond
    [(empty? los) ""]
    [(empty? (rest los)) (first los)]
    [else (string-append (first los) separator (collapse-los (rest los) separator))]
    ))