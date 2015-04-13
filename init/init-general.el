;;; init-general.el --- general configurations

(provide 'init-general)
(require 'init-fn)

(when (file-exists-p "~/.secrets.el")
  (load-file "~/.secrets.el"))

(setq custom-safe-themes t)

(defun display-startup-echo-area-message ()
  (message "Happy hacking, and praise RMS."))

(setq
  user-mail-address "jjin082693@gmail.com"
  user-full-name  "Jonathan Jin"

  message-signature
  (concat "Jonathan Jin\n"
          "github.com/jinnovation\n"
          "jjin.me\n"))

(setq
  inhibit-startup-screen t
  inhibit-startup-message t
  initial-scratch-message ""
  visible-bell t
  use-dialog-box nil)

(setq-default
  fill-column 80
  indent-tabs-mode nil
  tab-width 4)

(setq
  browse-url-browser-function 'browse-url-generic
  browse-url-generic-program "chromium")

(setq next-line-add-newlines t)

(setq scroll-step 1
  scroll-margin 3)

(defalias 'yes-or-no-p 'y-or-n-p)

(tool-bar-mode     0)
(scroll-bar-mode   0)
(menu-bar-mode     0)
(line-number-mode  0)

(blink-cursor-mode 0)

(global-auto-revert-mode)

(global-hl-line-mode 1)
(column-number-mode  1)
(show-paren-mode     1)

(electric-pair-mode)

(delete-selection-mode +1)

;; highlights strings like TODO, FIXME, etc.
(add-hook 'prog-mode-hook
  (lambda ()
    (fic-mode)
    (turn-on-auto-fill)))

(add-hook 'text-mode-hook
  (lambda ()
    (turn-on-auto-fill)))

(add-hook 'help-mode-hook
  (lambda ()
    (rainbow-mode)))

(add-hook 'comint-output-filter-functions
  'comint-watch-for-password-prompt)

(sml/setup)                             ;; smart-mode-line initialize

(fringe-mode '(4 . 0))

(purpose-mode)
(purpose-load-window-layout)

(setq browse-url-browser-function 'eww-browse-url)

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(setq browse-url-browser-function 'eww-browse-url) ; use eww as default browser
(setq browse-url-generic-program (executable-find "chromium")
	shr-external-browser 'browse-url-generic)

(put 'dired-find-alternate-file 'disabled nil)

(global-aggressive-indent-mode 1)

;;; init-general.el ends here
