;;; init-general.el --- general configurations

(provide 'init-general)
(require 'init-fn)

(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(line-number-mode 0)

(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq visible-bell t)

(blink-cursor-mode 0)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(global-auto-revert-mode)

(setq browse-url-browser-function 'browse-url-generic
    browse-url-generic-program "chromium")

(global-hl-line-mode 1)
(column-number-mode 1)

(show-paren-mode 1)

(if-package-installed "autopair"
    (autopair-global-mode))

(delete-selection-mode +1)

;; highlights strings like TODO, FIXME, etc.
(if-package-installed "fic-ext-mode"
    (add-hook 'prog-mode-hook 'fic-ext-mode))

;; lines do not exceed 80 lines
;; (add-hook 'c-mode-common-hook 'turn-on-auto-fill)
(setq-default fill-column 80)
(add-hook 'prog-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

(setq next-line-add-newlines t)

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

(set-transparency 70)

;;; init-general.el ends here
