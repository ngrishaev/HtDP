;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex47) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH 200)
(define HEIGHT 50)
(define HEIGHT-CENTER (/ HEIGHT 2))
(define MAX-GAUGE 50)
(define BACKGROUND (empty-scene WIDTH HEIGHT "Black"))

(define ONE-FIFTH (/ MAX-GAUGE 5))
(define ONE-THIRD (/ MAX-GAUGE 3))
(define DECREASE-AMOUNT 0.1)
 
(define (gauge-prog gauge)
  (big-bang gauge
    [on-tick update-gauge]
    [to-draw render-gauge]
    [on-key handle-keys]))

; Happiness -> Happines
; Graduadly decrease happines
(define (update-gauge ws)
  (if (<= ws 0)
      0
      (max 0 (- ws DECREASE-AMOUNT))
   )
  )

; Happines -> Image
; Render happines gauge
(define (render-gauge length)
  (render-gauge-normalzied (/ length MAX-GAUGE))
  )

; Number -> Image
; Place red rectange with length "length" on scene
(define (render-gauge-normalzied normalized)
  (render-gauge-absolute (+ 0 (* WIDTH normalized)))
  )

; Number -> Image
; Place red rectange with length "length" on scene
(define (render-gauge-absolute length)
  (place-image (rectangle length HEIGHT "solid" "red") (round (/ length 2)) HEIGHT-CENTER BACKGROUND)
  )

; Happines Key -> Happines
; if up arrow pressed the gague adds 1/5 of itself
(define (handle-keys ws key)
  (cond
    [(key=? key "up") (min MAX-GAUGE (+ ws ONE-THIRD))]
    [(key=? key "down") (max 0 (- ws ONE-FIFTH))]
   )
  )

; Consumes max level of happines and display it changes
(gauge-prog MAX-GAUGE)
