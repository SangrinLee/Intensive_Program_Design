;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname alpaca-genealogy) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; Data Definition
;; A DoB is (make-date Year Month Day)
;; where
;; Year is an Integer in [1900, 2100]
;; Month is an Integer in [1, 12]
;; Day is an Integer in [1, 31]


;; Template for date
#;
(define (template-for-date d)
  ...(date-year d)...
  ...(date-month d)...
  ...(date-day d)...)

(define-struct date (year month day))


;; Data Definition
;; An Alpaca is one of:
;; - (make-alpaca String Sex DoB Color Alpaca Alpaca)
;; - "unknown"
;; A Sex is one of:
;; - "female"
;; - "male"
;; Template for Alpaca
#;
(define (temp-ate-for-alpaca a)
  (cond
    [(equal? a "unknown") ...]
    [else
     ...(alpaca-name a)...
     ...(cond
          [(equal? (alpaca-sex a) "male") ...]
          [(equal? (alpaca-sex a) "female") ...])
     ...(template-for-date (alpaca-dob a))...
     ...(alpaca-color a)...
     ...(template-for-alpaca (alpaca-sire a))...
     ...(template-for-alpaca (alpaca-dam a))...]))

(define-struct alpaca (name sex dob color sire dam))


;; An examples, here’s the representation of the record for some Alpacas:
(define dana-andrews
  (make-alpaca "Dana Andrews"
               "female"
               (make-date 1996 8 14)
               "silver"
               "unknown"
               "unknown"))
(define jericho
  (make-alpaca "Jericho de Chuchata"
               "male"
               (make-date 1997 11 23)
               "black"
               "unknown"
               "unknown"))
(define robert
  (make-alpaca "Robert"
               "male"
               (make-date 1950 10 4)
               "green"
               "unknown"
               "unknown"))

(define samantha
  (make-alpaca "Samantha"
              "female"
              (make-date 1955 4 7)
              "black"
              "unknown"
              "unknown"))

(define sylvan 
  (make-alpaca "MA Sylvan"
               "male"
               (make-date 2001 5 16)
               "black"
               robert
               samantha))

(define mfa
  (make-alpaca "MFA Independence"
               "female"
               (make-date 2004 7 2)
               "black"
               jericho
               dana-andrews))
(define irene
  (make-alpaca "Irene of Acorn Alpacas"
               "female"
               (make-date 2007 5 21)
               "silver"
               sylvan
               mfa))

#|
First, add two more alpacas.
(Come back here and add more Alpacas that
you think would make good test cases as
you design the rest of the functions for
this homework assignment.)
|#

(define daniels
  (make-alpaca "Daniels Jack"
               "female"
               (make-date 2014 3 2)
               "green"
               "unknown"
               "unknown"))

(define sam
  (make-alpaca "Samuel Jackson"
               "male"
               (make-date 2011 5 5)
               "blue"
               daniels
               irene))


             

#|
Second, AOBA would like a program to make a rather simple
query: Given an alpaca, they would like to find out the
names of all the female-line ancestors of the given alpaca
in a list, youngest to oldest, and including the given
alpaca. So for example, given the structure for Irene above,
it should return the list
(list "Irene of Acorn Alpacas"
      "MFA Independence"
      "Dana Andrews")
which contains Irene's name, her mother's name, and her
grandmother's name, and then stops because her great
grandmother is unknown. Design the function female-line.
(You probably need a new data definition in order to write
the correct signature.)
|#

