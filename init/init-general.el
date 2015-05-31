;;; init-general.el --- general configurations

(provide 'init-general)
(use-package init-fn)

(load-if-exists "~/.secrets.el")

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

(setq next-line-add-newlines t)

(setq scroll-step 1
  scroll-margin 3)

(fset 'yes-or-no-p 'y-or-n-p)

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

(add-hook 'text-mode-hook 'turn-on-auto-fill)

(add-hook 'help-mode-hook 'rainbow-mode)

(fringe-mode '(4 . 0))

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(setq browse-url-browser-function 'browse-url-xdg-open)
(setq browse-url-generic-program (executable-find "firefox")
  shr-external-browser 'browse-url-generic)

(put 'dired-find-alternate-file 'disabled nil)

(use-package magit
  :config
  (setq magit-last-seen-setup-instructions "1.4.0"))

(setq echo-keystrokes 0)

(setq image-dired-external-viewer "feh")

;;; init-general.el ends here
