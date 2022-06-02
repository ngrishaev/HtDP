;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex87) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH 200)

; Direction is one of the following strings:
; - "left"
; - "right"

; Position is integer interval 0..infinity

(define-struct editor [text pos])
; An Editor is a structure:
;   (make-editor String Integer)
; interpretation (make-editor t i) describes an editor
; whose visible text is t with 
; the cursor displayed before

; Editor Direction -> Editor
; Move divider to right or to left
(check-expect (editor-move-cursor (make-editor "abcd" 3) "right") (make-editor "abcd" 4))
(check-expect (editor-move-cursor (make-editor "abcd" 4) "left") (make-editor "abcd" 3))
(check-expect (editor-move-cursor (make-editor "abcd" 0) "left") (make-editor "abcd" 0))
(check-expect (editor-move-cursor (make-editor "abcd" 1) "left") (make-editor "abcd" 0))
(check-expect (editor-move-cursor (make-editor "abcd" 2) "left") (make-editor "abcd" 1))
(check-expect (editor-move-cursor (make-editor "abcd" 3) "left") (make-editor "abcd" 2))
(check-expect (editor-move-cursor (make-editor "" 0) "left") (make-editor "" 0))
(check-expect (editor-move-cursor (make-editor "abcd" 0) "right") (make-editor "abcd" 1))
(check-expect (editor-move-cursor (make-editor "abcd" 1) "right") (make-editor "abcd" 2))
(check-expect (editor-move-cursor (make-editor "abcd" 2) "right") (make-editor "abcd" 3))

(check-expect (editor-move-cursor (make-editor "abcd" 4) "right") (make-editor "abcd" 4))
(check-expect (editor-move-cursor (make-editor "" 0) "right") (make-editor "" 0))
(define (editor-move-cursor e d)
  (cond
   [(string-empty? (editor-text e)) e]
   [(and (string? d) (string=? d "left"))
    (make-editor (editor-text e) (clamp 0 (- (string-length (editor-text e)) 1) (- (editor-pos e) 1)))
    ]
   [(and (string? d) (string=? d "right"))
    (make-editor (editor-text e) (clamp 0 (string-length (editor-text e)) (+ (editor-pos e) 1)))
    ]
   )
  )


; Editor KeyEvent -> Editor
; Update editor correspondely to key
(check-expect (edit (make-editor "abcd" 2) "left")  (make-editor "abcd" 1))
(check-expect (edit (make-editor "abcd" 2) "right")  (make-editor "abcd" 3))
(check-expect (edit (make-editor "abcd" 2) "nope")  (make-editor "abcd" 2))
(check-expect (edit (make-editor "aaaavg" 5) "a")  (make-editor "aaaavag" 6))
(check-expect (edit (make-editor "g" 0) "a")  (make-editor "ag" 1))
(check-expect (edit (make-editor "g" 1) "a")  (make-editor "ga" 2))
(check-expect (edit (make-editor "" 0) "a")  (make-editor "a" 1))
(check-expect (edit (make-editor "asd" 3) "a")  (make-editor "asda" 4))
(check-expect (edit (make-editor "asd" 2) "a")  (make-editor "asad" 3))
(check-expect (edit (make-editor "abcd" 2) "\b")  (make-editor "acd" 1))
(check-expect (edit (make-editor "bcd" 1) "\b")  (make-editor "cd" 0))
(check-expect (edit (make-editor "cd" 0) "\b")  (make-editor "cd" 0))
(check-expect (edit (make-editor "ab" 2) "\b")  (make-editor "a" 1))
(check-expect (edit (make-editor "" 0) "\b")  (make-editor "" 0))
(check-expect (edit (make-editor "ac" 1) "\b")  (make-editor "c" 0))
; (< (editor-pos e) (string-length (editor-text e)))
(define (edit e ke)
  (cond
   [(and (string? ke) (= (string-length ke) 1) (or (and (string<=? ke "z") (string>=? ke "a")) (and (string<=? ke "Z") (string>=? ke "A")) (string=? ke " ")))
     (make-editor
      (string-insert ke (editor-text e) (editor-pos e))
      (+ (editor-pos e) 1)
      )
    ]
   [(and (string? ke) (or (string=? ke "left") (string=? ke "right")))
    (editor-move-cursor e ke)
    ]
   [(and (string? ke) (> (editor-pos e) 0) (string=? ke "\b"))
    (make-editor
      (string-delete (editor-text e) (- (editor-pos e) 1))
      (- (editor-pos e) 1))
    ]
   [else e]
   ) 
  )

; Editor -> Image
; Render editor on scene
(define (render editor)
  (overlay/align "left" "center"
                 (render-editor editor)
                 (empty-scene WIDTH 20)
                 )
  )

; Editor -> Image
; Render only editor without scene
(define (render-editor editor)
  (beside
   (text (substring (editor-text editor) 0 (editor-pos editor)) 11 "black")
   (rectangle 1 16 "solid" "red")
   (text (substring (editor-text editor) (editor-pos editor)) 11 "black")
   )
  )

; 1String String Number -> String
; Inserts 1String into string str
(check-expect (string-insert "a" "" 0) "a")
(check-expect (string-insert "a" "b" 0) "ab")
(check-expect (string-insert "a" "bc" 0) "abc")
(check-expect (string-insert "a" "b" 1) "ba")
(check-expect (string-insert "a" "bc" 1) "bac")
(check-expect (string-insert "a" "bc" 2) "bca")
(define (string-insert ch into at)
  (string-append (substring into 0 at) ch (substring into at (string-length into))))

; String Number -> String
; Remove char at position at in string str
(check-expect (string-delete "a" 0) "")
(check-expect (string-delete "ab" 0) "b")
(check-expect (string-delete "abc" 0) "bc")
(check-expect (string-delete "ab" 1) "a")
(check-expect (string-delete "abc" 1) "ac")
(check-expect (string-delete "abc" 2) "ab")
(define (string-delete str at)
  (string-append (substring str 0 at) (substring str (+ at 1) (string-length str))))

; Int Int Int -> Int
; If value < low returns low
; If value > high return high
; returns value otherwise
(check-expect (clamp 0 3 1) 1)
(check-expect (clamp 0 3 4) 3)
(check-expect (clamp 0 3 -1) 0)
(check-expect (clamp 0 0 1) 0)
(check-expect (clamp 0 0 1) 0)
(define (clamp low high value)
  (cond
    [(< value low) low]
    [(> value high) high]
    [else value]
   )
  )

(define (edit-limited-by-render e ke)
  (if (compare-editor-width (edit e ke) WIDTH)
      (edit e ke)
      e
   )
  )

(define (compare-editor-width editor width)
  (if (< (image-width (render-editor editor)) width)
      #true
      #false
      )
  )

; String -> Boolean
; #true if string is empty
; #false otherwise
(check-expect (string-empty? "") #true)
(check-expect (string-empty? "abc") #false)
(define (string-empty? str)
  (if (= (string-length str) 0)
      #true
      #false
      )
  )

; Editor -> Editor
; Interactive programm that let you edit text
(define (run editor)
  (big-bang editor
    [to-draw render]
    [on-key edit-limited-by-render]))

(run (make-editor "Hello there, " 13))