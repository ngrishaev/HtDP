;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex180) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define HEIGHT 20) ; the height of the editor 
(define WIDTH 200) ; its width 
(define FONT-SIZE 16) ; the font size 
(define FONT-COLOR "black") ; the font color 
 
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))


(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)

(define good
  (cons "g" (cons "o" (cons "o" (cons "d" '())))))
(define all
  (cons "a" (cons "l" (cons "l" '()))))
(define lla
  (cons "l" (cons "l" (cons "a" '()))))

; Lo1s -> Lo1s 
; produces a reverse version of the given list 
 
(check-expect
  (rev (cons "a" (cons "b" (cons "c" '()))))
  (cons "c" (cons "b" (cons "a" '()))))
 
(define (rev l)
  (cond
    [(empty? l) '()]
    [else (add-at-end (rev (rest l)) (first l))]))

; Lo1s 1String -> Lo1s
; creates a new list by adding s to the end of l
 
(check-expect
  (add-at-end (cons "c" (cons "b" '())) "a")
  (cons "c" (cons "b" (cons "a" '()))))

(check-expect
  (add-at-end '() "a")
  (cons "a" '()))
 
(define (add-at-end l s)
  (cond
    [(empty? l) (cons s '())]
    [else
     (cons (first l) (add-at-end (rest l) s))]))

; String String -> Editor
(define (create-editor s1 s2)
  (make-editor (rev (explode s1)) (explode s2)) 
  )
 
; Editor KeyEvent -> Editor
; deals with a key event, given some editor
(check-expect (editor-kh (create-editor "" "") "e")
              (create-editor "e" ""))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "e")
  (create-editor "cde" "fgh"))
(define (editor-kh ed k)
  (cond
    [(key=? k "left") (editor-lft ed)]
    [(key=? k "right") (editor-rgt ed)]
    [(key=? k "\b") (editor-del ed)]
    [(key=? k "\t") ed]
    [(key=? k "\r") ed]
    [(= (string-length k) 1) (editor-ins ed k)]
    [else ed]))

; Editor 1String -> Editor
; insert the 1String k between pre and post
(check-expect
  (editor-ins (make-editor '() '()) "e")
  (make-editor (cons "e" '()) '()))
  
(check-expect
  (editor-ins
    (make-editor (cons "d" '())
                 (cons "f" (cons "g" '())))
    "e")
  (make-editor (cons "e" (cons "d" '()))
               (cons "f" (cons "g" '()))))

(define (editor-ins ed k)
  (make-editor (cons k (editor-pre ed))
               (editor-post ed)))

; Editor -> Editor
; Delete char to the left from the cursor
(define EMPTY-LIST '());
(define LIST1 (cons "a" '()));
(define LIST2 (cons "b" (cons "a" '())));

(check-expect
  (editor-del
   (make-editor LIST2 LIST2))
  (make-editor (cons "a" '()) LIST2)
  )

(check-expect
  (editor-del
   (make-editor LIST1 LIST2))
  (make-editor EMPTY-LIST LIST2)
  )

(check-expect
  (editor-del
   (make-editor EMPTY-LIST LIST2))
  (make-editor EMPTY-LIST LIST2)
  )

(define (editor-del ed)
  (if (empty? (editor-pre ed))
      ed
      (make-editor (rest (editor-pre ed)) (editor-post ed)
       )))

; Editor -> Editor
; Move cursor to the left
(check-expect
  (editor-lft
   (make-editor LIST2 LIST2))
  (make-editor (cons "a" '()) (cons "b" LIST2))
  )

(check-expect
  (editor-lft
   (make-editor LIST1 LIST2))
  (make-editor EMPTY-LIST (cons "a" LIST2)
  ))

(check-expect
  (editor-lft
   (make-editor EMPTY-LIST LIST2))
  (make-editor EMPTY-LIST LIST2)
  )

(check-expect
  (editor-lft
   (make-editor LIST1 EMPTY-LIST))
  (make-editor EMPTY-LIST LIST1)
  )

(define (editor-lft ed)
  (if (empty? (editor-pre ed))
      ed
      (make-editor (rest (editor-pre ed)) (cons (first (editor-pre ed)) (editor-post ed))
       )))

; Editor -> Editor
; Move cursor to the right
(check-expect
  (editor-rgt
   (make-editor LIST2 LIST2))
  (make-editor (cons "b" LIST2) (cons "a" '()) )
  )

(check-expect
  (editor-rgt
   (make-editor LIST2 LIST1))
  (make-editor (cons "a" LIST2) EMPTY-LIST 
  ))

(check-expect
  (editor-rgt
   (make-editor LIST2 EMPTY-LIST))
  (make-editor LIST2 EMPTY-LIST)
  )

(check-expect
  (editor-rgt
   (make-editor EMPTY-LIST LIST1))
  (make-editor LIST1 EMPTY-LIST)
  )

(define (editor-rgt ed)
  (if (empty? (editor-post ed))
      ed
      (make-editor
       (cons (first (editor-post ed)) (editor-pre ed))
       (rest (editor-post ed))
       )))


; Editor -> Image
; renders an editor as an image of the two texts 
; separated by the cursor 
(define (editor-render ed)
  (place-image/align
    (beside (editor-text (reverse (editor-pre ed)))
            CURSOR
            (editor-text (editor-post ed)))
    1 1
    "left" "top"
    MT))

; Lo1s -> Image
; renders a list of 1Strings as a text image 
(define (editor-text s)
  (cond
    [(empty? s) empty-image]
    [else (beside (text (first s) FONT-SIZE FONT-COLOR) (editor-text (rest s)))]
    )
  )


; main : String -> Editor
; launches the editor given some initial string 
(define (main s)
   (big-bang (create-editor s "")
     [on-key editor-kh]
     [to-draw editor-render]))

(main "Hello there, ")