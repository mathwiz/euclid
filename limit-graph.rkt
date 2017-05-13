#lang racket

(require plot)
;(plot-new-window? #t)

(define (cartesian fn)
  (parameterize ([plot-width    150]
                 [plot-height   150]
                 [plot-x-label  #f]
                 [plot-y-label  #f])
    (define xs (rest (build-list 17 values)))
    (define ys (rest (build-list 17 fn)))
    (plot (points (map vector xs ys)))))

;; Group I
(list
 (cartesian (lambda (n) (if (= n 0) 0 (* (expt (- 1) n) (/ 1 n)))))
 (cartesian (lambda (n) (if (= n 0) 0 (/ (- n 1) n))))
 (cartesian (lambda (n) (if (= n 0) 0 (expt (- (/ 1 2)) n))))
 (cartesian (lambda (n) (if (= n 0) 0 (+ 1 (/ 1 n)))))
 )

;; Group II
(list
 (cartesian (lambda (n) n))
 (cartesian (lambda (n) (- n)))
 (cartesian (lambda (n) (* n n)))
 (cartesian (lambda (n) (- n 10)))
 )

;; Group III
(list
 (cartesian (lambda (n) (expt (- 1) n)))
 (cartesian (lambda (n) (if (= n 0) 0 (* (expt (- 1) n) (/ (- n 1) n)))))
 (cartesian (lambda (n) (* (expt (- 1) n) n)))
 (cartesian (lambda (n) (expt (- 2) n)))
 )