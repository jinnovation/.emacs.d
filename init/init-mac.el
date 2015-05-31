;;; init-mac.el --- Mac-OS-specific configs
(provide 'init-mac)

(defconst is-mac (eq system-type 'darwin)
  "t when system is Mac.")

(when is-mac
    (setq mac-command-modifier 'meta))

;;; init-mac.el ends here
