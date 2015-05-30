;;; init-mode.el --- Extension-mode associations

(provide 'init-modes)

(defconst file-mode-assocs
  '(
     ("zshrc$"           . sh-mode)
     ("\\.zsh$"          . sh-mode)
     ("emacs$"           . emacs-lisp-mode)
     ("Cask"             . emacs-lisp-mode)))

(mapc (lambda (assoc) (add-to-list 'auto-mode-alist assoc))
    file-mode-assocs)

;;; init-mode.el ends here
