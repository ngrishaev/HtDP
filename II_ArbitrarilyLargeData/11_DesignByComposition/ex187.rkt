;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex187) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct gp [name score])
; A GamePlayer is a structure: 
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who 
; scored a maximum of s points

; List-of-GamePlayers
; is one of
; '()
; (cons GamePlayer List-of-GamePlayers)

; Sorts players by their score
; List-of-GamePlayers -> List-of-GamePlayers
(check-expect (sort-players> (list (make-gp "a" 5) (make-gp "b" 1) (make-gp "c" 20)))
              (list (make-gp "c" 20) (make-gp "a" 5) (make-gp "b" 1))
              )
(define (sort-players> lop)
  (cond
    [(empty? lop) '()]
    [else
     (insert-player (first lop) (sort-players> (rest lop)))]))

; Insert player into sorted list of players
; GamePlayer List-of-GamePlayers -> List-of-GamePlayers
(define (insert-player p slop)
  (cond
    [(empty? slop) (cons p '())]
    [(player>= p (first slop)) (cons p slop)]
    [else (cons (first slop) (insert-player p (rest slop)))]
    ))

; GamePlayer GamePlaye -> Boolean
; Aswers is p1 have more or equals scores than p2
(define (player>= p1 p2)
  (if (>= (gp-score p1) (gp-score p2))
      #true
      #false
      ))
    