;;; init-purpose.el --- configs for purpose.el

(provide 'init-purpose)

(purpose-x-magit-multi-on)

(setq purpose-user-mode-purposes
  '((circe-channel-mode . comm)
     (circe-chat-mode   . comm)
     (circe-query-mode  . comm)
     (circe-lagmon-mode . comm)
     (circe-server-mode . comm)

     (haskell-mode      . edit)
     (ess-mode          . edit)
     (gitconfig-mode    . edit)
     (inferior-ess-mode . interactive)

     (mu4e-main-mode    . admin)
     (mu4e-view-mode    . admin)
     (mu4e-about-mode   . admin)
     (mu4e-headers-mode . admin)
     (mu4e-compose-mode . edit)))

(setq purpose-user-regexp-purposes
  '(("^\\*elfeed" . admin)))

(purpose-compile-user-configuration)

;;; init-purpose.el ends here
