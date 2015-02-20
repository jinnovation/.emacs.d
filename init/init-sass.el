;;; init-sass.el --- Sass-specific configs
(provide 'init-sass)

(require 'init-fn)

(if-package-installed "sass-mode"
    (setq scss-compile-at-save nil)
    (add-hook 'scss-mode-hook 'rainbow-mode))

;;; init-sass.el ends here
