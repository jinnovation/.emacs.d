;;; init-purpose.el --- configs for purpose.el

(provide 'init-purpose)

(purpose-x-magit-single-on)

(setq purpose-user-mode-purposes
  '((prog-mode . edit)))

(setq purpose-user-regexp-purposes
  '(("mu4e" . admin)
     ("^\\*elfeed" . admin)))

(purpose-compile-user-configuration)

;;; init-purpose.el ends here
