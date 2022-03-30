(defmacro sigma (var beg end inc &body body) 
  `(loop for ,var from ,beg to ,end by ,inc
        sum ,@body))

(let ((d 0.11001001))
  (sigma i 0 7 1 
    (if (= (mod (truncate (* (abs d) (expt 10 (1+ i)))) 10) 1)
        (expt 2 (- 7 i))
        0)
))

(defun b-to-d (d)
  (sigma i 0 7 1 
    (if (= (mod (truncate (* (abs d) (expt 10 (1+ i)))) 10) 1)
        (expt 2 (- 7 i))
        0)
))

