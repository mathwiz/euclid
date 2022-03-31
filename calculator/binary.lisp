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

(defparameter curr (make-hash-table))

(defun g () (gethash 'n curr))

(defun l (v) (setf (gethash 'n curr) v) v)

(defun d-to-b (d)
(l d)
(*
 (expt 10 8)
 (sigma i 0 7 1
   (let ((currnum (g)) 
         (currfactor (expt 2.0 (- 7 i)))) 
     (if (= (truncate (/ (abs (+ currnum)) currfactor)) 1) 
         (+ (* 0 (l (- currnum currfactor))) 
            (expt 10.0 (- (1+ i)))) 0)))))
