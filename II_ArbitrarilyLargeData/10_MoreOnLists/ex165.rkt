;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex165) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Description
; Is a one word string, representing toy description

; List-of-descriptions is one ofe
; - '()
; (cons Description List-of-descriptions)

; List-of-descriptions -> List-of-descriptions
; Replaces all occurences of "robot" in list with "r2d2"
(check-expect (subst-robot
               (cons "robot" (cons "aaaa" '())))
              (cons "r2d2" (cons "aaaa" '())))
              
(define (subst-robot lod)
  (cond
    [(empty? lod) lod]
    [(string=? (first lod) "robot") (cons "r2d2" (subst-robot (rest lod)))]
    [else (cons (first lod) (subst-robot (rest lod)))]
  ))

; List-of-descriptions Description Description -> List-of-descriptions
; Replaces all occurences of old string in list with new string
(check-expect (substitute
               (cons "robot" (cons "aaaa" '())) "robot" "r2d2")
              (cons "r2d2" (cons "aaaa" '())))

(check-expect (substitute
               (cons "aaaa" (cons "robot" '())) "robot" "r2d2")
              (cons "aaaa" (cons "r2d2" '())))
(define (substitute lod old new)
  (cond
    [(empty? lod) lod]
    [(string=? (first lod) old) (cons new (substitute (rest lod) old new))]
    [else (cons (first lod) (substitute (rest lod) old new))]
  ))