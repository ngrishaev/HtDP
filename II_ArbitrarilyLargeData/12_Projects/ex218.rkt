;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex218) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

(define TILE-SIZE 10)
(define TILES-HEIGHT 10)
(define TILES-WIDTH 10)
(define SCENE-HEIGHT (* TILES-HEIGHT TILE-SIZE))
(define SCENE-WIDTH (* TILES-WIDTH TILE-SIZE))
(define SNAKE-SEGMENT-RADIUS (/ TILE-SIZE 2))
(define SNAKE-SEGMENT (circle SNAKE-SEGMENT-RADIUS "solid" "red"))

(define HIT-WALL-FAIL-TEXT (text "Worm hit border" 12 "black"))
(define BIT-ITSELF-FAIL-TEXT (text "Worm bit itself" 12 "black"))


(define MT (empty-scene SCENE-WIDTH SCENE-HEIGHT))

; A Snake is one of: 
; – (cons posn '())
; – (cons posn Snake)
; Snake head always (first snake)

;; Snake -> Snake
;; Launches the program from the initial state.
(define (main s0)
  (big-bang s0
    [to-draw render]
    [on-tick tick-handler 1]
    ;[on-key key-handler]
    [stop-when fail? render-fail]
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
  (cons (make-posn (+ 1 (posn-x (first sn))) (posn-y (first sn))) (remove-last sn))
  )

; List -> List
; List without its last element
(define (remove-last l)
  (cond
    [(empty? l) '()]
    [(empty? (rest l)) '()]
    [else (cons (first l) (remove-last (rest l)))]
   ))

; Snake -> Boolean
; Define is snake fail
(define (fail? sn)
  (or (hit-border? sn)
      (bit-itself? sn))
  )

; Snake -> Boolean
; Is snake failed and bite walls or itself?
(define (hit-border? sn)
  (if
   (or (> (posn-x (first sn)) (- TILES-WIDTH 1))
       (< (posn-x (first sn)) 0)
       (> (posn-y (first sn)) (- TILES-HEIGHT 1))
       (< (posn-y (first sn)) 0)
       )
   #true
   #false
   ))

; Snake -> Boolean
; Is snake failed and bite walls or itself?
(define (bit-itself? sn)
  (member? (first sn) (rest  sn))
  )

; Snake -> Img
; Render lose screen
(define (render-fail sn)
  (cond
    [(hit-border? sn)(place-image HIT-WALL-FAIL-TEXT (/ SCENE-WIDTH 2) (/ SCENE-HEIGHT 2) MT)]
    [(bit-itself? sn)(place-image BIT-ITSELF-FAIL-TEXT (/ SCENE-WIDTH 2) (/ SCENE-HEIGHT 2) MT)]
    ))


(main (list (make-posn 2 1) (make-posn 1 1) (make-posn 1 2) (make-posn 2 2) (make-posn 2 1)))