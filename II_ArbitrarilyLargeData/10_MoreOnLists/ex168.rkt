;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex168) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; List-of-posn -> List-of-posn
; Translate all positions by 1 by y axis
(check-expect
 (translate (cons (make-posn 10 4) (cons (make-posn -5 17) '())))
 (cons (make-posn 10 5) (cons (make-posn -5 18) '())))
(define (translate lop)
  (cond
    [(empty? lop) '()]
    [else (cons (make-posn (posn-x (first lop)) (+ (posn-y (first lop)) 1))
                (translate (rest lop)))]
  ))