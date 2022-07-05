;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex97) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define GAME-WIDTH 200)
(define GAME-HEIGHT 200)
(define BACKGROUND (empty-scene GAME-WIDTH GAME-HEIGHT))

(define UFO-WIDTH 20)
(define UFO-HEIGHT 8)
(define UFO-IMAGE (ellipse UFO-WIDTH UFO-HEIGHT "solid" "Blue"))

(define TANK-WIDTH 20)
(define TANK-HEIGHT 10)
(define TANK-BARREL-WIDTH 5)
(define TANK-BARREL-HEIGHT 6)
(define TANK-IMAGE (above
                    (rectangle TANK-BARREL-WIDTH TANK-BARREL-HEIGHT "solid" "Olive")
                    (rectangle TANK-WIDTH TANK-HEIGHT "solid" "Olive")
                    )
  )

(define MISSILE-SIZE (- TANK-BARREL-WIDTH 1))
(define MISSILE-IMAGE (triangle MISSILE-SIZE "solid" "red"))

; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

; A SIGS (Space Invaders Game State) is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; SIGS -> Image
; renders the given game state on top of BACKGROUND 
; for examples see figure 32
(define (si-render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) BACKGROUND))]
    [(fired? s)
     (tank-render
       (fired-tank s)
       (ufo-render (fired-ufo s)
                   (missile-render (fired-missile s)
                                   BACKGROUND)))]))

; Tank Image -> Image
; Render tank on input image
(define (tank-render tank image)
  (place-image/align TANK-IMAGE (tank-loc tank) GAME-HEIGHT "middle" "bottom" image)
  )

; UFO Image -> Image
; Render UFO on input image
(define (ufo-render ufo image)
  (place-image/align UFO-IMAGE (posn-x ufo) (posn-y ufo) "middle" "bottom" image)
  )

; Missile Image -> Image
; Render Missile on input image
(define (missile-render missile image)
  (place-image/align MISSILE-IMAGE (posn-x missile) (posn-y missile) "middle" "bottom" image)
  )


(si-render (make-fired (make-posn 20 10)
            (make-tank 28 -3)
            (make-posn 28 (- GAME-HEIGHT TANK-HEIGHT TANK-BARREL-HEIGHT))))

