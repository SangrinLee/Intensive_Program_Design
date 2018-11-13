;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname shortest) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; [NE-list-of-String] is:
;; - (cons String [Listof String]
;;
;; Template for shortest
#;
(define (shortest l)
  (local ((define (sort l)
            (cond
              [(empty? l) ...]
              [else ... (first l) ...
                    ... (sort (rest l)) ...]))
          (define (compare x l)
            (cond
              [(empty? l) ...]
              [else
               (cond
                 [... (string-length x) (string-length (first l)) ...]
                 [else ... (first l) (compare x (rest l)) ...])]))
          (first (sort l)))))
;;
;; shortest : [NE-list-of String] -> String
;; returns the shortest string in 'l'
;; (define (shortest l) ...)
;; Examples:
;; - Given [list "bb" "a" "ccc" "dddd"], result is "a"
;; - Given [list "abc" "bb" "dddd" "e"], result is "e"
;;
;; Strategy : Function Composition
(define (shortest l)
  (local ((define (sort l)
            (cond
              [(empty? l) l]
              [else (compare (first l) (sort (rest l)))]))
          (define (compare x l)
            (cond
              [(empty? l) (list x)]
              [else
               (cond
                 [(< (string-length x) (string-length (first l))) (cons x l)]
                 [else (cons (first l) (compare x (rest l)))])])))
    (first (sort l))))

(check-expect (shortest (list "bb" "ccc" "cccc" "e")) "e")
(check-expect (shortest (list "apple" "banana" "cat" "orange")) "cat")
