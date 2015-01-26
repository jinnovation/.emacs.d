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
    "q" 'save-buffers-kill-terminal
    "bk" (lambda nil
             (interactive)
             (kill-buffer (current-buffer)))
    "bn" 'next-buffer
    "rtw" 'delete-trailing-whitespace
    "cd" 'cd)

(define-key evil-normal-state-map ",ci" 'evilnc-comment-or-uncomment-lines)
(define-key evil-normal-state-map ",cl" 'evilnc-quick-comment-or-uncomment-to-the-line)
(define-key evil-normal-state-map ",ll" 'evilnc-quick-comment-or-uncomment-to-the-line)
(define-key evil-normal-state-map ",cc" 'evilnc-copy-and-comment-lines)
(define-key evil-normal-state-map ",cp" 'evilnc-comment-or-uncomment-paragraphs)
(define-key evil-normal-state-map ",cr" 'comment-or-uncomment-region)
(define-key evil-normal-state-map ",cv" 'evilnc-toggle-invert-comment-line-by-line)

(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)

(evil-mode 1)

(global-evil-search-highlight-persist t)
(define-key evil-normal-state-map (kbd "C-l") 'evil-search-highlight-persist-remove-all)

(setq scroll-step 1)
(setq scroll-margin 3)

(setq evil-insert-state-modes (cons 'git-commit-mode evil-insert-state-modes))
