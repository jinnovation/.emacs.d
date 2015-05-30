;;; init-keybinding.el --- Keybinding configs

(provide 'init-keybinding)

(require 'init-projectile)
(require 'init-fn)

(global-unset-key (kbd "<menu>"))
(global-unset-key (kbd "M-`"))
(global-unset-key (kbd "C-c C-w"))
(global-unset-key (kbd "M-x"))
(global-unset-key (kbd "C-x C-n"))      ; set-goal-column

(global-unset-key (kbd "<f10>"))
(global-unset-key (kbd "<f11>"))
(global-unset-key (kbd "M-<f10>"))
(global-unset-key (kbd "<escape> <f10>"))

(global-set-key (kbd "H-s") 'save-buffer)

(define-prefix-command 'jjin/chat-map)
(global-set-key (kbd "H-i") 'jjin/chat-map)

(define-key jjin/chat-map (kbd "i") 'helm-circe)
(define-key jjin/chat-map (kbd "n") 'helm-circe-new-activity)

;; buffer manipulation
(global-set-key (kbd "H-b k") 'kill-current-buffer)
(global-set-key (kbd "H-b n") 'next-buffer)

(global-set-key (kbd "H-a r") 'align-regexp)

(global-set-key (kbd "C-<tab>")            'other-window)
(global-set-key (kbd "\<C-S-iso-lefttab>") 'prev-window)

(global-set-key (kbd "H-D") 'dired-at-current)
(global-set-key (kbd "H-A") 'org-agenda)

(global-set-key (kbd "C-<backspace>") 'undo-tree-undo)

(global-set-key (kbd "C-x |") 'window-toggle-split-direction)
(global-set-key (kbd "C-x k") 'kill-current-buffer)

(define-key universal-argument-map (kbd "C-u") 'kill-whole-line)
(define-key universal-argument-map (kbd "M-u") 'universal-argument-more)

;;; init-keybinding.el ends here
