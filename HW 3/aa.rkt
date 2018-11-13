;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname aa) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; An [AA-tree X] is:
;; (make-tree [AA-node X] Natural [X X -> Boolean])
(define-struct tree (root size less-than))

;; An [AA-node X] is one of:
;; - "leaf"
;; - (make-node X Natural [AA-node X] [AA-node X])
(define-struct node (value level left right))

(define zero
  (make-tree (make-node 0 0 '() '())
             1 <=))

(define one-two-three
  (make-tree (make-node 2 1
                        (make-node 1 0 '() '())
                        (make-node 2 0 '() '()))
             3 <=))

(define one-two-three-four-string
  (make-tree (make-node "three" 1
                        (make-node "one" 0 '() '())
                        (make-node "two" 0 '() '()))
             3 string<?))

(define one-two-three-four-a
  (make-tree (make-node 2 1
                        (make-node 1 0 '() '())
                        (make-node 3 0 '()
                                   (make-node 4 0 '() '())))
             4 <=))

(define one-two-three-four-b
  (make-tree (make-node 3 1
                        (make-node 1 0 '()
                                   (make-node 2 0 '() '()))
                        (make-node 4 0 '() '()))
             4 <=))

(define six-nodes
  (make-tree (make-node 3 1
                        (make-node 1 0 '()
                                   (make-node 2 0 '() '()))
                        (make-node 5 1
                                   (make-node 4 0 '() '())
                                   (make-node 6 0 '() '())))
             6 <=))
                                  
;; lookup : [AA-tree X] X -> Boolean
;; to determine if 'x' occurs in 'tree'
(define (lookup tree x)
  (cond
    [(empty? (tree-root tree)) #false]
    [else
     (node-lookup (tree-root tree) x (tree-less-than tree))]))
(check-expect (lookup zero 4) #false)
(check-expect (lookup one-two-three-four-string "two") #true)
(check-expect (lookup one-two-three-four-a 5) #false)
(check-expect (lookup six-nodes 3) #true)

;; node-lookup : [AA-node X] x [X X -> Boolean] -> Boolean
;; to determine if 'x' occurs in 'node'
(define (node-lookup node x less-than)
  (cond
    [(empty? node) #false]
    [else
     (cond
       [(equal? x (node-value node)) #true]
       [(less-than x (node-value node)) (node-lookup (node-left node) x less-than)]
       [(less-than (node-value node) x) (node-lookup (node-right node) x less-than)])]))

;; insert-wrong : [AA-node X] X [X X -> Boolean] -> [AA-node X]
;; inserts 'value' into 'tree' using 'less-than' without
;; regard to the AA invariant.
(define (insert-wrong node value less-than)
  (cond
    [(empty? node) (make-node value 0 '() '())]
    [else
     (cond
       [(less-than value (node-value node))
        (make-node (node-value node) (node-level node) (split (skew (insert-wrong (node-left node) value less-than))) (node-right node))]
       [(less-than (node-value node) value)
        (make-node (node-value node) (node-level node) (node-left node) (split (skew (insert-wrong (node-right node) value less-than))))])]))



(define insert-wrong-example
  (make-node 6 1
             (make-node 2 0 '()
                        (make-node 4 0 '() '()))
             (make-node 8 0 '() '())))
#;
(check-expect (insert-wrong insert-wrong-example 3 <=)
  (make-node 6 1
             (make-node 2 0 '()
                        (make-node 4 0
                                   (make-node 3 0 '() '())
                                   '()))
             (make-node 8 0 '() '())))
#;
(check-expect (insert-wrong insert-wrong-example 9 <=)
  (make-node 6 1
             (make-node 2 0 '()
                        (make-node 4 0 '() '()))
             (make-node 8 0 '()
                        (make-node 9 0 '() '()))))


(define ex1
  (make-node 4 1
             (make-node 2 0 '() '())
             (make-node 6 0 '() '())))

(define ex2
  (make-node 6 1
             (make-node 2 0
                        '()
                        (make-node 4 0 '() '()))
             (make-node 8 0
                        '()
                        (make-node 10 0 '() '()))))

;; rotate-right : [AA-node X] -> [AA-node X]
;; ASSUMPTION: 'node' is not "leaf", and '(node-left node)' is not "leaf"
(define (rotate-right node)
  (make-node (node-value (node-left node))
             (node-level (node-left node))
             (node-left (node-left node))
             (make-node (node-value node)
                        (node-level node)
                        (node-right (node-left node))
                        (node-right node))))

(check-expect (rotate-right insert-wrong-example)
              (make-node 2 0
                         '()
                         (make-node 6 1
                                    (make-node 4 0 '() '())
                                    (make-node 8 0 '() '()))))



;; rotate-left : [AA-node X] -> [AA-node X]
;; ASSUMPTION: 'node' is not "leaf", and '(node-right node)' is not "leaf"
(define (rotate-left node)
  (make-node (node-value (node-right node))
             (+ 1 (node-level (node-right node)))
             (make-node (node-value node)
                        (node-level node)
                        (node-left node)
                        (node-left (node-right node)))
             (node-right (node-right node))))

(check-expect (rotate-left insert-wrong-example)
              (make-node 8 1
                         (make-node 6 1
                                    (make-node 2 0
                                               '()
                                               (make-node 4 0 '() '()))
                                    '())
                         '()))

;; split : [AA-node X] -> [AA-node X]
;; it accepts a tree and, if the tree is a node and if the left subtree has the same
;; level as the original tree, then it performs a rotate right.
(define (skew node)
)
    
;; skew : [AA-node X] -> [AA-node X]
;; it accepts a tree and, if the tree is a node and if the right
;; subtree is also a node, and the right subtree of the right subtree has
;; the same level as the tree, then it performs a rotate-left
;; and it increments the level of the result of the rotation.

(define (split node)
)



;; insert : [AA-tree X] x -> [AA-tree X]
(define (insert tree x)

  )

