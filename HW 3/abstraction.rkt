;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname abstraction) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; Do not write any recursive functions for this homework.

;; Use map to write this function:
;; build-straight-line : num (listof num) -> (listof posn)
;; returns a list of posns where the X coordinate is n and 
;; the Y coordinate is a number
;; in lon
;; e.g., (build-straight-line 2 (list 1 2 3)) 
;;       (list (make-posn 2 1) (make-posn 2 2) (make-posn 2 3))
;; (define (build-straight-line n lon) ...)

(define (build-straight-line n lon)
  (map (lambda (x) (make-posn n x)) lon))

(check-expect (build-straight-line 4 (list 1 2 3))
              (list (make-posn 4 1) (make-posn 4 2) (make-posn 4 3)))

;; Use filter to write this function:
;; pts-north : posn (listof posn) -> (listof posn)
;; returns the posns from lop that are north of p,
;; that is, whose y coordinate is greater than p's y coordinate
;; (define (pts-north p lop) ...)

(define (pts-north n lop)
  (filter (lambda (x) (< n (posn-y x))) lop))

(check-expect (pts-north 3 (list (make-posn 4 1) (make-posn 4 4) (make-posn 5 7)))
              (list (make-posn 4 4) (make-posn 5 7)))

;; Use foldr to write this function:
;; total-width : (listof image) -> num
;; returns the sum of the widths of all images in loi
;; (define (total-width loi) ...)

(define img1 (rectangle 20 40 "solid" "blue"))
(define img2 (rectangle 60 40 "solid" "blue"))
(define img3 (rectangle 100 40 "solid" "blue"))

(define (total-width loi)
   (foldr (lambda (x y) (+ (image-width x) y)) 0 loi))

(check-expect (total-width (list img1 img2 img3)) 180)
              
;; Use map filter and foldr to write the next four functions.

;; The next exercises use functions to represent curves in the plane. A
;; curve can be represented as a function that accepts an x coordinate
;; and returns a y coordinate. For example, the straight line through the
;; origin can be represented as:
(define (diagonal x) x)
;; and a parabola sitting on the origin can be represented as 
(define (parabola x) (* x x))

(define points (list (make-posn 1 0) (make-posn 1 1) (make-posn 2 2)))


;; points-on-line : (num -> num) (listof posn) -> (listof posn)
;; return the points in pts that are on the curve described by f
;; e.g., (points-on-line diagonal points)
;;       (list (make-posn 1 1) (make-posn 2 2))
;; and   (points-on-line parabola points)
;;       (list (make-posn 1 1))
;; (define (points-on-line f pts) ...)

(define (points-on-line f pts)
  (filter (lambda (x) (= (posn-x x) (f (posn-y x)))) pts))
(check-expect (points-on-line diagonal (list (make-posn 1 1) (make-posn 1 2) (make-posn 2 2)))
              (list (make-posn 1 1) (make-posn 2 2)))
(check-expect (points-on-line parabola (list (make-posn 1 1) (make-posn 1 2) (make-posn 2 2)))
              (list (make-posn 1 1)))

;; positions: (num -> num) (listof num) -> (listof posn)
;; returns a list of positions on the curve `f' whose x-coordinates
;; are in lon
;; e.g., (positions parabola (list 1 2 3)) 
;;       (list (make-posn 1 1) (make-posn 2 4) (make-posn 3 9))
;; (define (positions f lon) ...)

(define (positions f lon)
  (map (lambda (x) (make-posn x (f x))) lon))

(check-expect (positions parabola (list 1 2 3))
              (list (make-posn 1 1) (make-posn 2 4) (make-posn 3 9)))
              
;; flatten-posns : (listof posn) -> (listof num)
;; constructs the list consisting of all the X and Y coordinates of each
;; of the posns in lop, in order.
;; e.g., (flatten-posns points)
;;       (list 1 0 1 1 2 2)
;; (define (flatten-posns lop) ...)

(define (flatten-posn lop)
  (foldr (lambda (x y) (cons (posn-x x) (cons (posn-y x) y))) '() lop))

(check-expect (flatten-posn (list (make-posn 1 2) (make-posn 3 4) (make-posn 5 6)))
              (list 1 2 3 4 5 6))
    

;; possible-y-coords : (listof (num -> num)) num -> (listof num)
;; given a list of lines lof and an x-coordinate, returns the list
;; of what y-coordinate is associated with that x-coordinate in each curve
;; e.g., (possible-y-coords (list diagonal parabola) 7)
;;       (list 7 49)
;; (define (possible-y-coords lof x) ...)

(define (possible-y-coords lof x)
  (map (lambda (f) (f x)) lof))

(check-expect (possible-y-coords (list diagonal parabola) 7)
              (list 7 49))