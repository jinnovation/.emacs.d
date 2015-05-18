;;; init-keybinding.el --- Keybinding configs

(provide 'init-keybinding)

(require 'init-projectile)
(require 'init-fn)

(require 'elfeed)
(require 'evil)
(require 'evil-leader)
(require 'window-purpose)

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
(after 'org
  (define-key org-src-mode-map (kbd "H-s") 'org-edit-src-save))

(define-prefix-command 'jjin/chat-map)
(global-set-key (kbd "H-i") 'jjin/chat-map)

(define-key jjin/chat-map (kbd "i") 'helm-circe)
(define-key jjin/chat-map (kbd "n") 'helm-circe-new-activity)

;; buffer manipulation
(global-set-key (kbd "H-b b") 'helm-buffers-list)
(global-set-key (kbd "H-b k") 'kill-current-buffer)
(global-set-key (kbd "H-b n") 'next-buffer)

(global-set-key (kbd "H-a r") 'align-regexp)

(global-set-key (kbd "H-f f")  'helm-find-files)
;; mail
(global-set-key (kbd "H-m u") 'mu4e-update-mail-and-index)
(global-set-key (kbd "H-m i") 'mu4e-interrupt-update-mail)

(global-set-key (kbd "C-<tab>")            'other-window)
(global-set-key (kbd "\<C-S-iso-lefttab>") 'prev-window)

(global-set-key (kbd "H-D") 'dired-at-current)
(global-set-key (kbd "H-I") 'circe)
(global-set-key (kbd "H-M") 'mu4e)
(global-set-key (kbd "H-E") 'elfeed)
(global-set-key (kbd "H-A") 'org-agenda)

(global-set-key (kbd "C-<backspace>") 'undo-tree-undo)

(define-key elfeed-search-mode-map (kbd "<SPC>") 'next-line)

(global-set-key (kbd "C-x |") 'window-toggle-split-direction)
(global-set-key (kbd "C-x k") 'kill-current-buffer)

(global-set-key (kbd "C-x m") 'helm-M-x)

(define-key evil-emacs-state-map (kbd "<escape>") 'evil-execute-in-normal-state)

(define-key evil-normal-state-map (kbd "C-l")
  'evil-search-highlight-persist-remove-all)

(define-key evil-normal-state-map (kbd "L")     'evil-end-of-line)
(define-key evil-normal-state-map (kbd "H")     'evil-beginning-of-line)

(define-key evil-normal-state-map (kbd "C-w q") 'delete-window)
(define-key evil-normal-state-map (kbd "RET")   'insert-newline-after)

(define-key evil-normal-state-map (kbd "C-a")   'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)

(define-key evil-normal-state-map (kbd "C-w") 'hydra-window/body)

(define-key evil-insert-state-map (kbd "RET")
  'newline-and-indent)

(evil-leader/set-leader "<SPC>")

(define-key purpose-mode-prefix-map (kbd "W") 'purpose-set-window-purpose)

(define-key universal-argument-map (kbd "C-u") 'kill-whole-line)
(define-key universal-argument-map (kbd "M-u") 'universal-argument-more)

(after 'org
  (define-key org-mode-map (kbd "C-c o p") 'org-set-property)
  (define-key global-map (kbd "H-C") 'org-capture))

(after 'ess
  (define-key inferior-ess-mode-map (kbd "C-c C-w") nil))

;;; init-keybinding.el ends here
