;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname contains-telephone) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; [Listof String] is either:
;; - '()
;; - (cons String [Listof String]
;;
;; Template for contains-telephone
#;
(define (contains-telephone l)
  (cond
    [(empty? l) ...]
    [else ... (first l) ...
          ... (contains-telephone (rest l)) ...]))
;;
;; contains-telephone : [listof String] -> Boolean
;; returns #true if 'l' contains the symbol 'telephone, #false otherwise
;; (define (contains-telephone l) ...)
;;
;; Examples:
;; - Given [list '()], result is #false
;; - Given [list 'apple 'banana, 'cat], result is #false
;; - Given [list 'apple 'telephone 'cat', result is #true
;;
;; Strategy : Struct. decomp.
(define (contains-telephone l)
  (cond
    [(empty? l) #false]
    [(symbol=? (first l) 'telephone) #true]
    [else (contains-telephone (rest l))]))

(check-expect (contains-telephone '()) #false)
(check-expect (contains-telephone (list 'apple 'banana 'cat)) #false)
(check-expect (contains-telephone (list 'apple 'telephone 'cat)) #true)
