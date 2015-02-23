(require 'f)

(defvar dotemacs-support-path
  (f-dirname load-file-name))

(defvar dotemacs-features-path
  (f-parent dotemacs-support-path))

(defvar dotemacs-root-path
  (f-parent dotemacs-features-path))

(add-to-list 'load-path dotemacs-root-path)

(require 'espuds)
(require 'ert)

(Before
 (switch-to-buffer
  (get-buffer-create "*emacs*"))
 (erase-buffer))
