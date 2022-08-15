;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex254) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of Number] [Number Number -> Boolean] -> [List-of Number]
; sort-n, which consumes a list of numbers and a function that consumes two numbers (from the list) and produces a Boolean; sort-n produces a sorted list of numbers.

; [List-of String] [String String -> Boolean] -> [List-of String]
; sort-s, which consumes a list of strings and a function that consumes two strings (from the list) and produces a Boolean; sort-s produces a sorted list of strings.

; ABSTRACTION:
; [X] [List-of X] [X X -> Boolean] -> [List-of X]