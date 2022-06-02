;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex81) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Hours represent how many hours passed since midnight
; Interval between 0..23

; Minutes represent how many minutes passed since last hour
; Interval between 0..59

; Seconds represent how many minutes passed since last hour
; Interval between 0..59

(define-struct Midnight-Time [Hours Minutes Seconds])
; MidnightTime is a structure:
;    (make-Midnight-Time h m s)
; interpretation
;     MidnightTime represent point in time since midnight
;     (make-Midnight-Time 1 12 25) represent point in time since recent midnight at 1 hour, 12 minutes and 25 seconds


; MidnightTime -> Number
; Convert point in time into total seconds representation
(define (time->seconds time)
  (+
   (* (Midnight-Time-Hours time) 60 60)
   (* (Midnight-Time-Minutes time) 60)
   (Midnight-Time-Seconds time)
   )
  )