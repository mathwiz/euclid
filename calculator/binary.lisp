(defmacro sigma (var beg end inc &body body)
  `(loop for ,var from ,beg to ,end by ,inc sum ,@body))

(let ((d 0.11001001))
  (sigma i 0 7 1 (if (= (mod (truncate (* (abs d)
                                          (expt 10 (1+ i)))) 10) 1)
                     (expt 2 (- 7 i)) 0)))

(defun b-to-d (b)
  (sigma i 0 7 1 (if (= (mod (truncate (* (abs b)
                                          (expt 10 (1+ i)))) 10) 1)
                     (expt 2 (- 7 i)) 0)))

;; Solver simulation
(defparameter dict (make-hash-table))

(defun g (k) (gethash k dict))

(defun l (k v) (setf (gethash k dict) v) v)

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
