#|
  This file is a part of multival-plist project.
  Copyright (c) 2012 Eitarow Fukamachi (e.arrows@gmail.com)
|#

#|
  Property List stores multiple values per one key.

  Author: Eitarow Fukamachi (e.arrows@gmail.com)
|#

(in-package :cl-user)
(defpackage multival-plist-asd
  (:use :cl :asdf))
(in-package :multival-plist-asd)

(defsystem multival-plist
  :version "0.1"
  :author "Eitarow Fukamachi"
  :license "LLGPL"
  :depends-on (:cl-annot
               :cl-syntax-annot
               :trivial-types
               :alexandria)
  :components ((:module "src"
                :components
                ((:file "multival-plist"))))
  :description "Property List stores multiple values per one key."
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (load-op multival-plist-test))))
