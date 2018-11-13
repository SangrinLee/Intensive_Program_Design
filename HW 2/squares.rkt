;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname squares) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; [Listof Number] is either:
;; - '()
;; - (cons number [Listof Number]
;;
;; Template for squares
#;
(define (squares l)
  (cond
    [(empty? l) ...]
    [else ... (first l) ...
          ... (squares (rest l)) ...]))
;;
;; squares : [Listof Number] -> [Listof Number]
;; compute the perfect squares of numbers in `l`
;; (define (squares l) ...)
;; 
;; Examples:
;; - Given [list 1 3 5], result is [list 1 9 25]
;; - Given [list 2 4 6], result is [list 4 16 64]
;;
;; Strategy : Struct. decomp.
(define (squares l)
  (cond
    [(empty? l) l]
    [else (cons (sqr (first l)) (squares (rest l)))]))

(check-expect (squares '()) '())
(check-expect (squares (list 1 4)) (list 1 16))
(check-expect (squares (list 2 5 7 3)) (list 4 25 49 9))
