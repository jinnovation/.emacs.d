;;; init-sass.el --- Sass-specific configs
(provide 'init-sass)

(require 'init-fn)

(after "sass-mode-autoloads"
    (setq scss-compile-at-save nil)
    (add-hook 'scss-mode-hook 'rainbow-mode))

;;; init-sass.el ends here
