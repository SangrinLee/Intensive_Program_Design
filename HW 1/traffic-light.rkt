;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |traffic-light(Sangrin Lee)|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

#|
In Chicago, some traffic lights have, in addition to the
red/orange/green phases, a special pedestrian
crossing indication that changes to walk slightly before
the light turns green and an orange hand that appears
slightly before the main traffic light turns orange.

Design a data-type to capture all of the different
states that the light can take on. (Our solution
has five states; yours should probably too, but if
you think a different number makes more sense, go
for it.) When changing from one state to the next,
either the light color should change or the
walk/don’t-walk status should change, never both.

Write functions to support a big-bang program that
draws a traffic light that cycles appropriately.
|#

;; A TrafficLight has 3 elements:
;; -- Light Color (either "red" "orange" or "yellow")
;; -- WalkSign (either "Walk" or "Don't Walk")
;; -- Time (an integer between 0 and 30)
(define-struct TrafficLight(LightColor WalkSign Time))

;; Template for TrafficLight
#;
(define (process-TrafficLight light ...)
  (cond
    [(string=? (TrafficLight-LightColor light) "red")    ...]
    [(string=? (TrafficLight-LightColor light) "yellow")    ...]
    [(string=? (TrafficLight-LightColor light) "green")    ...]
    [(string=? (TrafficLight-WalkSign light) "Walk")    ...]
    [(string=? (TrafficLight-WalkSign light) "Don't Walk")    ...])
)

;; DrawLightColor: TrafficLight -> Scene
;; Draws a Traffic Light with the correct light filled in
;;
;; Examples:
;; -- If Light is green, should draw a traffic light with only green circle filled in
;; -- If Light is yellow, should draw a traffic light with only yellow circle filled in
;; -- If Light is red, should draw a traffic light with only red circle filled in
;;
;; Strategy : struct. decomp.
(define (drawLightColor light)
  (cond
    [(string=? (TrafficLight-LightColor light) "red")       drawRed]
    [(string=? (TrafficLight-LightColor light) "yellow")    drawYellow]
    [(string=? (TrafficLight-LightColor light) "green")     drawGreen]
  ))

(check-expect (drawLightColor (make-TrafficLight "red" "Walk" 0)) 
  (overlay  (above (circle 10 "solid" "red")
                   (circle 5 "solid" "white")
                   (circle 10 "outline" "yellow")
                   (circle 5 "solid" "white")
                   (circle 10 "outline" "green"))
            (rectangle 30 90 "outline" "black")))

(check-expect (drawLightColor (make-TrafficLight "yellow" "Don't Walk" 5)) 
  (overlay  (above (circle 10 "outline" "red")
                   (circle 5 "solid" "white")
                   (circle 10 "solid" "yellow")
                   (circle 5 "solid" "white")
                   (circle 10 "outline" "green"))
            (rectangle 30 90 "outline" "black")))

(check-expect (drawLightColor (make-TrafficLight "green" "Walk" 59)) 
  (overlay  (above (circle 10 "outline" "red")
                   (circle 5 "solid" "white")
                   (circle 10 "outline" "yellow")
                   (circle 5 "solid" "white")
                   (circle 10 "solid" "green"))
            (rectangle 30 90 "outline" "black")))


;; Draws a Traffic Light with only the red light on
(define drawRed
  (overlay  (above (circle 10 "solid" "red")
                   (circle 5 "solid" "white")
                   (circle 10 "outline" "yellow")
                   (circle 5 "solid" "white")
                   (circle 10 "outline" "green"))
            (rectangle 30 90 "outline" "black")))


;; Draws a Traffic Light with only the yellow light on
(define drawYellow
  (overlay  (above (circle 10 "outline" "red")
                   (circle 5 "solid" "white")
                   (circle 10 "solid" "yellow")
                   (circle 5 "solid" "white")
                   (circle 10 "outline" "green"))
            (rectangle 30 90 "outline" "black")))


;; Draws a Traffic Light with only the green light on
(define drawGreen
  (overlay  (above (circle 10 "outline" "red")
                   (circle 5 "solid" "white")
                   (circle 10 "outline" "yellow")
                   (circle 5 "solid" "white")
                   (circle 10 "solid" "green"))
            (rectangle 30 90 "outline" "black")))

;; drawSign: TrafficLight -> Scene
;; Draws the Walk Sign
;;
;; Examples:
;; -- A TrafficLight with "Walk" should display a "Walk" message in a rectangle
;; -- A TrafficLight with "Don't Walk" should display a "Don't Walk" message in a rectangle
;;
;; Strategy : Struct. Decomp.
(define (drawSign light)
 (cond
    [(string=? (TrafficLight-WalkSign light) "Walk")       drawWalk]
    [(string=? (TrafficLight-WalkSign light) "Don't Walk")    drawDontWalk]
 ))

(check-expect (drawSign (make-TrafficLight "red" "Walk" 4))
  (overlay (rectangle 110 35 "outline" "black")
           (text "Walk" 20 "black")))

              
(check-expect (drawSign (make-TrafficLight "red" "Don't Walk" 4))
  (overlay (rectangle 110 35 "outline" "black")
           (text "Don't Walk" 20 "black")))

