;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex169) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; List-of-posn -> List-of-posn
; Remove incorrect posn from list
(check-expect
 (legal (cons (make-posn 10 345) (cons (make-posn 10 4) (cons (make-posn -5 17) '()))))
 (cons (make-posn 10 4) '()))
(define (legal lop)
  (cond
    [(empty? lop) '()]
    [(or
      (< (posn-x (first lop)) 0)
      (> (posn-x (first lop)) 100)
      (< (posn-y (first lop)) 0)
      (> (posn-y (first lop)) 200))
     (legal (rest lop))
     ]
    [else (cons (first lop) (legal (rest lop)))]
  ))