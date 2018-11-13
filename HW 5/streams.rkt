;; Programming using Dr. Racket by Ishmael and Sangrin
;; Streams homework, October 22, 2016.

#lang dssl

;; a Stream is:
;;   (make-stream number (-> Stream))
(define-struct stream (num rest))

;; A Template for Stream
#;
(define (template-for-stream stream)
  ... (stream-num stream) ...
  ... (template-for-stream ((stream-rest stream))) ...)

;; Definition of stream with natural numbers
(define nats (make-stream 0 (λ () (add1-stream nats))))

;; add1-stream : Stream -> Stream
;; makes Stream with adding 1 on the num of given Stream
;; Strategy: struct. decomp.
(define (add1-stream stream)
  (make-stream (add1 (stream-num stream))
               (λ () (add1-stream ((stream-rest stream))))))

;; take : Nat Stream -> (Listof Numbers)
;; to find the nth element of the stream.
;; structural template on Nat.
;; Strategy: struct. decomp.
(define (take n stream)
  (cond
    [(zero? n) '()]
    [else (cons (stream-num stream)
                (take (- n 1) ((stream-rest stream))))]))

;; map-stream : (Number -> Number) Stream -> Stream
;; Generalizing function to map-stream
;; Strategy: struct. decomp.
(define (map-stream f stream)
  (make-stream (f (stream-num stream))
               (λ () (map-stream f ((stream-rest stream))))))


#|
Define the stream of all perfect squares. The first few numbers
are: 0 1 4 9 16 25 36 49 64 81.
|#

;; square : Number -> Number
;; gets perfect square of given number
;; Strategy : Domain Knowledge
;; Examples & Tests
(check-expect (square 0) 0)
(check-expect (square 2) 4)
(check-expect (square 3) 9)
(define (square x) (* x x))

;; Definition of stream with square function and natural numbers
(define squares (map-stream square nats))

;; Tests for squares.
(check-expect (take 0 squares) '())
(check-expect (take 5 squares) (list 0 1 4 9 16))
(check-expect (take 10 squares)
              (list 0 1 4 9 16 25 36 49 64 81))
(check-expect (take 15 squares)
              (list 0 1 4 9 16 25 36 49 64 81 100 121 144 169 196))
  
#|
Define a stream that has all of the even integers.
This is a good way to organize that stream:
   0 2 -2 4 -4 6 -6 8 -8 10 -10 12 -12
(but it isn't the only way). 
|#

;; even : Number -> Number
;; gets 0 if it's zero
;; gets even number if it's odd index
;; gets negative even number if it's even index
;; Strategy : Domain Knowledge
;; Examples & Tests
(check-expect (even 0) 0)
(check-expect (even 3) 4)
(check-expect (even 4) -4)
(define (even x)
  (cond
    [(zero? (modulo x 2)) (- x)]
    [else (+ 1 x)]))

;; Definition of stream with even function and natural numbers
(define evens (map-stream even nats))

;; Tests for evens.
(check-expect (take 0 evens) '())
(check-expect (take 5 evens) (list 0 2 -2 4 -4))
(check-expect (take 10 evens)
              (list 0 2 -2 4 -4 6 -6 8 -8 10))
(check-expect (take 15 evens)
              (list 0 2 -2 4 -4 6 -6 8 -8 10 -10 12 -12 14 -14))


#|
The fibonacci numbers start with 0, then 1, and each
number aftewards is the sum of the previous two
numbers. Here are the first few numbers:
0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377
Using the stream data definition, define a stream
that consists of all of the fibonnaci numbers.
|#

;; fib : Number -> Number
;; gets fibonacci number of given number
;; which is the sum of the previous two numbers
;; Strategy : Domain Knowledge
;; Examples & Tests
(check-expect (fib 0) 0)
(check-expect (fib 1) 1)
(check-expect (fib 2) 1)
(check-expect (fib 3) 2)
(check-expect (fib 4) 3)
(define (fib x)
  (cond
    [(= x 0) 0]
    [(= x 1) 1]
    [else (+ (fib (- x 1))
             (fib (- x 2)))]))

;; Definition of stream with fib function and natural numbers
(define fibs (map-stream fib nats))

;; Tests for fibs.
(check-expect (take 0 fibs) '())
(check-expect (take 1 fibs) (list 0))
(check-expect (take 5 fibs) (list 0 1 1 2 3))
(check-expect (take 10 fibs) (list 0 1 1 2 3 5 8 13 21 34))
(check-expect (take 15 fibs)
              (list 0 1 1 2 3 5 8 13 21 34 55 89 144 233 377))
(check-expect (take 20 fibs)
              (list 0 1 1 2 3 5 8 13 21 34 55 89 144 233 377
                    610 987 1597 2584 4181))