;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex215) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

(define TILE-SIZE 10)
(define TILES-HEIGHT 10)
(define TILES-WIDTH 10)
(define SCENE-HEIGHT (* TILES-HEIGHT TILE-SIZE))
(define SCENE-WIDTH (* TILES-WIDTH TILE-SIZE))
(define SNAKE-SEGMENT-RADIUS (/ TILE-SIZE 2))
(define SNAKE-SEGMENT (circle SNAKE-SEGMENT-RADIUS "solid" "red"))

(define MT (empty-scene SCENE-WIDTH SCENE-HEIGHT))

; A Snake is one of: 
; – '()
; – (cons posn Snake)

; Snake -> Snake
; Launches the program from the initial state.
(define (main s0)
  (big-bang s0
    [to-draw render]
    [on-tick tick-handler 1]
    ;[on-key key-handler]
    ))

; Snake -> Image
; Render given snake
(define (render sn)
  (cond
    [(empty? sn) MT]
    [else (render-snake-segment (first sn) (render (rest sn)))]   
   )  
  )

; Posn Image -> Image
; Render snake segment at position pos onto image img
(define (render-snake-segment pos img)
  (place-image SNAKE-SEGMENT (+ (* (posn-x pos) TILE-SIZE) (/ TILE-SIZE 2) ) (+ (* (posn-y pos) TILE-SIZE) (/ TILE-SIZE 2) ) img)
  )

; Snake -> Snake
; Move One Segment snake to the right
(define (tick-handler sn)
  (cond
    [(empty? sn) '()]
    [else (cons (make-posn (+ 1 (posn-x (first sn))) (posn-y (first sn))) (tick-handler (rest sn)))]
   )
   )

;(render (list (make-posn 4 5) (make-posn 5 5) (make-posn 6 5)))

(main (list (make-posn 4 5)))

