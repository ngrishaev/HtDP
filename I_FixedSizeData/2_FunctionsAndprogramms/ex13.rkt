;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (string-empty? str)
  (if (= (string-length str) 0)
      #true
      #false
      )
  )

(define (string-!empty? str) (not (string-empty? str)))

(define (string-first str)
  (if (string-!empty? str)
      (string-ith str 0)
      str
      )
  )

(string-first "123")
(string-first "1")
(string-first "")