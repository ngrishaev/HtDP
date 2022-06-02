;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex83) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

; Editor -> Image
; Renders editor as image
(define (render editor)
  (overlay/align "left" "center"
                 (beside
                  (text (editor-pre editor) 11 "black")
                  (rectangle 1 16 "solid" "red")
                  (text (editor-post editor) 11 "black")
                 )
                 (empty-scene 200 20)
                 )
  )

(render (make-editor "General " "Kenobi"))