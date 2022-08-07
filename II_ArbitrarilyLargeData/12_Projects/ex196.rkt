;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex196) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

; On OS X: 
(define LOCATION "./words")
; On LINUX: /usr/share/dict/words or /var/lib/dict/words
; On WINDOWS: borrow the word file from your Linux friend
 
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))
(define DICT1 (list "Test" "Word" "in" "dictionary" "wild"))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

; Letter Dictionary -> PositiveNumber
; Returns ho many words in dictionary starts with given letter
(check-expect (starts-with# "t" DICT1) 0)
(check-expect (starts-with# "d" DICT1) 1)
(check-expect (starts-with# "w" DICT1) 1)
(define (starts-with# l d)
  (cond
    [(empty? d) 0]
    [(starts-with? l (first d)) (add1 (starts-with# l (rest d)))]
    [else (starts-with# l (rest d))]
   )
  )

; Letter String -> Boolean
(check-expect (starts-with? "w" "word") #true)
(check-expect (starts-with? "w" "test") #false)
(check-expect (starts-with? "w" "") #false)
(define (starts-with? l w )
  (cond
    [(= (string-length w) 0) #false]
    [(string=? (string-ith w 0) l) #true]
    [else #false]
   )
  )

; LetterCount
; Dictionary -> List-of-LetterCounts
(define (count-by-letter d)
  )