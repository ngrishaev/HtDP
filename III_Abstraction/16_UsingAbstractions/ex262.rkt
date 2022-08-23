;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex262) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; IdentityM
; Is a list of N sublists, each with length N
; Ith sublist contains 1 on ith position in it
; Other positions contains 0

; Number -> IdentityM
; Builds IdentityM size of n
(define (identityM n)
  (local [
          ; Number Number Number -> List-of Numbers
          ; Build row for identity matrix, where on identity-pos placed 1, current-pos - current position for building and width - total width of the row
          (define (build-identity-row current-pos identity-pos width)
            (cond
              [(= current-pos width) '()]
              [else (cons
                     (if (= current-pos identity-pos) 1 0)
                     (build-identity-row (add1 current-pos) identity-pos width))])            )
          ; Number Number -> [List-of [List-of Number]]
          ; Building identity matrix, where size - total size of matrix and current-row - row that currently being build
          (define (build-identity-matrix size current-row)
            (cond
              [(= current-row size) '()]
              [else (cons (build-identity-row 0 current-row size) (build-identity-matrix size (add1 current-row)))]
              ))
          ]
    ; -- IN --
    (build-identity-matrix n 0))
  )


(identityM 2)


