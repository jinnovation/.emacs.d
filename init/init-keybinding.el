;;; init-keybinding.el --- Keybinding configs

(provide 'init-keybinding)

(require 'init-projectile)
(require 'init-fn)

(require 'elfeed)
(require 'evil)
(require 'evil-leader)
(require 'window-purpose)

(global-unset-key (kbd "M-c")) ;; capitalize-word
(global-unset-key (kbd "<menu>"))
(global-unset-key (kbd "M-`"))
(global-unset-key (kbd "C-c C-w"))
(global-unset-key (kbd "M-x"))
(global-unset-key (kbd "C-x C-n"))      ; set-goal-column

;; toggle-frame-maximized
(global-unset-key (kbd "M-<f10>"))
(global-unset-key (kbd "<escape> <f10>")) 

(global-set-key (kbd "H-s") 'save-buffer)
(global-set-key (kbd "H-g s") 'magit-status)
(global-set-key (kbd "H-w") 'ace-window)
(global-set-key (kbd "C-<tab>")            'other-window)
(global-set-key (kbd "\<C-S-iso-lefttab>") 'prev-window)

(global-set-key (kbd "<f1>") 'dired-at-current)
(global-set-key (kbd "<f9>") 'circe)
(global-set-key (kbd "<f10>") 'mu4e)
(global-set-key (kbd "<f11>") 'elfeed)
(global-set-key (kbd "<f12>") 'org-agenda)

(global-set-key (kbd "C-<backspace>") 'undo-tree-undo)

(define-key elfeed-search-mode-map (kbd "<SPC>") 'next-line)
(define-key elfeed-search-mode-map (kbd "B")
  (elfeed-expose #'elfeed-search-browse-url t))
(define-key elfeed-search-mode-map (kbd "h")
  (elfeed-expose #'elfeed-search-set-filter nil))

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

(define-key evil-insert-state-map (kbd "RET")
  'newline-and-indent)

(evilem-default-keybindings "SPC")

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "w"   'save-buffer

  "rtw" 'delete-trailing-whitespace

  ;; commenting
  "ci"  'evilnc-comment-or-uncomment-lines
  "cl"  'evilnc-quick-comment-or-uncomment-to-the-line
  "cc"  'evilnc-copy-and-comment-lines
  "cp"  'evilnc-comment-or-uncomment-paragraphs
  "cv"  'evilnc-toggle-invert-comment-line-by-line

  ;; IRC + chat
  "ii"  'helm-circe
  "in"  'helm-circe-new-activity

  "ar"  'align-regexp
  "/"   'helm-swoop
  "ff"  'helm-find-files

  ;; project
  "pp"  'helm-projectile
  "pf"  'helm-projectile-find-file
  "pF"  'helm-projectile-find-file-in-known-projects
  "pa"  'helm-projectile-ag
  "pK"  'projectile-kill-buffers
  "pc"  'projectile-compile-project

  ;; git + version-control
  "gs"  'magit-status

  ;; buffer manipulation
  "bb"  'helm-buffers-list
  "bk"  'kill-current-buffer
  "bn"  'next-buffer

  ;; mail
  "mu"  'mu4e-update-mail-and-index
  "mi"  'mu4e-interrupt-update-mail)

(evil-leader/set-key-for-mode 'org-mode "op" 'org-set-property)

(eval-after-load 'projectile
  '(evil-leader/set-key
     "w" 'save-buffer))

;; FIXME
(evil-define-key 'normal org-src-mode-map
  (kbd (concat evil-leader/leader " w"))
  'org-edit-src-save)

(define-key purpose-mode-map (kbd "C-c , W") 'purpose-set-window-purpose)

(define-key universal-argument-map (kbd "C-u") 'kill-whole-line)
(define-key universal-argument-map (kbd "M-u") 'universal-argument-more)

(after 'org
  (define-key org-mode-map (kbd "C-c C-w") nil))

(after 'ess
  (define-key inferior-ess-mode-map (kbd "C-c C-w") nil))

;;; init-keybinding.el ends here
