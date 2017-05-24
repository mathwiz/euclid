#lang racket
(require rackunit)

;; Function Number Number -> Number
;; Produce a difference given function f, a value to evaluate f, and a step
(define (differential f x h)
  (- (f (+ x h)) (f x)))
;; Tests
(test-= "differential" (differential sin .5 .1) (- (sin (+ .5 .1)) (sin .5)) 0.001)


;; Function Number Number -> Number
;; Produce a derivative value approximation
;; given function f, a value to evaluate f, and a step
(define (deriv-approx f x h)
  (/ (differential f x h) h))
;; Tests
(test-= "deriv-approx" (deriv-approx sin .5 .1) (/ (- (sin (+ .5 .1)) (sin .5)) .1) 0.001)


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
               (- guess (/ (fn guess) (deriv-approx fn guess h)))
               h
               (sub1 iter)))))
;; Tests
(test-= "newton" (newton (lambda (x) (+ (expt x 3) (* -1 (* x x)) 3)) -1 .01 4) -1.1746 0.1)
(test-= "newton" (newton (lambda (x) (+ (expt x 3) (* -3 (* x x)) 3)) -1 .01 4) -0.87939 0.1)
