;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |Fibs - Ishmael|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;#lang dssl
#|

To use the `dssl` language, use the "Language | Choose Language"
dialog to select "The Racket Language".

You also need to install the language. Go to the "File | Install Package..."
menu item in DrRacket. Type "dssl" in the box and click "Install".

|#
;; a Stream is:
;;   (make-stream number (-> Stream))

(define-struct stream (num rest))
;; take : Nat Stream -> (Listof Numbers)
;; to find the nth element of the stream.
;; structural template on Nat.
#;
(define (take n stream)
  (cond
    [(zero? n) '()]
    [else (cons (stream-num stream)
                (take (- n 1) ((stream-rest stream))))]))
#;
(define ones (make-stream 1 (λ () ones)))

(define (fiblist n)
  (cond
    [(= n 0) '()]
    [(= n 1) '(1)]
    [(= n 2) '(1 1)]
    (else (let ((f (fiblist (- n 1))))
            (cons (+ (first f) (second f)) f)))))

(define (fib n) (reverse (fiblist n)))

(check-expect (fiblist 5) '(5 3 2 1 1))
(check-expect (fiblist 6) '(8 5 3 2 1 1))
(check-expect (fiblist 10) '(55 34 21 13 8 5 3 2 1 1))
(check-expect (fiblist 15) '(610 377 233 144 89 55 34 21 13 8 5 3 2 1 1))
(check-expect (fiblist 25) '(75025 46368 28657 17711 10946 6765 4181 2584 1597 987 610 377 233 144 89
                             55 34 21 13 8 5 3 2 1 1))

;(define )