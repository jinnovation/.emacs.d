(eval-after-load 'evil
  '(progn
       (local-unset-key (kbd "C-a"))
       (local-unset-key (kbd "C-x C-x"))
       (local-unset-key (kbd "C-w"))
       (local-unset-key (kbd "C-l"))))

(global-evil-leader-mode)
(global-evil-surround-mode 1)

(setq evil-esc-delay 0)

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
    "m" 'helm-M-x
    "w" 'save-buffer
    "bk" 'kill-current-buffer
    "bn" 'next-buffer

    "rtw" 'delete-trailing-whitespace

    "ci" 'evilnc-comment-or-uncomment-lines
    "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
    "cc" 'evilnc-copy-and-comment-lines
    "cp" 'evilnc-comment-or-uncomment-paragraphs
    "cv" 'evilnc-toggle-invert-comment-line-by-line

    "ar" 'align-regexp

    "gs" 'magit-status
    "gb" 'magit-blame-mode

    "pp" 'helm-projectile
    "pF" 'helm-projectile-find-file-in-known-projects
    "pa" 'helm-projectile-ag
    "pK" 'projectile-kill-buffers

    "/" 'helm-swoop

    "ff" 'helm-find-files
    "rc" 'reload-config
    "bb" 'helm-buffers-list
    "TAB" 'persp-next
    "<backtab>" 'persp-prev
    "H" (lambda () (interactive) (enlarge-window-horizontally-repeatable 5))
    "L" (lambda () (interactive)(enlarge-window-horizontally -5)))


(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)

(global-evil-search-highlight-persist t)

(define-key evil-normal-state-map (kbd "C-l") 'evil-search-highlight-persist-remove-all)
(define-key evil-normal-state-map (kbd "M-p") 'evil-paste-pop)
(define-key evil-normal-state-map (kbd "L") 'evil-end-of-line)
(define-key evil-normal-state-map (kbd "H") 'evil-beginning-of-line)
(define-key evil-normal-state-map (kbd "C-w q") 'delete-window)
(define-key evil-normal-state-map (kbd "RET") 'insert-newline-after)

(setq evil-insert-state-modes (cons 'git-commit-mode evil-insert-state-modes))
(setq evil-emacs-state-modes (cons 'erc-mode evil-emacs-state-modes))

(evilem-default-keybindings "SPC")

(evil-mode 1)
