#lang racket

(define (geom a r n)
  (define (recur i acc)
    (if (> i n)
        acc
        (recur (add1 i) (+ (* a (expt r i)) acc))))
  (recur 0 0))

(define (geom-visual a r n)
  (define (recur i acc)
    (println acc)
    (if (> i n)
        acc
        (recur (add1 i) (+ (* a (expt r i)) acc))))
  (recur 0 0))

(geom 3 .5 10)
(geom 3 .5 30)

(geom-visual 3 .5 30)
