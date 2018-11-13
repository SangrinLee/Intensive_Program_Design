;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname functionsNeumanLee) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
#|
The City of Chicago regulates taxi fares, setting two kinds of rates:
there are meter fares for most pickups, and flat-rate fares for known
distances such as rides from hotels to the airport. The meter rates
are set as follows: The base fare for any ride is $3.05, and it costs
$1.80 per mile of travel.

How much does a 0.5 mi. ride cost? How about 1 mi.? 2 mi.?

3.05 + 1.80*0.5 = $3.95 for a 0.5 mile ride
3.05 + 1.80*1.0 = $4.85 for a 1 mile ride
3.05 + 1.80*2.0 = $6.65 for a 2 miles ride

Make a table that shows the fare for distances of 0.5  mi., 1 mi, 1.5
mi, 2 mi., 2.5 mi., 3 mi.

   Distance (in miles)                Fare (in dollars)
       0.5                              $3.95
       1.0                              $4.85
       1.5                              $5.75
       2.0                              $6.65
       2.5                              $7.55
       3.0                              $8.45

Create a formula for calculating fares from trip distances.

Meter Rate = 3.05 + 1.80m where m is miles

Use the formula to design a function that computes a taxi fare given
the distance traveled.
|#

;; (f x): Number -> Number
;; Gives the Meter Rate of a cab given the number of miles

;; Examples:
;; - If distance traveled is 0.5 miles, should cost $3.95
;; - If distance traveled is 3.0 miles, should cost $8.45
;; Strategy : Domain Knowledge

(define (f x) (+ (* 1.8 x) 3.05))

(check-expect (f 0.5) 3.95)
(check-expect (f 3.0) 8.45)


#|
To supplement my meager teaching income, I shovel snow for some of my
neighbors. For shoveling a sidewalk and driveway, I charge each
neighbor $10 per job plus $5 per inch of snowfall to be shoveled.

How much do I get paid if I shovel for one neighbor after a storm that
drops 1 inch of snow? What if 4 neighbors hire me after a blizzard
puts down 14 inches?

1*(10 + 5*1) = 1*(15) = $15  for 1 neighbor(s) and 1   inch(es) of snow
4*(10 + 5*14)= 4*(80) = $320 for 4 neighbor(s) and 14  inch(es) of snow

Make a table that shows my income in terms of both inches of snow and
the number of neighbors that hire me. (The table should have at least
9 values.)

########     1 neighbor      2 neighbors      3 neighbors


1 inch       1*(10 + 5*1)    2*(10 + 5*1)     3*(10 + 5*1)
                = $15           = $30            = $45

2 inches     1*(10 + 5*2)    2*(10 + 5*2)     3*(10 + 5*2)
                = $20           = $40            = $60

3 inches     1*(10 + 5*3)    2*(10 + 5*3)     3*(10 + 5*3)
                = $25           = $50            = $75

Create a formula for calculating how much I earn if I shovel d inches
of snow for each of n neighbors.

Money earned = n*(10 + 5d) where n is the number of neighbors and d is the inches of snow

Use the formula to design a function that computes my snow shoveling
income given both the number of inches and number of neighbors.
|#

;; (g d n): Number Number -> Number
;; Gives the money earned based off of number of neighbors and inches of snow

;; Examples:
;; - If 2 inches of snow fall with 1 neighbor, money earned should be $20
;; - If 3 inches of snow fall with 3 neighbors, money earned should be $75
;; Strategy : Domain Knowledge
(define (g d n) (* (+ (* 5 d) 10) n))

(check-expect (g 2 1) 20)
(check-expect (g 3 3) 75)