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
 (cartesian (* 2 pi) (lambda (n) (if (= n 0) 0 (/ 1 n))))
 (cartesian (* 2 pi) (lambda (n) (if (= n 0) 0 (/ (- n 1) n))))
 (cartesian (* 2 pi) (lambda (n) (if (= n 0) 0 (/ (sin n) n))))
 (cartesian (* 2 pi) (lambda (n) (if (= n 0) 0 (/ (abs n) n))))
 )

;; Group II
(list
 (cartesian (* 2 pi) (lambda (n) (if (= n 0) 0 (/ (- 1 (* n n)) n))))
 (cartesian (* 2 pi) (lambda (n) (if (= n 0) 0 (/ (- (* n n) 1) n))))
 (cartesian (* 2 pi) (lambda (n) n))
 (cartesian (* 2 pi) (lambda (n) (expt 2 n)))
 )

;; Group III
(list
 (cartesian (* 2 pi) sin)
 (cartesian (* 2 pi) (lambda (n) (+ 1 (sin n))))
 (cartesian (* 2 pi) cos)
 (cartesian (* 2 pi) (lambda (n) (abs (sin n))))
 )