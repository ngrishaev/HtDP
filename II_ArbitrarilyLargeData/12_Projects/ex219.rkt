;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex219) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

(define TILE-SIZE 10)
(define TILES-HEIGHT 10)
(define TILES-WIDTH 10)
(define SCENE-HEIGHT (* TILES-HEIGHT TILE-SIZE))
(define SCENE-WIDTH (* TILES-WIDTH TILE-SIZE))
(define SNAKE-SEGMENT-RADIUS (/ TILE-SIZE 2))
(define FOOD-RADIUS (/ TILE-SIZE 3))
(define SNAKE-SEGMENT (circle SNAKE-SEGMENT-RADIUS "solid" "red"))
(define FOOD (circle FOOD-RADIUS "solid" "green"))

(define HIT-WALL-FAIL-TEXT (text "Worm hit border" 12 "black"))
(define BIT-ITSELF-FAIL-TEXT (text "Worm bit itself" 12 "black"))

; Tiles per second
(define SNAKE-SPEED 2)

; Game speed
(define GAME-SPEED (/ 1 SNAKE-SPEED))


(define MT (empty-scene SCENE-WIDTH SCENE-HEIGHT))

; Int Int -> ListOfPosn
; Generates list of all positions for yth row
(define (generate-row width y-pos)
  (cond
    [(= width 0) '()]
    [else (cons (make-posn (sub1 width) y-pos) (generate-row (sub1 width) y-pos))]
    )
  )

; Int Int -> ListOfPosn
; Generate list of all positions for grid of size (width height)
(define (combine-hor-posn-to-ver width height)
  (cond
    [(= height 0) '()]
    [else (append (generate-row width (sub1 height)) (combine-hor-posn-to-ver width (sub1 height)))]
    )
  )

(define GRID-POSITIONS (combine-hor-posn-to-ver TILES-WIDTH TILES-HEIGHT))

(define-struct sw [snake food dir])
; SnakeWorld (sw) is a structure
; (make-snake-world Snake Food Direction)
; represending Snake Game data

; Food is a posn representing Food position on grid

; Direction is one of
; - "UP"
; - "RIGHT"
; - "DOWN"
; - "LEFT"


; A Snake is one of: 
; – (cons posn '())
; – (cons posn Snake)
; Snake head always (first snake)

; SnakeWorld -> SnakeWorld
; Launches the program from the initial state.
(define (main s0)
  (big-bang s0
    [to-draw render]
    [on-tick tick-handler GAME-SPEED]
    [on-key key-handler]
    [stop-when fail? render-fail]
    ))

; SnakeWorld -> Image
; Render game
(define (render sw)
  (render-snake (sw-snake sw) (render-food (sw-food sw)))
  )

; SnakeWorld Image -> Image
; Render snake on image
(define (render-snake sn img)
  (cond
    [(empty? sn) img]
    [else (render-snake-segment (first sn) (render-snake (rest sn) img))]   
   )  
  )

; Food -> Image
; Renders food on MT
(define (render-food f)
  (render-on-grid FOOD f MT)
  )

; Posn Image -> Image
; Render snake segment at position pos onto image img
(define (render-snake-segment pos img)
  (render-on-grid SNAKE-SEGMENT pos img)
  )

; SnakeWorld -> Bool
; Is snake on food?
(define (food? sw)
  (posn=? (first (sw-snake sw)) (sw-food sw))
  )

; Posn Posn -> Bool
; Is posn have same points
(define (posn=? p1 p2)
  (and (= (posn-x p1) (posn-x p2))
       (= (posn-y p1) (posn-y p2))))

; Image Posn Image -> Image
; Renders image onto image with position posn
(define (render-on-grid img at onto)
  (place-image img (+ (* (posn-x at) TILE-SIZE) (/ TILE-SIZE 2)) (+ (* (posn-y at) TILE-SIZE) (/ TILE-SIZE 2)) onto)
  )

; SnakeWorld -> SnakeWorld
; Update SnakeWorld
(define (tick-handler sw)
 (update-food (try-eat (update-position sw)))
  )

; SnakeWorld -> SnakeWorld
; Move food to new position if snake on it
(define (update-food sw)
  (if (food? sw)
      (respawn-food sw)
      sw
   )
  )

; SnakeWorld -> SnakeWorld
; Move food to new position if snake on it
(define (respawn-food sw)
  (make-sw
   (sw-snake sw)
   ;(generate-new-position TILES-WIDTH TILES-HEIGHT)
   (list-random (available-positions GRID-POSITIONS (sw-snake sw)))
   (sw-dir sw)
   )
  )

; List List -> List
; Removes "removeList" from "baseList"
(define (list-except baseList removeList)
  (cond
    [(empty? removeList) baseList]
    [else (list-except (remove (first removeList) baseList) (rest removeList))]
   )
  )

; Snake -> ListOfPosn
; Generetase all posn that are not occupied by snake
(define (available-positions all-pos sn)
  (list-except all-pos sn)
  )

; List -> Any
; Returns random element from list
(define (list-random l)
  (list-ref l (random (length l)))
  )

; SnakeWorld -> SnakeWorld
; UpdateSnake position in world
(define (update-position sw)
  (make-sw
   (move-snake (sw-snake sw) (sw-dir sw))
   (sw-food sw)
   (sw-dir sw))
  )

; SnakeWorld -> SnakeWorld
; Try eat food if it is under the snake
(define (try-eat sw)
  (make-sw
   (if (food? sw)
       (sw-snake sw)
       (remove-last (sw-snake sw))
       )
   (sw-food sw)
   (sw-dir sw))
  )

; Snake Direction -> Snake
; Move One Segment snake to given direction
(define (move-snake sn dir)
  (cons (move-in-direction dir (first sn)) sn)
  )

; SnakeWorld -> SnakeWorld
; Move snake
(define (key-handler sw key)
  (cond
    [(string=? "left" key) (make-sw (sw-snake sw) (sw-food sw) (direction-rotate-left (sw-dir sw)))]
    [(string=? "right" key) (make-sw (sw-snake sw) (sw-food sw) (direction-rotate-right (sw-dir sw)))]
    [else sw]
   )  
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
(define (fail? sw)
  (or (hit-border? (sw-snake sw))
      (bit-itself? (sw-snake sw)))
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
(define (render-fail sw)
  (cond
    [(hit-border? (sw-snake sw))(place-image HIT-WALL-FAIL-TEXT (/ SCENE-WIDTH 2) (/ SCENE-HEIGHT 2) MT)]
    [(bit-itself? (sw-snake sw))(place-image BIT-ITSELF-FAIL-TEXT (/ SCENE-WIDTH 2) (/ SCENE-HEIGHT 2) MT)]
    ))

; Direction -> Direction
; Rotate direction to left
(define (direction-rotate-left dir)
  (cond
    [(string=? "UP" dir) "LEFT"]
    [(string=? "RIGHT" dir) "UP"]
    [(string=? "DOWN" dir) "RIGHT"]
    [(string=? "LEFT" dir) "DOWN"]
   )  
  )

; Direction -> Direction
; Rotate direction to right
(define (direction-rotate-right dir)
  (cond
    [(string=? "UP" dir) "RIGHT"]
    [(string=? "RIGHT" dir) "DOWN"]
    [(string=? "DOWN" dir) "LEFT"]
    [(string=? "LEFT" dir) "UP"]
   )  
  )

; Direction Posn -> Posn
; Move position in direction
(define (move-in-direction dir pos)
  (cond
    [(string=? "UP" dir) (make-posn (posn-x pos) (- (posn-y pos) 1))]
    [(string=? "RIGHT" dir) (make-posn (+ (posn-x pos) 1) (posn-y pos))]
    [(string=? "DOWN" dir) (make-posn (posn-x pos) (+ (posn-y pos) 1))]
    [(string=? "LEFT" dir) (make-posn (- (posn-x pos) 1) (posn-y pos))]
   )  
  )

(define snake (list (make-posn 5 5)))
(define food (make-posn 8 5))
(define snake-world (make-sw snake food "RIGHT"))

(main snake-world)