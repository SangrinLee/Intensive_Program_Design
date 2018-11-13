;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname sorting) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|

Here is an algorithm for sorting lists of numbers

  - if the list has 0 elements or 1 element, it is sorted; return it.

  - if the list has 2 or more elements, divide the list into two
    halves and recursively sort them. Note that you can divide the
    elements in half multiple ways; it does not need to be the first
    half and second half; it may even be easier to take the odd numbered
    and even-numbered elements.

  - combine the two sorted sublists into a single one by merging them

Here is an algorithm for merging the two lists:

  - if either list is empty, return the other one
  
  - if both are not empty, pick the list with the
    smaller first element and break it up into
    it's first element and the rest of the list.
    Recur with the entire list whose first element is
    larger and the rest of the list whose first element
    is smaller. Then cons the first element onto the
    result of the recursive call.

Design functions that implement this sorting algorithm.
For each function, write down if it is generative recursion
or structural recursion. Also write down the running
time of each function using Big Oh notation.

|#

;Data Definition:
;a list-of-numbers is either:
;	  - '()
;	  - (cons number list-of-numbers)

;Template:
#;
(define (template-for-sort list)
  (cond
    [(empty? list) list]
    [(= 1 (length list)) list]
    [else
     (merge-lists odd-sorted-list even-sorted-list)]))


;Signature, purpose, and header:
;merge-sort: list-of-numbers -> list-of-numbers
;sort list-of-numbers in ascending order
;(define (merge-sort lon)...)


;Examples, Tests:
(check-expect (merge-sort '()) '())
(check-expect (merge-sort (list 1)) (list 1))
(check-expect (merge-sort (list 3 4 5 7 2 1 0 6)) (list 0 1 2 3 4 5 6 7))
(check-expect (merge-sort (list 34 24 12 10 8)) (list 8 10 12 24 34))
(check-expect (merge-sort (list 3 2 1 4 5)) (list 1 2 3 4 5))



(define (merge-sort lon)
  (cond
    [(empty? lon) lon]
    [(= 1 (length lon)) lon]
    [else
     (merge-lists
      (merge-sort (odd-numbered lon))
      (merge-sort (even-numbered lon)))]))



;Signature, purpose and header:
;odd-numbered: list-of-numbers -> list-of-numbers
;given a list-of-num,
;  returns a list of the numbers that are in odd numbered positions of the given list.
;(define (odd-numbered lon)...)

;Examples, Tests:
(check-expect (odd-numbered '()) '())
(check-expect (odd-numbered (list 3)) (list 3))
(check-expect (odd-numbered (list 3 2)) (list 3))
(check-expect (odd-numbered (list 3 1 9 7)) (list 3 9))
(check-expect (odd-numbered (list  1 0 3 83 42 4 3)) (list 1 3 42 3))
(check-expect (odd-numbered (list 5 4 2 3 8 1)) (list 5 2 8))


(define (odd-numbered lon)
  (cond
    [(empty? lon) lon]
    [else
     (cond
       [(empty? (rest lon)) lon]
       [else
        (cons (first lon) (odd-numbered (rest (rest lon))))])]))


;Signature, purpose and header:
;even-numbered: list-of-numbers -> list-of-numbers
;given a list-of-num,
;  returns a list of the numbers that are in even numbered positions of the given list.
;(define (even-numbered: lon)...)

;Examples, Tests:
(check-expect (even-numbered (list 3)) '())
(check-expect (even-numbered (list 3 2)) (list 2))
(check-expect (even-numbered (list 3 1 9 7)) (list 1 7))
(check-expect (even-numbered (list  1 0 3 83 42 4 3)) (list 0 83 4))
(check-expect (even-numbered (list 5 4 2 3 8 1)) (list 4 3 1))


(define (even-numbered lon)
  (cond
    [(empty? lon) lon]
    [else
     (cond
       [(empty? (rest lon)) '()]
       [else
        (cons (first (rest lon)) (even-numbered (rest (rest lon))))])]))


;Signature, purpose, and header
;merge-lists: list-of-numbers list-of-numbers -> list-of-numbers
;merge two already sorted lists
;(define (merge-lists list-1 list-2)...)

(check-expect (merge-lists (list 4) '())(list 4))
(check-expect (merge-lists (list 2) (list 5))(list 2 5))
(check-expect (merge-lists (list 2 3) (list 5))(list 2 3 5))
(check-expect (merge-lists (list 2 4 5 9 11) (list 3 6 16 18))(list 2 3 4 5 6 9 11 16 18))

(define (merge-lists list-1 list-2)
  (cond
    [(empty? list-1) list-2]
    [(empty? list-2) list-1]
    [else
     (cond
       [(< (first list-1) (first list-2))
        (cons (first list-1) (merge-lists (rest list-1) list-2))]
       [else
        (cons (first list-2) (merge-lists (rest list-2) list-1))])]))


