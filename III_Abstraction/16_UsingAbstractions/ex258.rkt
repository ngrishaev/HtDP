;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex258) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define square-p
  (list
    (make-posn 10 10)
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 10 20)))

; a plain background image 
(define MT (empty-scene 50 50))
 
; Image Posn Posn -> Image 
; draws a red line from Posn p to Posn q into im
(define (render-line im p q)
  (scene+line
    im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))

(define (render-poly.v2 img p)
  (local [
          ; Polygon -> Posn
          ; extracts the last item from p
          (define (last.v2 p)
            (cond
              [(empty? (rest (rest (rest p)))) (third p)]
              [else (last.v2 (rest p))]))
          ; Image NELoP -> Image
          ; connects the Posns in p in an image
          (define (connect-dots.v2 img p)
            (cond
              [(empty? (rest p)) img]
              [else (render-line (connect-dots.v2 img (rest p))
                                 (first p)
                                 (second p))]))
          ]
    ; -- IN --
    (render-line (connect-dots.v2 img p) (first p) (last.v2 p))
    )
  )

(render-poly.v2 MT square-p)



