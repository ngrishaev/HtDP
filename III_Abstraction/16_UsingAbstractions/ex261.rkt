;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex261) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Inventory -> Inventory
; creates an Inventory from an-inv for all
; those items that cost less than a dollar
(define (extract1 an-inv)
  (cond
    [(empty? an-inv) '()]
    [else
     (cond
       [(<= (IR-price (first an-inv)) 1.0)
        (cons (first an-inv) (extract1 (rest an-inv)))]
       [else (extract1 (rest an-inv))])]))


(define (extract2 an-inv)
  (cond
    [(empty? an-inv) '()]
    [else
     (local [(define extract-rest (extract2 (rest an-inv)))]
       (cond
         [(<= (IR-price (first an-inv)) 1.0) (cons (first an-inv) extract-rest)]
         [else extract-rest]))
     ]))