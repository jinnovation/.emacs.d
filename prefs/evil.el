(eval-after-load 'evil
    '(progn
       (define-key evil-normal-state-map ",ci" 'evilnc-comment-or-uncomment-lines)
       (define-key evil-normal-state-map ",cl" 'evilnc-quick-comment-or-uncomment-to-the-line)
       (define-key evil-normal-state-map ",ll" 'evilnc-quick-comment-or-uncomment-to-the-line)
       (define-key evil-normal-state-map ",cc" 'evilnc-copy-and-comment-lines)
       (define-key evil-normal-state-map ",cp" 'evilnc-comment-or-uncomment-paragraphs)
       (define-key evil-normal-state-map ",cr" 'comment-or-uncomment-region)
       (define-key evil-normal-state-map ",cv" 'evilnc-toggle-invert-comment-line-by-line)))

(evil-mode 1)
(global-evil-surround-mode 1)

(setq evil-esc-delay 0)
