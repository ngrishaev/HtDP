;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex99) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define GAME-WIDTH 200)
(define GAME-HEIGHT 200)
(define BACKGROUND (empty-scene GAME-WIDTH GAME-HEIGHT))

(define UFO-WIDTH 20)
(define UFO-HEIGHT 8)
(define UFO-IMAGE (ellipse UFO-WIDTH UFO-HEIGHT "solid" "Blue"))
(define UFO-DESCEND-SPEED 1)
(define UFO-JUMP-RANGE 3)

(define TANK-WIDTH 20)
(define TANK-HEIGHT 10)
(define TANK-BARREL-WIDTH 5)
(define TANK-BARREL-HEIGHT 6)
(define TANK-IMAGE (above
                    (rectangle TANK-BARREL-WIDTH TANK-BARREL-HEIGHT "solid" "Olive")
                    (rectangle TANK-WIDTH TANK-HEIGHT "solid" "Olive")
                    )
  )
(define TANK-SPEED 5)

(define MISSILE-SIZE (- TANK-BARREL-WIDTH 1))
(define MISSILE-IMAGE (triangle MISSILE-SIZE "solid" "red"))
(define MISSILE-SPEED 10)
(define MISSILE-START-Y-POS (- GAME-HEIGHT TANK-HEIGHT TANK-BARREL-HEIGHT))

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

; Tank Key -> Tank
; Change tank velocity by key pressed
(define (control-velocity-tank tank key)
  (cond
    [(and (string? key) (string=? key "right"))(make-tank (tank-loc tank) TANK-SPEED)]
    [(and (string? key) (string=? key "left"))(make-tank (tank-loc tank) (- TANK-SPEED))]
    [else (make-tank (tank-loc tank) 0)]
   )
  )

; SIGS Key -> SIGS
; Launch missile if can
(define (control-missile-state si key)
  (cond
    [(and (aim? si) (string=? key " "))
     (make-fired (aim-ufo si) (control-velocity-tank (aim-tank si) key) (make-posn (tank-loc (aim-tank si)) MISSILE-START-Y-POS))]
    [(aim? si)
     (make-aim (aim-ufo si) (control-velocity-tank (aim-tank si) key))]
    [(fired? si)
     (make-fired (fired-ufo si) (control-velocity-tank (fired-tank si) key) (fired-missile si))]
   )
  )

; SIGS -> SIGS
; Move objects on scene correspondedly to their speed
(define (si-move s)
  (cond
    [(aim? s)
     (make-aim (move-ufo (aim-ufo s))
            (move-tank (aim-tank s)))]
    [(fired? s)
     (make-fired (move-ufo (fired-ufo s))
            (move-tank (fired-tank s))
            (move-missile (fired-missile s)))]
   )
  )

; SIGS -> SIGS
; Destroy missile if it is out of screen
(define (si-destroy-missile-out-of-bounds s)
  (if (and (fired? s) (missile-out-of-bounds? (fired-missile s)))
      (make-aim (fired-ufo s) (fired-tank s))
      s
   )
  )

(define (si-tick s)
  (si-move (si-destroy-missile-out-of-bounds s))
  )

(define (missile-out-of-bounds? missile)
  (if (< (posn-y missile) 0)
      #true
      #false
      )
  )

; Tank -> Tank
; Moves tank by his velocity
(check-expect (move-tank (make-tank 0 3)) (make-tank 10 3))
(check-expect (move-tank (make-tank 7 3)) (make-tank 10 3))
(check-expect (move-tank (make-tank 6 3)) (make-tank 10 3))
(check-expect (move-tank (make-tank 9 3)) (make-tank 12 3))
(define (move-tank tank)
  (make-tank (clamp-hor-pos (+ (tank-loc tank) (tank-vel tank)) TANK-WIDTH) (tank-vel tank))
  )

; Number Number -> Number
(check-expect (clamp-hor-pos 0 TANK-WIDTH) 10)
(check-expect (clamp-hor-pos 50 TANK-WIDTH) 50)
(check-expect (clamp-hor-pos 300 TANK-WIDTH) 190)
(check-expect (clamp-hor-pos 3 TANK-WIDTH) 10)
(define (clamp-hor-pos pos obj-width)
  (cond
    [(< pos (/ obj-width 2))
     (/ obj-width 2)]
    [(> pos (- GAME-WIDTH (/ obj-width 2)))
     (- GAME-WIDTH (/ obj-width 2))]
    [else pos]
    )
  )

; UFO -> UFO
; Moves tank by his velocity
(define (move-ufo ufo)
  (make-posn (clamp-hor-pos (+ (posn-x ufo) (ufo-jump UFO-JUMP-RANGE)) UFO-WIDTH) (+ (posn-y ufo) UFO-DESCEND-SPEED))
  )

(define (ufo-jump range)
  (if (= (random 2) 1)
      (random range)
      (-(random range))
   )
  )

; Missile -> Missile
; Moves missile up by its speed
(check-expect (move-missile (make-posn 10 3)) (make-posn 10 (- 3 MISSILE-SPEED)))
(define (move-missile missile)
  (make-posn (posn-x missile) (- (posn-y missile) MISSILE-SPEED))
  )

; SIGS -> Image
; renders the given game state on top of BACKGROUND 
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

; SIGS -> Boolean
; Returns true if UFO landed or Missile hit UFO
; Returns false otherwise
(define (si-game-over? sigs)
  (cond
    [(aim? sigs)
     (ufo-landed? (aim-ufo sigs))]
    [(fired? sigs)
     (or (ufo-landed? (fired-ufo sigs)) (missile-hit-ufo? (fired-ufo sigs) (fired-missile sigs)))]
    ))

; UFO -> Boolean
; Returns true if UFO is on lowest game border
; Returns false otherwise
(check-expect (ufo-landed? (make-posn 50 150)) #false)
(check-expect (ufo-landed? (make-posn 50 199)) #false)
(check-expect (ufo-landed? (make-posn 50 0)) #false)
(check-expect (ufo-landed? (make-posn 50 200)) #true)
(check-expect (ufo-landed? (make-posn 50 201)) #true)
(check-expect (ufo-landed? (make-posn 50 241)) #true)
(define (ufo-landed? ufo)
  (>= (posn-y ufo) GAME-HEIGHT) 
  )

; UFO Missile -> Boolean
; Returns true if missile hit UFO
; Returns false otherwise
(define (missile-hit-ufo? ufo missile)
  (cond
    [(> (- (posn-x missile) (/ MISSILE-SIZE 2)) (+ (posn-x ufo) (/ UFO-WIDTH 2))) #false]
    [(< (+ (posn-x missile) (/ MISSILE-SIZE 2)) (- (posn-x ufo) (/ UFO-WIDTH 2))) #false]
    [(> (posn-y missile) (+ (posn-y ufo) UFO-HEIGHT)) #false]
    [(< (+ (posn-y missile) MISSILE-SIZE) (posn-y ufo) ) #false]
    [else #true]
    )
  )

(define (run sigs)
  (big-bang sigs
    [to-draw si-render]
    [on-tick si-tick]
    [on-key control-missile-state]
    [stop-when si-game-over? si-render]
    ))

(run (make-aim (make-posn 100 0)
            (make-tank 28 0)))

