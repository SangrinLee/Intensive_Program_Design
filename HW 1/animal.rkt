;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname animalNeumanLee) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/image)

; Creates an eye of the cat
(define eye
  (overlay    (circle 4 "outline" "black")
               (circle 4 "solid" "orange")
              (circle 10 "solid" "white")))

; Creates the nose of the cat
(define nose
  (flip-vertical (isosceles-triangle 25 85 "solid" "orange")))

; Creates the right ear of the cat
(define right-ear (
  rotate 65 (triangle/ass 90 30 45 "solid" "black")))

; Creates the left ear of the cat by reflecting the right ear horizontally
(define left-ear
  (flip-horizontal right-ear))

; Creates whiskers for the right side of the cat's face
(define right-whiskers
  (above (line 50 -10 "orange")(line 50 0 "orange")(line 50 10 "orange")))

; Creates whiskers for the left side of the cat's face by reflecting the whiskers of the right side
(define left-whiskers
  (flip-horizontal right-whiskers))

; Creates the cat's face with everything except ears
(define cat-noears
  (overlay (above (beside eye (circle 10 "solid" "black") eye)
                  (circle 5 "solid" "black")
                  (beside left-whiskers  nose  right-whiskers))
           (circle 60 "solid" "black")))

; Creates the cat with all features
(define cat
  (overlay/xy
   (beside left-ear
           (rectangle 50 0 "solid" "red")
           right-ear) -15 20
   cat-noears))

cat
