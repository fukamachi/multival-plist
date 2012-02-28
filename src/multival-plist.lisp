#|
  This file is a part of multival-plist project.
  Copyright (c) 2012 Eitarow Fukamachi (e.arrows@gmail.com)
|#

(in-package :cl-user)
(defpackage multival-plist
  (:use :cl)
  (:import-from :trivial-types
                :property-list)
  (:import-from :alexandria
                :ensure-cons))
(in-package :multival-plist)

(cl-syntax:use-syntax :annot)

@export
(defmacro remf-all (plist key)
  "Removes a key and associated values for the given `key'."
  (let ((i (gensym)))
    `(loop for ,i upfrom 0
           while (remf ,plist ,key)
           finally (return (> ,i 0)))))

@export
(defun getf-all (plist key &optional (default () default-p))
  "This is a version of `getf' enabled to manage multiple keys. If the `plist' has two or more pairs that they have given `key' as a key, returns the values of each pairs as one list."
  (declare (property-list plist))
  (loop with params = nil
        for (k v) on plist by #'cddr
        if (string= k key)
          do (push v params)
        finally (return
                  (cond
                    ((not (consp params)) (if default-p default nil))
                    ((null (cdr params)) (car params))
                    (t (nreverse params))))))

@export
(defun (setf getf-all) (val plist key &optional (default () default-p))
  "Changes the stored value(s) of the given `key'. This removes or adds pairs as necessary to store the new list."
  (declare (property-list plist)
           (ignore default default-p))

  (loop with bind-values = (alexandria:ensure-cons val)
        for (k . rest) on plist by #'cddr
        when (eq k key)
          do (rplaca rest (pop bind-values))
        unless bind-values
          do (return (remf-all (cdr rest) k))
        finally
        (when bind-values (rplacd (last plist) (mapcan (lambda (v) (list key v)) bind-values))))

  val)
