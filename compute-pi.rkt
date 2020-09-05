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


(define (string->number/binary x)
  (string->number x 2))


(define (number->string/binary x)
  (define decimals-places 10)
  (define digits-all (~r (inexact->exact (round (* x (expt 2 decimals-places))))
                         #:base 2
                         #:pad-string "0"
                         #:min-width (add1 decimals-places)))
  (define digits-length (string-length digits-all))
  (define integer-part (substring digits-all 0 (- digits-length decimals-places)))
  (define decimal-part* (string-trim (substring digits-all (- digits-length decimals-places))
                                    "0" 
                                    #:left? #f
                                    #:repeat? #t))
  (define decimal-part (if (string=? decimal-part* "") "0"  decimal-part*))
  (string-append integer-part "." decimal-part))


(define (pi-binary terms)
  (string->number (number->string/binary (compute-pi terms))))
