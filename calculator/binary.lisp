(defmacro sigma (var beg end inc &body body) 
  `(loop for ,var from ,beg to ,end by ,inc
        sum ,@body))

(let ((d 0.11001001))
  (sigma i 0 7 1 
    (if (= (truncate (* (abs d) 10)) 1)
        1
        0)
))

