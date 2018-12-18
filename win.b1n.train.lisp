;;;; win.b1n.train.lisp

(in-package :win.b1n.train)


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

(defun rational-to-mixed (number)
  "If number is rational, convert it to a mixed numeral (fraction/number)
   as a string"
  (multiple-value-bind (whole proper) (floor number)
    (if (> proper 0)
        (format nil "~a and ~a" whole proper)
        whole)))


;;; Hunchentoot setup
(defun main ()
  (start (make-instance 'easy-acceptor :port 4242))

  (define-easy-handler (trains :uri "/") (a b c)
    (let* ((ta (or (parse-input a)
                   25))
           (tb (or (parse-input b)
                   ta))
           (tc (or (parse-input c)
                   (+ ta tb))))
      (setf (content-type*) "text/html; charset=utf-8")
      (with-html-output-to-string (*standard-output* nil :prologue t)
        (:html
         (:head (:title "Train Problem"))
         (:body
          (:form
           :method :post
           "train a speed in kph: "
           (:input :type :text
                   :name "a" :value ta)
           (:br)
           "train b speed in kph: "
           (:input :type :text
                   :name "b" :value tb)
           (:br)
           "distance between the trains in km: "
           (:input :type :text
                   :name "c" :value tc)
           (:br)
           (:input :type "submit"))
          (:p
           (str (format nil
                        "The trains will pass each other after ~a hour~:p."
                        (rational-to-mixed
                         (train-pass ta tb tc)))))))))))
