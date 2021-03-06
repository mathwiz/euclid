#lang racket

(require plot)
;(plot-new-window? #t)

(define (seq-fn n fn) (rest (build-list (add1 n) fn)))
(define (seq n) (seq-fn n values))

(define (cartesian n fn)
  (parameterize ([plot-width    150]
                 [plot-height   150]
                 [plot-x-label  #f]
                 [plot-y-label  #f])
    (define xs (seq n))
    (define ys (seq-fn n fn))
    (plot (points (map vector xs ys) #:size 3))))

;; Group I
(list
 (cartesian 16 (lambda (n) (if (= n 0) 0 (* (expt (- 1) n) (/ 1 n)))))
 (cartesian 16 (lambda (n) (if (= n 0) 0 (/ (- n 1) n))))
 (cartesian 16 (lambda (n) (if (= n 0) 0 (expt (- (/ 1 2)) n))))
 (cartesian 16 (lambda (n) (if (= n 0) 0 (+ 1 (/ 1 n)))))
 (cartesian 64 (lambda (n) (if (= n 0) 0 (/ 1 n))))
 )

;; Group II
(list
 (cartesian 16 (lambda (n) n))
 (cartesian 16 (lambda (n) (- n)))
 (cartesian 16 (lambda (n) (* n n)))
 (cartesian 16 (lambda (n) (- n 10)))
 )

;; Group III
(list
 (cartesian 16 (lambda (n) (expt (- 1) n)))
 (cartesian 16 (lambda (n) (if (= n 0) 0 (* (expt (- 1) n) (/ (- n 1) n)))))
 (cartesian 16 (lambda (n) (* (expt (- 1) n) n)))
 (cartesian 16 (lambda (n) (expt (- 2) n)))
 )