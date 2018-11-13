;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname list) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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