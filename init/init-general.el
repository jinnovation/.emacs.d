;;; init-general.el --- general configurations

(provide 'init-general)

(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'line-number-mode) (line-number-mode -1))

(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

(setq-default indent-tabs-mode nil)

(setq-default tab-width 4)

(global-auto-revert-mode)

(setq browse-url-browser-function 'browse-url-generic
    browse-url-generic-program "chromium")

(when (fboundp 'global-hl-line-mode)
    (global-hl-line-mode 1))

(when (fboundp 'column-number-mode)
    (column-number-mode 1))

(show-paren-mode 1)

(if-package-installed "autopair"
    (autopair-global-mode))

(delete-selection-mode +1)

;; highlights strings like TODO, FIXME, etc.
(if-package-installed "fic-ext-mode"
    (add-hook 'prog-mode-hook 'fic-ext-mode))

;; lines do not exceed 80 lines
;; (add-hook 'c-mode-common-hook 'turn-on-auto-fill)
(add-hook 'prog-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

(setq next-line-add-newlines t)

(setq-default fill-column 80)
(defalias 'yes-or-no-p 'y-or-n-p)

(add-hook 'comint-output-filter-functions
    'comint-watch-for-password-prompt)

(setq scroll-step 1)
(setq scroll-margin 3)

(if-package-installed "smart-mode-line"
    (sml/setup))                             ;; smart-mode-line initialize

(fringe-mode '(4 . 0))

(if-package-installed "company"
    (company-mode)
    (setq company-idle-delay 0.0))

;;; init-general.el ends here
