;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex281) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
((lambda (x) (< x 10)) 5)

((lambda (x y) (number->string (* x x))) 5 2)

((lambda (x) (remainder x 2)) 2)