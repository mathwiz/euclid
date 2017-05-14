#lang racket

(require plot)
;(plot-new-window? #t)

(define (cartesian n fn)
  (parameterize ([plot-width    150]
                 [plot-height   150]
                 [plot-x-label  #f]
                 [plot-y-label  #f])
    (plot (function fn (- n) n))))

;; Group I
(list
 (cartesian 16 (lambda (n) (if (= n 0) 0 (/ 1 n))))
 (cartesian 16 (lambda (n) (if (= n 0) 0 (/ (- 1 n) n))))
 (cartesian 16 (lambda (n) (if (= n 0) 0 (/ (sin n) n))))
 (cartesian 16 (lambda (n) (if (= n 0) 0 (/ (abs n) n))))
 )

;; Group II
(list
 (cartesian 16 (lambda (n) (if (= n 0) 0 (/ (- 1 (* n n)) n))))
 (cartesian 16 (lambda (n) (if (= n 0) 0 (/ (- (* n n) 1) n))))
 (cartesian 16 (lambda (n) n))
 (cartesian 16 (lambda (n) (expt 2 n)))
 )

;; Group III
(list
 (cartesian 16 sin)
 (cartesian 16 (lambda (n) (+ 1 (sin n))))
 (cartesian 16 cos)
 (cartesian 16 (lambda (n) (abs (sin n))))
 )