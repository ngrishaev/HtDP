;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex190) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (prefixes (list "a" "b" "c" "d"))
              (list (list "a" "b" "c" "d") (list "a" "b" "c") (list "a" "b") (list "a"))
              )
(define (prefixes los)
  (cond
    [(empty? los) '()]
    [else (cons los (prefixes (remove-last los)))]   
  ))

(define (remove-last los)
  (cond
    [(empty? los) '()]
    [(empty? (rest los)) '()]
    [else (cons (first los) (remove-last (rest los)))]
    ))


(check-expect (suffixes (list "a" "b" "c" "d"))
              (list (list "a" "b" "c" "d") (list "b" "c" "d") (list "c" "d") (list "d"))
              )
(define (suffixes los)
  (cond
    [(empty? los) '()]
    [else (cons los (suffixes (rest los)))]   
  ))