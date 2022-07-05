;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex109) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH 100)
(define HEIGHT 100)
(define START (empty-scene WIDTH HEIGHT))
(define EXPECT (rectangle WIDTH HEIGHT "solid" "yellow"))
(define FINISHED (rectangle WIDTH HEIGHT "solid" "green"))
(define ERROR (rectangle WIDTH HEIGHT "solid" "red"))


; FSM is string, one of:
; – AA
; – BB
; – DD 
; – ER 
 
(define AA "start, expect an 'a'")
(define BB "expect 'b', 'c', or 'd'")
(define DD "finished")
(define ER "error, illegal key" )


(define (run fsm)
  (big-bang fsm
    [to-draw render-fsm]
    [on-key control-fms]
    ))

(define (render-fsm fsm)
  (cond
    [(string=? AA fsm) START]
    [(string=? BB fsm) EXPECT]
    [(string=? DD fsm) FINISHED]
    [(string=? ER fsm) ERROR]
    )
  )

(define (control-fms fsm key)
  (cond
    [(string=? AA fsm) (control-AA key)]
    [(string=? BB fsm) (control-BB key)]
    [(string=? ER fsm) ER]
    [(string=? DD fsm) DD]
    )
  )

(define (control-AA key)
  (cond
    [(string=? "a" key) BB]
    [else ER]
    )
  )

(define (control-BB key)
  (cond
    [(or (string=? "b" key) (string=? "c" key)) BB]
    [(string=? "d" key) DD]
    [else ER]
    )
  )

(run AA)