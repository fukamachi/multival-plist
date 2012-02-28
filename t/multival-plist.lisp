#|
  This file is a part of multival-plist project.
  Copyright (c) 2012 Eitarow Fukamachi (e.arrows@gmail.com)
|#

(in-package :cl-user)
(defpackage multival-plist-test
  (:use :cl
        :multival-plist
        :cl-test-more))
(in-package :multival-plist-test)

(plan 15)

(defparameter *plist* '(:foo 1 :bar 2 :foo 3))

(is (getf-all *plist* :foo) '(1 3)
    "normal case")
(is (getf-all *plist* :bar) 2
    "normal case")

(is (getf-all *plist* :baz :undef)
    :undef
    :test #'eq
    "default value")

(is (setf (getf-all *plist* :foo) '(#\a #\b)) '(#\a #\b)
    "update multiple values")
(is (getf-all *plist* :foo) '(#\a #\b)
    "update multiple values")

(is (setf (getf-all *plist* :foo) "Hello") "Hello"
    "update with single value")
(is (getf-all *plist* :foo) "Hello"
    "update with single value")

(is (setf (getf-all *plist* :foo) '("Hello" "Lisp" "World"))
    '("Hello" "Lisp" "World")
    "update and create new keys")
(is (getf-all *plist* :foo) '("Hello" "Lisp" "World")
    "update and create new keys")

(is (setf (getf-all *plist* :qux) 3000)
    3000
    "create new value")
(is (getf-all *plist* :qux) 3000
    "create new value")

(is (setf (getf-all *plist* :baz) nil) nil
    "set NIL")
(is (getf-all *plist* :baz :undef)
    nil
    "set nil")

(ok (remf-all *plist* :foo)
    "remf-all")
(is (getf-all *plist* :foo :undef) :undef
    "remf-all")

(finalize)
