;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex193) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; a Polygon is one of: 
; – (cons Posn (cons Posn (cons Posn '()))) 
; – (cons Posn Polygon)

(define triangle-p
  (list
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 30 20)))

(define square-p
  (list
    (make-posn 10 10)
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 10 20)))

; a plain background image 
(define MT (empty-scene 50 50))

;; Polygon Posn -> Polygon
;; Creates new poligon form l with p as last point
(check-expect
  (add-at-end triangle-p (make-posn 5 15))
  (list (make-posn 20 10) (make-posn 20 20) (make-posn 30 20) (make-posn 5 15))) 

(define (add-at-end pl p)
  (cond
    [(empty? pl) (cons p '())]
    [else (cons (first pl) (add-at-end (rest pl) p))]
   ))

 
; Image Polygon -> Image
; renders the given polygon p into img
(check-expect
  (render-poly MT triangle-p)
  (scene+line
    (scene+line
      (scene+line MT 20 10 20 20 "red")
      20 20 30 20 "red")
    30 20 20 10 "red"))

(check-expect
  (render-poly MT square-p)
  (scene+line
    (scene+line
      (scene+line
        (scene+line MT 10 10 20 10 "red")
        20 10 20 20 "red")
      20 20 10 20 "red")
    10 20 10 10 "red"))

; Image Polygon -> Image 
; adds an image of p to img
(define (render-poly.v1 img p)
  (connect-dots img (cons (last p) p)
  ))

; Image Polygon -> Image 
; adds an image of p to img
(define (render-poly.v2 img p)
  (connect-dots img (add-at-end p (first p))
                )
  )

; Image Polygon -> Image 
; adds an image of p to img
(define (render-poly img p)
  (connect-dots img (cons (last p) p)
  ))

; Polygon -> Posn
; extracts the last item from p
; NELoP -> Posn
; extracts the last item from p
; Polygon -> Posn
; extracts the last item from p
(define (last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (last (rest p))]))

; Image Posn Posn -> Image 
; draws a red line from Posn p to Posn q into im
; Image Posn Posn -> Image 
; renders a line from p to q into img
(define (render-line img p q)
  (scene+line img (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))


; An NELoP is one of: 
; – (cons Posn '())
; – (cons Posn NELoP)

; Image NELoP -> Image 
; connects the dots in p by rendering lines in img

(check-expect (connect-dots MT triangle-p)
              (scene+line
               (scene+line MT 20 20 30 20 "red")
               20 10 20 20 "red"))

(check-expect (connect-dots MT square-p)
              (scene+line
               (scene+line
                (scene+line MT 20 20 10 20 "red")
                20 10 20 20 "red")
               10 10 20 10 "red"))

(define (connect-dots img p)
  (cond
    [(empty? (rest p)) img]
    [else
     (render-line
       (connect-dots img (rest p))
       (first p)
       (second p))]))



