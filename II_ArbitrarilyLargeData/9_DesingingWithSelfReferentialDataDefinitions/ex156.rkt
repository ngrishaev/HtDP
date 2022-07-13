;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex156) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A ShotWorld is List-of-numbers. 
; interpretation each number on such a list
;   represents the y-coordinate of a shot 

; A Shot is a Number.
; interpretation represents the shot's y-coordinate 

; A List-of-shots is one of: 
; – '()
; – (cons Shot List-of-shots)
; interpretation the collection of shots fired

(define HEIGHT 80) ; distances in terms of pixels 
(define WIDTH 100)
(define XSHOTS (/ WIDTH 2))

; graphical constants 
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 3 "solid" "red"))


; ShotWorld -> ShotWorld 
(define (main w0)
  (big-bang w0
    [on-tick tock]
    [on-key keyh]
    [to-draw to-image]))
 
; ShotWorld -> ShotWorld 
; moves each shot up by one pixel 
(define (tock w)
  (cond
    [(empty? w) '()]
    [else (cons (sub1 (first w)) (tock (rest w)))]))
 
; ShotWorld KeyEvent -> ShotWorld 
; adds a shot to the world if the space bar is hit 
(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w))
 
; ShotWorld -> Image 
; adds each shot y on w at (XSHOTS,y} to BACKGROUND
(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else (place-image SHOT XSHOTS (first w)
                       (to-image (rest w)))]))

(main '())