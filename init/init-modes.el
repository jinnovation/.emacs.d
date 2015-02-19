(provide 'init-modes)

(defconst file-mode-assocs
    '(
         ("graded-hw"       . c-mode)
         ("\\.service\\'"    . conf-unix-mode)
         ("\\.timer\\'"      . conf-unix-mode)
         ("\\.target\\'"     . conf-unix-mode)
         ("\\.mount\\'"      . conf-unix-mode)
         ("\\.automount\\'"  . conf-unix-mode)
         ("\\.slice\\'"      . conf-unix-mode)
         ("\\.socket\\'"     . conf-unix-mode)
         ("zshrc$"           . sh-mode)
         ("gitconfig"        . gitconfig-mode)
         ("\\.path\\'"       . conf-unix-mode)
         ("Gemfile"          . enh-ruby-mode)
         ("Guardfile"        . enh-ruby-mode)
         ("conf$"            . conf-mode)
         ("rc$"              . conf-mode)
         ("\\.erb$"          . web-mode)
         ("emacs$"           . emacs-lisp-mode)))
(mapc (lambda (assoc) (add-to-list 'auto-mode-alist assoc))
    file-mode-assocs)

