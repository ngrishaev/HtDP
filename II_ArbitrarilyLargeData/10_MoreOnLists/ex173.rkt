;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex173) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

(define los1 (cons "Hello" (cons "world!" '())))
(define los2 (cons "An" (cons "Another" (cons "test" (cons "string" '())))))
(define LLN (cons los1 (cons los2 '())))

; Article is one of
; - a
; - an
; - the
; - A
; - An
; - The

(define ARTICLES (cons "A" (cons "a" (cons "An" (cons "an" (cons "The" (cons "the" '())))))))

; String -> Boolean
; Is input string appear to be an article?
(define (article? str)
  (member? str ARTICLES))

; LLN -> LLN
; Remove articles from LLN
(define (remove-articles-lln lln)
  (cond
    [(empty? lln) '()]
    [else (cons (remove-articles-los (first lln)) (remove-articles-lln (rest lln)))]
   ))

; LOS -> LOS
; Remove articles from LOS
(define (remove-articles-los los)
  (cond
    [(empty? los) '()]
    [(article? (first los)) (remove-articles-los (rest los))]
    [else (cons (first los) (remove-articles-los (rest los)))]
   ))

; LLN -> String
; Collapse LLN into one string
(define (collapse lln)
  (cond
    [(empty? lln) ""]
    [else (string-append (collapse-los (first lln)) "\n" (collapse (rest lln)))]
   ))


; LOS -> String
; Collapse LOS into one string
(define (collapse-los los)
  (cond
    [(empty? los) ""]
    [(empty? (rest los)) (first los)]
    [else (string-append (first los) " " (collapse-los (rest los)))]
    ))

; FileName -> FileName
(define (remove-articles fn)
  (write-file (string-append "no-articles-" fn) (collapse (remove-articles-lln (read-words/line fn)))))

(remove-articles "ttt.txt")

  


