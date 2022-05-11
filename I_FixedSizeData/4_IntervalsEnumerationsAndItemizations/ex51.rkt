;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex51) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"

(define WIDTH 200)
(define HEIGHT 200)
(define HALF-WIDTH (/ WIDTH 2))
(define HALF-HEIGHT (/ HEIGHT 2))
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define LIGHT-SIZE HALF-WIDTH)
(define LIGHT-DURATION-IN-SECONDS 3)

; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
(define (traffic-light-next current-light)
  (cond
    [(string=? "red" current-light) "green"]
    [(string=? "green" current-light) "yellow"]
    [(string=? "yellow" current-light) "red"]
    )
  )


; TrafficLight -> image
; Renders image of traffic light
(define (render-light light)
  (place-image (circle LIGHT-SIZE "solid" light) HALF-WIDTH HALF-HEIGHT BACKGROUND)
  )

; Consume starting light and display how it changes to next
(define (traffic-light-simulation start-light)
  (big-bang start-light
    [on-tick traffic-light-next LIGHT-DURATION-IN-SECONDS]
    [to-draw render-light]
    )
  )

(traffic-light-simulation "red")