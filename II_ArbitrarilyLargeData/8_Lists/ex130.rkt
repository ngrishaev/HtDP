#lang racket


; A List-of-names is one of: 
; – '()
; – (cons String List-of-names)
; interpretation a list of invitees, by last name

(cons "Schultz" (cons "Rasmussen" (cons "Giles" (cons "Mcpherson" (cons "Hickman" '())))))