(define (find-female a)
  (cond
    [(equal? (alpaca-dam a) "unknown") (cons (alpaca-name a) '())]
    [else
     (cons (alpaca-name a) (find-female (alpaca-dam a)))]))

(check-expect (find-female sam) (list "Samuel Jackson"
                                      "Irene of Acorn Alpacas"
                                      "MFA Independence"
                                      "Dana Andrews"))

(check-expect (find-female irene) (list "Irene of Acorn Alpacas"
                                       "MFA Independence"
                                       "Dana Andrews"))

#|
Many breeders raise alpacas for their fleece, which comes in
a wide variety of colors and may be made into a wide variety
of textiles. Some breeders are interested in breeding
alpacas with new colors and patterns, and to do so, they
need to understand how fleece colors and patterns are
inherited.
You can help them by designing a function has-color? that
takes an alpaca pedigree and a color, and reports whether or
not that color is known to appear anywhere in the pedigree tree.
|#

(define (has-color? alpaca color)
  (cond
    [(equal? alpaca "unknown") #false]
    [(equal? (alpaca-color alpaca) color) #true]
    [else
     (cond
       [(or (equal? (alpaca-color (alpaca-sire alpaca)) color)
           (equal? (alpaca-color (alpaca-dam alpaca)) color)) #true]
       [else #false])]))

(check-expect (has-color? irene "silver") #true)
(check-expect (has-color? irene "blue") #false)
(check-expect (has-color? sylvan "black") #true)

#|
AOBA is worried about fraud in their registry. Eventually
they’ll send investigators into the field, but first they’d
like to run a simple sanity check on the database. Given the
pedigree record for an alpaca, there are two simple errors
that you can find:
Some alpaca in the tree has a birthday before one of his or
her parents.
Some alpaca in the tree has a male alpaca listed as dam or a
female alpaca listed as sire.
Design a function pedigree-error? that returns true if a
given Alpaca has one of those two obvious errors in his or
her pedigree, and false otherwise.
|#

;(check-expect (pedigree-error? sam) #true)
;(check-expect (pedigree-error? irene) #false)

#|
(define (pedigree-error? a)
  (or (pedigree-error1? a) (pedigree-error2? a)))

(check-expect (pedigree-error? sam) #true)
(check-expect (pedigree-error? mfa) #true)
(check-expect (pedigree-error1? sylvan) #false)
(check-expect (pedigree-error2? sylvan) #true)

(define (pedigree-error1? a)
  (or 
   (cond
     [(not (equal? (alpaca-sire a) "unknown"))
      (or (birth-compare a (alpaca-sire a)) (pedigree-error1? (alpaca-sire a)))]
     [else #false])
   (cond
     [(not (equal? (alpaca-dam a) "unknown"))
      (or (birth-compare a (alpaca-dam a)) (pedigree-error1? (alpaca-dam a)))]
     [else #false])))

(check-expect (pedigree-error1? sam) #true)
(check-expect (pedigree-error1? mfa) #false)
(check-expect (pedigree-error1? irene) #true)

(define (birth-compare child parent)
  (cond
    [(< (date-year (alpaca-dob child)) (date-year (alpaca-dob parent))) #true]
    [(> (date-year (alpaca-dob child)) (date-year (alpaca-dob parent))) #false]
    [else
     (cond
       [(< (date-month (alpaca-dob child)) (date-month (alpaca-dob parent))) #true]
       [(> (date-month (alpaca-dob child)) (date-month (alpaca-dob parent))) #false]
       [else
        (cond
          [(< (date-day (alpaca-dob child)) (date-day (alpaca-dob parent))) #true]
          [else #false])])]))

(check-expect (birth-compare sam daniels) #true)
(check-expect (birth-compare daniels irene) #false)
(check-expect (birth-compare irene sylvan) #false)


(define (pedigree-error2? a)
  (or 
   (cond
     [(not (equal? (alpaca-sire a) "unknown"))
      (or (sex-compare-sire a) (pedigree-error2? (alpaca-sire a)))]
     [else #false])
   (cond
     [(not (equal? (alpaca-dam a) "unknown"))
      (or (sex-compare-dam a) (pedigree-error2? (alpaca-dam a)))]
     [else #false])))  

(define (sex-compare-sire child)
  (cond
    [(equal? (alpaca-sex (alpaca-sire child)) "female") #true]
    [else #false]))

(define (sex-compare-dam child)
  (cond
    [(equal? (alpaca-sex (alpaca-dam child)) "male") #true]
    [else #false]))

(check-expect (pedigree-error2? sam) #true)
(check-expect (pedigree-error2? irene) #false)
|#       
       


#|
For all other problems in this assignment, you may assume
that all alpaca records are valid, in the sense that
pedigree-error? answers false for them. In the next problem,
for example, it will save you trouble if you don’t have to
consider the possibility that any alpaca’s date of birth
could precede its parents’.
Tracing back an alpaca’s ancestry as far as possible is a
point of pride in the alpaca-raising community. Design a
function oldest-ancestor that, given an alpaca’s pedigree
record, returns its oldest known ancestor's name and
returns #false if there is no known ancestor.
Hint: Use a data definition:
  An maybe-name is either:
     #false
     string
and write functions that operate on it, discovering which
ones you need as you work out oldest-ancestor.
|#

#;
(define (origin a)
  (cond
    [(and (equal? (alpaca-sire a) "unknown")
          (equal? (alpaca-dam a) "unknown")) a]
    [else
     (cond
       [(< (oldest (alpaca-sire a) 0) (oldest (alpaca-dam a) 0))
        (origin (alpaca-dam a))]
       [else
        (origin (alpaca-sire a))])]))

;(check-expect (origin sam) jericho)
#;
(define (oldest a depth)
  (cond
    [(equal? a "unknown") depth]
    [else
     (max (oldest (alpaca-sire a) (+ 1 depth)) (oldest (alpaca-dam a) (+ 1 depth)))]))
     
;(check-expect (oldest sam 0) 4)
;(check-expect (oldest irene 0) 3)
;(check-expect (oldest jericho 0) 1)

;==============================

(define (before-ancestor a)
  (cond
    [(and (equal? (alpaca-sire a) "unknown")
          (equal? (alpaca-dam a) "unknown")) #false]
    [else
     (alpaca-name (ancestor a))]))

(define (ancestor a)
  (cond
    [(and (not (equal? (alpaca-sire a) "unknown"))
          (not (equal? (alpaca-dam a) "unknown")))
     (compare-birthday (ancestor (alpaca-sire a)) (ancestor (alpaca-dam a)))]
    [(not (equal? (alpaca-sire a) "unknown"))
     (ancestor (alpaca-sire a))]
    [(not (equal? (alpaca-dam a) "unknown"))
     (ancestor (alpaca-dam a))]
    [else a]))
     
(check-expect (before-ancestor sam) "Robert")        
(check-expect (before-ancestor dana-andrews) #false)
(check-expect (before-ancestor jericho) #false)
(check-expect (before-ancestor irene) "Robert")
(check-expect (before-ancestor daniels) #false)
(check-expect (before-ancestor irene) "Robert")

(define (compare-birthday a b)
  (cond
    [(< (date-year (alpaca-dob a)) (date-year (alpaca-dob b))) a]
    [(> (date-year (alpaca-dob a)) (date-year (alpaca-dob b))) b]
    [else
     (cond
       [(< (date-month (alpaca-dob a)) (date-month (alpaca-dob b))) a]
       [(> (date-month (alpaca-dob a)) (date-month (alpaca-dob a))) b]
       [else
        (cond
          [(< (date-day (alpaca-dob a)) (date-day (alpaca-dob b))) a]
          [else b])])]))
  

#|
AOBA also wants a way to list all the known ancestors of a
given alpaca (including the given alpaca) in reverse birth
order. For example, for Irene, the result would be:
  (list irene
        mfa
        sylvan
        jericho
        dana-andrews)
Design a function all-ancestors/sorted to perform this task.
Hint: In order to do so, you will need a data definition for
a list of alpacas (the conventional one will do), and you
will likely need a helper function merge-alpacas that, given
two sorted lists of alpacas, merges them into a single
sorted list of alpacas. See HTDP/2e section 26.5 for how
to design a template for this:
  http://www.ccs.neu.edu/home/matthias/HtDP2e/part_four.html#%28part._sec~3atwo-inputs~3adesign%29
|#


(define (orders a)
  (get-sort (get-list a)))

(define (get-list a)
  (cond
    [(and (equal? (alpaca-sire a) "unknown")
          (equal? (alpaca-dam a) "unknown")) (cons a'())]
    [(and (not (equal? (alpaca-sire a) "unknown"))
          (equal? (alpaca-dam a) "unknown"))
     (cons a (get-list (alpaca-sire a)))]
    [(and (not (equal? (alpaca-dam a) "unknown"))
          (equal? (alpaca-sire a) "unknown"))
     (cons a (get-list (alpaca-dam a)))]
    [(and (not (equal? (alpaca-sire a) "unknown"))
          (not (equal? (alpaca-dam a) "unknown")))
     (append (cons a '()) (get-list (alpaca-sire a)) (get-list (alpaca-dam a)))]))


(define (get-sort a)
  (cond
    [(< (length a) 2) a]
    [(cons? a)
     (merge (first a) (rest a))]))


 (define (comp-birth a b)
  (cond
    [(< (date-year (alpaca-dob a)) (date-year (alpaca-dob b))) #true]
    [(> (date-year (alpaca-dob a)) (date-year (alpaca-dob b))) #false]
    [else
     (cond
       [(< (date-month (alpaca-dob a)) (date-month (alpaca-dob b))) #true]
       [(> (date-month (alpaca-dob a)) (date-month (alpaca-dob a))) #false]
       [else
        (cond
          [(< (date-day (alpaca-dob a)) (date-day (alpaca-dob b))) #true]
          [else #false])])]))


(define (merge a b)
  (cond
    [(empty? a)
     (cond
       [(empty? b) '()]
       [(= (length b) 1) (first b)])]
    [(empty? b) (first a)]
    [else
     (cond
       [(and (cons? a) (comp-birth (first a) (first b)))
        (cons (first a) (merge (rest a) b))]
       [(and (cons? a) (comp-birth (first b) (first a)))
        (cons (first b) (merge (rest b) a))]
       )]))


(define (sort1 alon) 
  (cond 
    [(empty? alon) empty] 
    [(cons? alon) (insert1 (first alon) 
                        (sort1 (rest alon)))]))

(define (insert1 n alon) 
  (cond 
    [(empty? alon) (cons n empty)] 
    [else (cond 
            [(comp-birth n (first alon)) (cons n alon)] 
            [else (cons (first alon) 
    (insert1 n (rest alon)))])])) 