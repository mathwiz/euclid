#lang racket

(define (compute-pi terms)
  (letrec ([op (lambda (n)
                 (cond [(even? n) +]
                       [else -]))]
           [term (lambda (n)
                     (let ([d (* 2 n)]) (/ 4.0 (* (- d 2) (- d 1) d))))]
           [iter (lambda (n acc)
                   (cond [(= n 1) (+ acc 3.0)]
                         [else (iter (sub1 n) ((op n) acc (term n)))]))])
    (cond [(< terms 1) 0.0]
          [else (iter terms 0.0)])))


(define (pi-error terms)
  (- pi (compute-pi terms)))
