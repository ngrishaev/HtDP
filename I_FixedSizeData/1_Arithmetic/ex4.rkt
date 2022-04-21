;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define str "helloworld")
(define hel "0123456789")
(define i 5)

(define firstHalf (substring str 0 i))
(define secondHalf (substring str (+ i 1) (string-length str)))
firstHalf
secondHalf
(define result (string-append firstHalf secondHalf))
result