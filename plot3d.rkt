#lang racket

(require plot)
(plot-new-window? #t)

(plot3d (surface3d
         (lambda (x y) (* (cos x) (sin y)))
         (- pi) pi (- pi) pi)
        #:title "An R × R → R function"
        #:x-label "x" #:y-label "y" #:z-label "cos(x) sin(y)")