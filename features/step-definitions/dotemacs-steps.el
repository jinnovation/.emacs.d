;; This file contains your project specific step definitions. All
;; files in this directory whose names end with "-steps.el" will be
;; loaded automatically by Ecukes.

(Then "^I should have a buffer named \"\\(.*\\)\"$"
    (lambda (buffer-name)
        (cl-assert (not (eq nil (get-buffer buffer-name)))
            nil
            "could not find buffer")))

(Then "^it should save the buffer"
    (lambda ()
        (cl-assert (eq nil (buffer-modified-p)))))
