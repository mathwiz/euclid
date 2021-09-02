#lang racket

(define (tangent-at f x [h .0001])
  ((derivative f h) x))

(define (derivative f [h .0001])
  (lambda (x)
    (/ (- (f (+ x h)) (f x)) h)))

(define (newton-next f x)
  (- x (/ (f x) (tangent-at f x))))

(define (newton-approx f x [iter 5])
  (letrec ((recur (lambda (xn i)
                    (cond ((= i 0) xn)
                          (else (recur (newton-next f xn) (sub1 i)))))))
    (recur x iter)))


(define f1 (lambda (x) (* x x x)))
(define f2 (lambda (x) (- (sin (* x x)) (* x x x) 1)))

(sin .5)
(cos .5)
(tangent-at sin .5 .001)
(tangent-at sin .5 .0001)
(tangent-at sin .5 .00001)

(newton-approx cos .5)
(newton-approx sin .5)
(newton-approx f2 -1.5)
(newton-approx f2 -1.5 10)

(cos (/ pi 2))
(/ pi 2)

;(require plot)
;(plot-new-window? #t)
;(plot (function f2 (- pi) pi))