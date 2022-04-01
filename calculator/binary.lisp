;; Solver simulation
(defparameter dict (make-hash-table))

(defun g (k) (gethash k dict))

(defun l (k v) (setf (gethash k dict) v) v)

(defmacro sigma (var beg end inc &body body)
  `(loop for ,var from ,beg to ,end by ,inc sum ,@body))


;; Binary

(let ((d 0.11001001))
  (sigma i 0 7 1 (if (= (mod (truncate (* (abs d)
                                          (expt 10 (1+ i)))) 10) 1)
                     (expt 2 (- 7 i)) 0)))

(defun blist-to-d (digits)
  (labels ((recur (l i acc)
      (cond ((null l) acc) 
            ((= 0 (car l)) (recur (cdr l) (1+ i) acc))
            ('t (recur (cdr l) (1+ i) (+ (expt 2 i) acc))))))
    (recur (reverse digits) 0 0)))

(defun b-to-d (b)
  (sigma i 0 7 1 (if (= (mod (truncate (* (abs b)
                                          (expt 10 (1+ i)))) 10) 1)
                     (expt 2 (+ (* 8 (truncate b)) (- 7 i))) 
                     0)))

(defun d-to-b (d)
(l 'd d)
(*
 (expt 10 0)
 (sigma i 0 7 1
   (let ((foo (expt 2.0 (- 7 i)))) 
     (if (= (truncate (/ (abs (g 'd)) 
                         (l 'f (expt 2.0 (- 7 i)) ))) 
            1) 
         (+ (* 0 (l 'd (- (g 'd) (g 'f)))) 
            (expt 10.0 (- (1+ i))))
         0)))))

(defun byte-height (d)
  (+
   (* 0 (l 'd (truncate (abs d))))
   (if (> (g 'd) (expt 2 32))
       -1
       (if 0
           1
           2))))
