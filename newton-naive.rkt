#lang racket

(define (tangent-at f x)
  ((derivative f) x))

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
(tangent-at f2 2)
(tangent-at f2 3)
(tangent-at sin .5)

(sin .5)
(newton-approx sin .5)
(newton-approx f1 2)
(newton-approx f1 2 10)

(require plot)
(plot-new-window? #t)
(plot (function f2 (- pi) pi))