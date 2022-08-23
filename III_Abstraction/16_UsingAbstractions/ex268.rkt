;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex268) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct inventory-record [name desc ac-price rec-price])

; [List of InventoryRecord] -> [List of InventoryRecord]
(define (sort-inventory loi)
  (local [(define (invr-cmp i1 i2) (< (- (inventory-record-rec-price i1) (inventory-record-ac-price i1)) (- (inventory-record-rec-price i2) (inventory-record-ac-price i2))))]
    (sort loi invr-cmp)
    )
  )