;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex14) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (string-empty? str)
  (if (= (string-length str) 0)
      #true
      #false
      )
  )

(define (string-!empty? str) (not (string-empty? str)))

(define (string-last str)
  (if (string-!empty? str)
      (string-ith str (- (string-length str) 1))
      str
      )
  )

(string-last "123")
(string-last "1")
(string-last "")