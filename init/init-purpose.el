;;; init-purpose.el --- configs for purpose.el

(provide 'init-purpose)

(purpose-x-magit-single-on)

(setq purpose-user-mode-purposes
  '((prog-mode . edit)
     (text-mode . edit)
     (yaml-mode . edit)
     (circe-channel-mode . comm)
     (circe-chat-mode . comm)
     (circe-query-mode . comm)
     (circe-lagmon-mode . comm)
     (circe-server-mode . comm)))

(setq purpose-user-regexp-purposes
  '(("mu4e" . admin)
     ("^\\*elfeed" . admin)))

(purpose-compile-user-configuration)

;;; init-purpose.el ends here
