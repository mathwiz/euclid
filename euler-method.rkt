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



;; Function Number Number Number Number Function -> Number
;; Produce an approximate value of a funtion given
;; x y end-x deriv h
(define (euler x y iter h deriv)
  (cond ((= iter 0) y)
        (else (euler (+ x h)
                     (+ y (* h (deriv x y)))
                     (sub1 iter)
                     h
                     deriv))))
;; Helper
(define (close? x n) (< (abs (- x n)) .001))
;; Tests
(define d1 (lambda (x y) (cond ((close? x 8.0) -4.0) ((close? x 8.3) -4.3) ((close? x 8.6) -4.2) ((close? x 8.9) -4.8))))
(test-= "euler #1" (euler 8.0 17 4 .3 d1) 11.81 .001)
(define d2 (lambda (x y) (cond ((close? x 9.0) 1.0) ((close? x 9.3) .1) ((close? x 9.6) .1) ((close? x 9.9) -.7))))
(test-= "euler #2" (euler 9.0 11 4 .3 d2) 11.15 .001)
(define d4 (lambda (x y) (- (* -.5 (* x x)) (* .5 y))))
(test-= "euler #4" (euler -3 0 4 .5 d4) -3.140625 .000001)
(define d6 (lambda (x y) (cond ((close? x 10.0) -5) ((close? x 10.3) -4.9) ((close? x 10.6) -4) ((close? x 10.9) -4.7))))
(test-= "euler #6" (euler 10.0 4 4 .3 d6) -1.58 .001)
(test-= "euler #5" (euler 1 -3 4 .5 (lambda (x y) (* .5 (* x x)))) .375 .001)
