(defparameter *LIVE* #\*)
(defparameter *DEAD* #\.)
(defparameter *NEIGHBORS* (make-hash-table))

(defun life ()
  (let ((_SIZE nil)
        (_GEN1 nil)
        (_GEN2 nil))
    (progn
      (init)
      (main-loop))))


(defun init ()
  (format t "Size of Life: ")
  (progn
    (setf _SIZE (read))
    (setf _GEN1 (make-array (* _SIZE _SIZE) :initial-element (dead-value)))
    (setf _GEN2 (make-array (* _SIZE _SIZE)))
    (build-neighbors _GEN1)))


(defun store-next-gen () 
  (let ((n (* _SIZE _SIZE))) 
    (setf _GEN1 _GEN2) 
    (setf _GEN2 (make-array n))))


(defun randomly-populate (grid)
  (let ((length (length grid)))
    (dotimes (i length)
      (set-cell i grid (random 2)))))


(defun build-neighbors (grid)
  (let* ((n (length grid))
         (size (sqrt n)))
    (dotimes (i n)
      (setf (gethash i *NEIGHBORS*) (get-neighbors i size)))))


(defun lookup-neighbors (cell)
  (gethash cell *NEIGHBORS*))


(defun main-loop ()
  (progn (format t "~%Steps to advance (<Ret> = 1, Q to quit, R randomly populate, G add glider) > ")
         (let ((cmd (read-line)))
           (cond ((equal cmd "t1")
                  (progn (show _GEN1)
                         (format t "get neighbors of cell> ")
                         (let ((cell (read)))
                           (princ (map 'vector #'1+ (lookup-neighbors (1- cell)))))
                         (main-loop)))
                 ((equal cmd "t")
                  (progn (show _GEN1)
                         (format t "calculate living neighbors of cell> ")
                         (let ((cell (read)))
                           (princ (live-neighbors (1- cell) _GEN1)))
                         (main-loop)))
                 ((equal cmd "s")
                  (progn (show _GEN1)
                         (main-loop)))
                 ((equal cmd "r")
                  (progn (randomly-populate _GEN1)
                         (show _GEN1)
                         (main-loop)))
                 ((equal cmd "g")
                  (progn (add-glider _GEN1)
                         (show _GEN1)
                         (main-loop)))
                 ((equal cmd "q")
                  (progn (format t "Bye.") nil))
                 ((equal cmd "")
                  (progn (compute-multiple 1 _GEN1 _GEN2)
                         (show _GEN1)
                         (main-loop)))
                 (t (progn (dotimes (i (parse-integer cmd))
                             (compute-multiple 1 _GEN1 _GEN2)
                             (show _GEN1))
                           (main-loop)))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun add-glider (grid)
  (format t "add glider at cell> ")
  (let ((size (sqrt (length grid)))
        (cell (read)))
    (progn
      (set-cell cell grid (alive-value))
      (set-cell (select-right (select-down cell size) size) grid (alive-value))
      (set-cell (select-right (select-right (select-down cell size) size) size) grid (alive-value))
      (set-cell (select-down (select-down cell size) size) grid (alive-value))
      (set-cell (select-right (select-down (select-down cell size) size) size) grid (alive-value)))))


(defun live-neighbors (cell grid)
  (let ((size (sqrt (length grid)))
        (neighbors (lookup-neighbors cell))
        (func (lambda (acc x)
                (+ (get-cell x grid) acc))))
    (reduce func neighbors
            :initial-value 0)))


(defun to-live (cell grid)
  (let ((neighbors-alive (live-neighbors cell grid)))
    (or (= neighbors-alive 3)
        (and (= neighbors-alive 2)
             (is-alive cell grid)))))


(defun is-alive (cell grid)
  (= (get-cell cell grid) (alive-value)))


(defun alive-value ()
  1)


(defun dead-value ()
  0)


(defun get-cell (cell grid)
  (aref grid cell))


(defun set-cell (cell grid val)
  (setf (aref grid cell) val))


(defun get-neighbors (cell size)
  (let ((neighbors (make-array 8)))
    (progn
      (dotimes (i 8)
        (setf (aref neighbors i) (neighbor cell i size))))
    neighbors))


;; Neighbors
;; NW  N  NE  |   0   1   2
;;  W  C  E   |   3   C   4
;; SW  S  SE  |   5   6   7
(defun neighbor (cell dir size)
  (cond ((= dir  0)
         (select-up (select-left cell size) size))
        ((= dir  1)
         (select-up cell size))
        ((= dir  2)
         (select-up (select-right cell size) size))
        ((= dir  3)
         (select-left cell size))
        ((= dir  4)
         (select-right cell size))
        ((= dir  5)
         (select-down (select-left cell size) size))
        ((= dir  6)
         (select-down cell size))
        ((= dir  7)
         (select-down (select-right cell size) size))
        (t nil)))


(defun select-up (cell size)
  (if (first-row cell size)
      (+ (* size (1- size))
         (mod cell size))
      (- cell size)))


(defun select-down (cell size)
  (if (last-row cell size)
      (mod cell size)
      (+ cell size)))


(defun select-left (cell size)
  (if (left-end cell size)
               (+ cell (1- size))
               (1- cell)))


(defun select-right (cell size)
  (if (right-end cell size)
               (- cell (1- size))
               (1+ cell)))


(defun left-end (cell size)
  (= (mod cell size) 0))


(defun right-end (cell size)
  (= (mod cell size) (1- size)))


(defun first-row (cell size)
  (< cell size))


(defun last-row (cell size)
  (>= cell (* size (1- size))))


(defun compute (grid dest-grid)
  (let ((n (length grid)))
    (dotimes (i n)
      (set-cell i dest-grid (compute-cell i grid)))))


(defun compute-cell (cell grid)
  (if (to-live cell grid)
      (alive-value)
      (dead-value)))


(defun compute-multiple (iterations grid dest-grid)
  (progn
    (dotimes (i iterations)
      (compute grid dest-grid)
      (store-next-gen))))


(defun show (grid)
  (progn
    (let ((length (length grid))
          (linesize (sqrt (length grid))))
      (format t "~%   ")
      (dotimes (i linesize)
        (format t "~3d" (1+ i)))
      (dotimes (i length)
        (progn
          (if (= (mod i linesize) 0)
              (format t "~%~3d " (1+ (/ i linesize))))
          (show-cell (get-cell i grid)))))
    (format t "~%")))


(defun show-cell (state)
  (format t " ~C " (get-symbol state)))


(defun get-symbol (state)
  (if (= state (alive-value))
      *LIVE*
      *DEAD*))


;;Run it

(life)


;; Test it

;; (print nil)
;; (princ (get-neighbors 7 7))
;; (princ (get-neighbors 10 7))
;; (princ (get-neighbors 13 7))
;; (print nil)
;; (princ (get-neighbors 0 7))
;; (princ (get-neighbors 3 7))
;; (princ (get-neighbors 6 7))
;; (print nil)
;; (princ (get-neighbors 42 7))
;; (princ (get-neighbors 45 7))
;; (princ (get-neighbors 48 7))
