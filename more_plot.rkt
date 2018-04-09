#lang racket

(require plot)
(require (only-in plot/utils 3d-polar->3d-cartesian))
;(plot-new-window? #t)

(plot3d (parametric3d (λ (t) (3d-polar->3d-cartesian (* t 80) t 1))
                        (- pi) pi #:samples 3000 #:alpha 0.5)
          #:altitude 25)

;(plot3d (list (surface3d (λ (x y) (+ (sqr x) (sqr y))) -1 1 -1 1
;                           #:label "z = x^2 + y^2")
;                (surface3d (λ (x y) (- (+ (sqr x) (sqr y)))) -1 1 -1 1
;                           #:color 4 #:line-color 4
;                           #:label "z = -x^2 - y^2")))