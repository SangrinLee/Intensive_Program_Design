;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname mean) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; [Listof Number] is either:
;; - '()
;; - (cons String [Listof String]
;;
;; Template for mean
#;
(define (mean l)
  (local ((define (compute l)
            (cond
              [(empty? l) ...]
              [else ... (avg l) ...]))
          (define (avg list)
            (... (sum list) (number list)) ...)
          (define (sum list)
            (cond
              [(empty? list) ...]
              [else ... (first list) (sum (rest list)) ...]))
          (define (number list)
            (cond
              [(empty? list) ...]
              [else ... (number (rest list)) ...])))
    (compute l)))
;;
;; mean : [Listof Number] -> Number
;; computes the average of the elements of 'l'
;; return 0 if 'l' list is empty
;; (define (mean l) ...)
;;
;; Examples :
;; - Given [list 4 3 1 2], result is 2.5
;; - Given [list 1 3 5 7 9], result is 5
;;
;; Strategy : Function composition
(define (mean l)
  (local ((define (compute l)
            (cond
              [(empty? l) 0]
              [else (avg l)]))
          (define (avg list)
            (/ (sum list) (number list)))
          (define (sum list)
            (cond
              [(empty? list) 0]
              [else (+ (first list) (sum (rest list)))]))
          (define (number list)
            (cond
              [(empty? list) 0]
              [else (+ 1 (number (rest list)))])))
    (compute l)))

(check-expect (mean '()) 0)
(check-expect (mean (list 4 3 1 2)) 2.5)
(check-expect (mean (list 1 3 5 7 9)) 5)