;; Displays a "Walk" message in a rectangle
(define drawWalk
  (overlay (rectangle 110 35 "outline" "black")
           (text "Walk" 20 "black")))


;; Displays a "Don't Walk" message in a rectangle
(define drawDontWalk
  (overlay (rectangle 110 35 "outline" "black")
           (text "Don't Walk" 20 "black")))

;; drawScene: TrafficLight -> Scene
;; Draws both the traffic light and Walk/Don't Walk
;;
;; Examples:
;; -- If Light is red and WalkSign is "Don't Wallk", should draw a traffic light with only red circle filled in and display a "Don't Walk" message in a rectangle
;; -- If Light is red and WalkSign is "Walk", should draw a traffic light with only red circle filled in and display a "Walk" message in a rectangle
;; -- If Light is green and WalkSign is "Walk", should draw a traffic light with only green circle filled in and display a "Walk" message in a rectangle
;; -- If Light is green and WalkSign is "Don't Walk", should draw a traffic light with only green circle filled in and display a "Don't Walk" message in a rectangle
;; -- If Light is yellow and WalkSign is "Don't Walk", should draw a traffic light with only yellow circle filled in and display a "Don't Walk" message in a rectangle
;;
;; Strategy : Struct. Decomp.
(define (drawScene light)
  (overlay/xy (drawSign light) -40 -30 (drawLightColor light)))

(check-expect (drawScene (make-TrafficLight "red" "Walk" 0))
              (overlay/xy (drawSign (make-TrafficLight "red" "Walk" 0)) -40 -30 (drawLightColor (make-TrafficLight "red" "Walk" 0))))
(check-expect (drawScene (make-TrafficLight "yellow" "Don't Walk" 5))
              (overlay/xy (drawSign (make-TrafficLight "yellow" "Don't Walk" 5)) -40 -30 (drawLightColor (make-TrafficLight "yellow" "Don't Walk" 5))))
(check-expect (drawScene (make-TrafficLight "green" "Walk" 59))
              (overlay/xy (drawSign (make-TrafficLight "green" "Walk" 59)) -40 -30 (drawLightColor (make-TrafficLight "green" "Walk" 59))))

;; counter: TrafficLight -> TrafficLight
;; Ticks the counter of the TrafficLight. Once the counter reaches 30, the counter resets
;;
;; Examples:
;; -- If the time reaches 30, it resets
;; -- Otherwise, ticks increase by 1. 
;;
;; Strategy : Decision Tree
(define (counter light)
   (cond
     [(= (TrafficLight-Time light) 30) (make-TrafficLight (TrafficLight-LightColor light) (TrafficLight-WalkSign light) 0)]
     [else (make-TrafficLight (TrafficLight-LightColor light) (TrafficLight-WalkSign light) (+ (TrafficLight-Time light) 1/28))]
))
(check-expect (counter (make-TrafficLight "red" "Walk" 10)) (make-TrafficLight "red" "Walk" (+ 10 1/28)))
(check-expect (counter (make-TrafficLight "red" "Walk" 30)) (make-TrafficLight "red" "Walk" 0))


;; trafficSim: TrafficLight -> Scene
;; Based off the counter, draws the appropriate trafficLight. TrafficLight should go through the following stages:
;; 15 seconds of Red/Don'tWalk
;; 1 second of Red/Walk
;; 10 Seconds of Green/Walk
;; 3 Seconds of Green/Don'tWalk
;; 1 second of Yellow/Don'tWalk
;;
;; Examples:
;; -- If timer is between 0 and 15, should draw a red light and don't walk
;; -- If timer is between 16 and 26, should draw a green light and walk
;;
;; Strategy : Interval Decomposition
(define (trafficSim light)
  (cond
    [(and (<= 0 (TrafficLight-Time light)) (< (TrafficLight-Time light) 15)) (drawScene (make-TrafficLight "red" "Don't Walk" (TrafficLight-Time light)))]
    [(and (<= 15 (TrafficLight-Time light)) (< (TrafficLight-Time light) 16)) (drawScene (make-TrafficLight "red" "Walk" (TrafficLight-Time light)))]
    [(and (<= 16 (TrafficLight-Time light)) (< (TrafficLight-Time light) 26)) (drawScene (make-TrafficLight "green" "Walk" (TrafficLight-Time light)))]
    [(and (<= 26 (TrafficLight-Time light)) (< (TrafficLight-Time light) 29)) (drawScene (make-TrafficLight "green" "Don't Walk" (TrafficLight-Time light)))]
    [(<= 29 (TrafficLight-Time light)) (drawScene (make-TrafficLight "yellow" "Don't Walk" (TrafficLight-Time light)))]
))
(check-expect (trafficSim (make-TrafficLight "red" "Don't Walk" 2)) (drawScene (make-TrafficLight "red" "Don't Walk" 2)))
(check-expect (trafficSim (make-TrafficLight "green" "Walk" 20)) (drawScene (make-TrafficLight "green" "Walk" 20)))


(big-bang (make-TrafficLight "red" "Don't Walk" 0)
          (on-tick counter)
          (on-draw trafficSim))