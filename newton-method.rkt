#lang racket
(require rackunit)

;; (Number -> Number) Number Number -> Number
;; Produce a difference given function f, a value to evaluate f, and a step
(define (differential f x h)
  (- (f (+ x h)) (f x)))
;; Tests
(test-= "differential" (differential sin .5 .1) (- (sin (+ .5 .1)) (sin .5)) 0.001)


;; (Number -> Number) Number Number -> Number
;; Produce a derivative value approximation
;; given function f, a value to evaluate f, and a step
(define (deriv-approx f x h)
  (/ (differential f x h) h))
;; Tests
(test-= "deriv-approx" (deriv-approx sin .5 .1) (/ (- (sin (+ .5 .1)) (sin .5)) .1) 0.001)


;; (Number -> Number) Number -> (Number -> Number) 
;; Produce a function that is an approximate derivative given a step size
;(define (derivative fn h) (lambda (x) 0)) ; stub
(define (derivative fn h)
  (lambda (x) (deriv-approx fn x h)))
;; Tests
(test-= "derivative" ((derivative sin .01) .5) (cos .5) 0.01)


;; Helper
(define (close? x n) (< (abs (- x n)) .001))


;; Number Integer Natural -> Number
;; Produce an approximate value for the reciprocal of b given
;; b guess number-of-iterations
(define (newton-raphson b guess iter)
  (cond ((= iter 0) (if (< b 0) (* -1 guess) guess))
        (else (newton-raphson
               b
               (* guess (- 2 (* (abs b) guess)))
               (sub1 iter)))))
;; Tests
(test-= "newton-raphson" (newton-raphson 7 .1 4) (/ 1 7) 0.001)
(test-= "newton-raphson" (newton-raphson -7 .1 4) (/ 1 -7) 0.001)


;; (Number -> Number) Number Number Natural -> Number
;; General Newton's method
;; Produce an approximation of the root of a given function when given
;; a starting guess, the step value to approximate a derivative, and the number of iterations.
;; Each iteration calculates the ratio of the value of the function at the guess with
;; the value of the derivative at the guess.
(define (newton fn guess h iter)
  (cond ((= iter 0) guess)
        (else (newton
               fn
               (- guess (/ (fn guess) ((derivative fn h) guess)))
               h
               (sub1 iter)))))
;; Tests
(test-= "newton" (newton (lambda (x) (+ (expt x 3) (* -1 (* x x)) 3)) -1 .01 4) -1.1746 0.1)
(test-= "newton" (newton (lambda (x) (+ (expt x 3) (* -3 (* x x)) 3)) -1 .01 4) -0.87939 0.1)


;; Produce a polynomial function in one variable with the coeffiecients
;; given as a list of their values
(define (term coefficient degree) (lambda (x) (* coefficient (expt x degree))))
(define (poly-terms coefficients acc)
  (cond ((empty? coefficients) acc)
        (else (poly-terms
               (rest coefficients)
               (cons (term (first coefficients) (sub1 (length coefficients))) acc)))))
(define (poly-apply x terms acc)
  (cond ((empty? terms) acc)
        (else (poly-apply
               x
               (rest terms)
               (+ ((first terms) x) acc)))))
(define (polynomial coefficients)
  (lambda (x) (poly-apply x (poly-terms coefficients empty) 0)))
(define p1 (polynomial (list -4 -2 -2 -3)))
(define p2 (polynomial (list 3 -6 4 -4 -3 -3)))
(define p3 (polynomial (list 5 0 -5 7)))
(define p4 (polynomial (list -6 -5 7 1 -2 -2)))
(define p5 (polynomial (list -1 5 -4 6 -2 3)))
(test-= "polynomial" (newton p1 -2 .0001 2) -1.058263 0.0001)
(test-= "polynomial" (newton p2 0 .00001 2) (/ -39 56) 0.0001) ; note this needs a smaller step for same level of error
(test-= "polynomial" (newton p3 -2 .0001 2) -1.431794 0.0001)
(test-= "polynomial" (newton p4 -2 .0001 2) -1.585160 0.0001)
(test-= "polynomial" (newton p5 4 .0001 2) 4.425295 0.0001)

(define (poly coefficients)
  (local (;; produce the expression of the poly
          (define (poly-apply x terms acc)
            (cond ((empty? terms) acc)
                  (else (poly-apply
                         x
                         (rest terms)
                         (+ ((first terms) x) acc)))))
          ;; produce a list of terms
          (define (poly-terms cs acc)
            (cond ((empty? cs) acc)
                  (else (poly-terms
                         (rest cs)
                         (cons (term (first cs) (sub1 (length cs))) acc)))))
          ;; produce a term
          (define (term coefficient degree)
            (lambda (x) (* coefficient (expt x degree))))
          )
    (lambda (x) (poly-apply x (poly-terms coefficients empty) 0))))
(define poly1 (poly (list -4 -2 -2 -3)))
(define poly2 (poly (list 3 -6 4 -4 -3 -3)))
(define poly3 (poly (list 5 0 -5 7)))
(define poly4 (poly (list -6 -5 7 1 -2 -2)))
(define poly5 (poly (list -1 5 -4 6 -2 3)))
(test-= "poly" (newton poly1 -2 .0001 2) -1.058263 0.0001)
(test-= "poly" (newton poly2 0 .00001 2) (/ -39 56) 0.0001) ; note this needs a smaller step for same level of error
(test-= "poly" (newton poly3 -2 .0001 2) -1.431794 0.0001)
(test-= "poly" (newton poly4 -2 .0001 2) -1.585160 0.0001)
(test-= "poly" (newton poly5 4 .0001 2) 4.425295 0.0001)
