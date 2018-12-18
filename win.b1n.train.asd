;;;; win.bin.train.asd

(asdf:defsystem #:win.b1n.train
  :description "Runs a classic train problem as a web app"
  :author "Nathanael Merlin <nate@merlin.uno>"
  :license "BSD"
  :depends-on (#:hunchentoot
               #:cl-who)
  :serial t
  :components ((:file "package")
               (:file "win.b1n.train"))
  :build-operation "program-op"
  :build-pathname "train-problem-lisp"
  :entry-point "win.b1n.train:main")

