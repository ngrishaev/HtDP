;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex94) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


(define GAME-WIDTH 150)
(define GAME-HEIGHT 100)
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



; TEMPORAL
(define UFO-X 75)
(define TANK-X 29)
(define MISSILE-X 39)
(define MISSILE-Y 50)

(define render-tank
  (place-image/align TANK-IMAGE TANK-X 100 "middle" "bottom" BACKGROUND)
  )

(define render-ufo
  (place-image/align UFO-IMAGE UFO-X 17 "middle" "bottom" render-tank)
  )

(define render-missile
  (place-image/align MISSILE-IMAGE MISSILE-X MISSILE-Y "middle" "bottom" render-ufo)
  )

render-missile


