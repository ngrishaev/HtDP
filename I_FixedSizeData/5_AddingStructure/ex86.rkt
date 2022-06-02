;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex86) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH 200)

; Direction is one of the following strings:
; - "left"
; - "right"

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t




; Editor Direction -> Editor
; Move divider to right or to left
(check-expect (editor-move-cursor (make-editor "ab" "cd") "left") (make-editor "a" "bcd"))
(check-expect (editor-move-cursor (make-editor "b" "cd") "left") (make-editor "" "bcd"))
(check-expect (editor-move-cursor (make-editor "" "cd") "left") (make-editor "" "cd"))
(check-expect (editor-move-cursor (make-editor "ab" "") "left") (make-editor "a" "b"))
(check-expect (editor-move-cursor (make-editor "" "") "left") (make-editor "" ""))
(check-expect (editor-move-cursor (make-editor "ab" "cd") "right") (make-editor "abc" "d"))
(check-expect (editor-move-cursor (make-editor "b" "cd") "right") (make-editor "bc" "d"))
(check-expect (editor-move-cursor (make-editor "" "cd") "right") (make-editor "c" "d"))
(check-expect (editor-move-cursor (make-editor "ab" "") "right") (make-editor "ab" ""))
(check-expect (editor-move-cursor (make-editor "" "") "right") (make-editor "" ""))
(define (editor-move-cursor e d)
  (cond
   [(and (string? d) (string=? d "left"))
    (make-editor
     (string-try-remove-last (editor-pre e))
     (string-append (string-try-get-last (editor-pre e)) (editor-post e))
     )
    ]
   [(and (string? d) (string=? d "right"))
    (make-editor
     (string-append (editor-pre e) (string-try-get-first (editor-post e)))
     (string-try-remove-first (editor-post e))
     )
    ]
   ) 
  )


; Editor KeyEvent -> Editor
; Update editor correspondely to key
(check-expect (edit (make-editor "a" "c") "b") (make-editor "ab" "c"))
(check-expect (edit (make-editor "aaaav" "g") "a") (make-editor "aaaava" "g"))
(check-expect (edit (make-editor "" "g") "a") (make-editor "a" "g"))
(check-expect (edit (make-editor "" "") "a") (make-editor "a" ""))
(check-expect (edit (make-editor "asd" "") "a") (make-editor "asda" ""))
(check-expect (edit (make-editor "ab" "cd") "left") (make-editor "a" "bcd"))
(check-expect (edit (make-editor "ab" "cd") "right") (make-editor "abc" "d"))
(check-expect (edit (make-editor "ab" "cd") "nope") (make-editor "ab" "cd"))
(check-expect (edit (make-editor "ab" "cd") "\b")  (make-editor "a" "cd"))
(check-expect (edit (make-editor "b" "cd") "\b")  (make-editor "" "cd"))
(check-expect (edit (make-editor "" "cd") "\b")  (make-editor "" "cd"))
(check-expect (edit (make-editor "ab" "") "\b")  (make-editor "a" ""))
(check-expect (edit (make-editor "" "") "\b")  (make-editor "" ""))
(define (edit e ke)
  (cond
   [(and (string? ke) (= (string-length ke) 1) (or (and (string<=? ke "z") (string>=? ke "a")) (and (string<=? ke "Z") (string>=? ke "A")) (string=? ke " ")))
     (make-editor
      (string-append (editor-pre e) ke)
      (editor-post e))
    ]
   [(and (string? ke) (or (string=? ke "left") (string=? ke "right")))
    (editor-move-cursor e ke)
    ]
   [(and (string? ke) (string=? ke "\b"))
    (make-editor
      (string-try-remove-last (editor-pre e))
      (editor-post e))
    ]
   [else e]
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


; String -> String
; Removes last character from string
; If string is empty do nothing
(check-expect (string-try-remove-last "hello") "hell")
(check-expect (string-try-remove-last "h") "")
(check-expect (string-try-remove-last "") "")
(define (string-try-remove-last str)
  (if (string-empty? str)
      str
      (substring str 0 (- (string-length str) 1 ))
      )
  )


; String -> String
; Removes first character from string if string is not empty
; Do nothing otherwise
(check-expect (string-try-remove-first "hello") "ello")
(check-expect (string-try-remove-first "h") "")
(check-expect (string-try-remove-first "") "")
(define (string-try-remove-first str)
  (if (string-empty? str)
      str
      (substring str 1)
      )
  )

; String -> 1String
; Returns first char of string
; Returns empty string if string is empty
(check-expect (string-try-get-last "hello") "o")
(check-expect (string-try-get-last "h") "h")
(check-expect (string-try-get-last "") "")
(define (string-try-get-last str)
  (if (string-empty? str)
      str
      (string-ith str (- (string-length str) 1))
      )
  )

; String -> 1String
; Returns first char of string
; Returns empty string if string is empty
(check-expect (string-try-get-first "hello") "h")
(check-expect (string-try-get-first "h") "h")
(check-expect (string-try-get-first "") "")
(define (string-try-get-first str)
  (if (string-empty? str)
      str
      (string-ith str 0)
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
   (text (editor-pre editor) 11 "black")
   (rectangle 1 16 "solid" "red")
   (text (editor-post editor) 11 "black")
   )
  )

; Editor -> Editor
; Interactive programm that let you edit text
(define (run editor)
  (big-bang editor
    [to-draw render]
    [on-key edit-limited-by-render]))

(run (make-editor "Hello there, " ""))