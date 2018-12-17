(defpackage :bin.w1n.train
  (:use :common-lisp :hunchentoot :cl-who)
  (:import-from :alexandria :clamp))
(in-package :bin.w1n.train)


;;; Defun functions for use in hunchentoot
(defun train-pass (a-speed b-speed distance)
  "Calculate when the train's will pass eachother"
  (/ distance
     (+ a-speed b-speed)))

(defun lower-clamp (number min)
  "If number is less than min, reutrn min otherwise return number"
  (if (and number (> number min))
      number
      min))

(defun parse-input (input)
  "wrapper around parse-integer with junk-allowed set to t"
  (if input
      (lower-clamp (parse-integer input :junk-allowed t) 1)
      nil))

(defun round-if-rational (number)
  "Round number if it is rational"
  (if (rationalp number)
      (round number)
      number))

(defun rational-to-mixed (number)
  "If number is rational, convert it to a mixed numeral (fraction/number)
   as a string"
  (multiple-value-bind (whole proper) (floor number)
    (if (> proper 0)
        (format nil "~a and ~a" whole proper)
        whole)))


;;; Hunchentoot setup
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))

(hunchentoot:define-easy-handler (trains :uri "/") (a b c)
  (let ((ta (or (parse-input a)
                25))
        (tb (or (parse-input b)
                25))
        (tc (or (parse-input c)
                100)))
    (setf (hunchentoot:content-type*) "text/plain")
    (format nil
            "Two trains are racing towards each other.  Train a is going~%~
            ~a kph.  Train b is going ~a kph.  When each train reached~%~
            those velocities they were ~a kilometers apart.  They will~%~
            crash into each other after ~a hours."
            ta
            tb
            tc
            (rational-to-mixed
             (train-pass ta tb tc)))))
