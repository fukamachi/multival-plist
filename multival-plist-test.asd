#|
  This file is a part of multival-plist project.
  Copyright (c) 2012 Eitarow Fukamachi (e.arrows@gmail.com)
|#

(in-package :cl-user)
(defpackage multival-plist-test-asd
  (:use :cl :asdf))
(in-package :multival-plist-test-asd)

(defsystem multival-plist-test
  :author "Eitarow Fukamachi"
  :license "LLGPL"
  :depends-on (:multival-plist
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:file "multival-plist"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
