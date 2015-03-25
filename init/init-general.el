;;; init-general.el --- general configurations

(provide 'init-general)
(require 'init-fn)

(when (file-exists-p "~/.secrets.el")
  (load-file "~/.secrets.el"))

(setq
  user-mail-address "jjin082693@gmail.com"
  user-full-name  "Jonathan Jin"
  message-signature (concat "Jonathan Jin\n"
                      "github.com/jinnovation\n"
                      "jjin.me\n"))

(purpose-mode)
(purpose-load-window-layout)

(tool-bar-mode    0)
(scroll-bar-mode  0)
(menu-bar-mode    0)
(line-number-mode 0)

(setq inhibit-startup-screen t
  inhibit-startup-message t
  initial-scratch-message ""
  visible-bell t
  use-dialog-box nil)

(blink-cursor-mode 0)

(setq-default
  fill-column 80
  indent-tabs-mode nil
  tab-width 4)

(global-auto-revert-mode)

(setq browse-url-browser-function 'browse-url-generic
  browse-url-generic-program "chromium")

(global-hl-line-mode 1)
(column-number-mode 1)

(show-paren-mode 1)

(electric-pair-mode)

(delete-selection-mode +1)

;; highlights strings like TODO, FIXME, etc.
(if-package-installed "fic-mode"
  (add-hook 'prog-mode-hook 'fic-mode))

(add-hook 'prog-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

(setq next-line-add-newlines t)

(defalias 'yes-or-no-p 'y-or-n-p)

(add-hook 'comint-output-filter-functions
  'comint-watch-for-password-prompt)

(setq scroll-step 1
  scroll-margin 3)

(if-package-installed "smart-mode-line"
  (sml/setup))                             ;; smart-mode-line initialize

(fringe-mode '(4 . 0))

(if-package-installed "company"
  (company-mode)
  (setq company-idle-delay 0.0))

(set-transparency 70)

;;; init-general.el ends here
