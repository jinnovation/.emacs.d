;;; init-c.el --- C-specific configs
(provide 'init-c)

(require 'init-general)

(setq c-block-comment-prefix "* ")

(defvaralias 'c-basic-offset 'tab-width)

(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

;;; init-c.el ends here
