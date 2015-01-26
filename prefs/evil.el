(eval-after-load 'evil
  '(progn
       (global-unset-key (kbd "C-a"))
       (global-unset-key (kbd "C-x C-x"))
       (global-unset-key (kbd "C-w"))
       (global-unset-key (kbd "C-l"))))

(global-evil-leader-mode)
(global-evil-surround-mode 1)

(setq evil-esc-delay 0)

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
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

    "pp" 'helm-projectile)

(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)

(global-evil-search-highlight-persist t)

(define-key evil-normal-state-map (kbd "C-l") 'evil-search-highlight-persist-remove-all)
(define-key evil-normal-state-map (kbd "M-p") 'evil-paste-pop)
(define-key evil-normal-state-map (kbd "L") 'evil-end-of-line)
(define-key evil-normal-state-map (kbd "H") 'evil-beginning-of-line)

(setq evil-insert-state-modes (cons 'git-commit-mode evil-insert-state-modes))

(evilem-default-keybindings "SPC")

(evil-mode 1)

(global-set-key (kbd "<f12>") 'package-list-packages)
