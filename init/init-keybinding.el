;;; init-keybinding.el --- Keybinding configs

(provide 'init-keybinding)
(require 'init-fn)

(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "\<C-S-iso-lefttab>")
    (lambda ()
        (interactive)
        (other-window -1)))

(global-set-key (kbd "<f2>") 'shell)
(global-set-key (kbd "<f11>") 'org-agenda)

(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)
(add-hook 'ruby-mode-hook
    (lambda () (local-set-key (kbd "RET")
                   'reindent-then-newline-and-indent)
	    (ruby-end-mode)))

(global-set-key (kbd "C-x |") 'window-toggle-split-direction)

(global-set-key (kbd "C-x k") 'kill-current-buffer)

(global-set-key (kbd "<f12>") 'paradox-list-packages)

(global-set-key (kbd "M-x") 'helm-M-x)

(after 'evil
    (local-unset-key (kbd "C-a"))
    (local-unset-key (kbd "C-x C-x"))
    (local-unset-key (kbd "C-w"))
    (local-unset-key (kbd "C-l"))

    (define-key evil-normal-state-map (kbd "C-l") 'evil-search-highlight-persist-remove-all)
    (define-key evil-normal-state-map (kbd "M-p") 'evil-paste-pop)
    (define-key evil-normal-state-map (kbd "L") 'evil-end-of-line)
    (define-key evil-normal-state-map (kbd "H") 'evil-beginning-of-line)
    (define-key evil-normal-state-map (kbd "C-w q") 'delete-window)
    (define-key evil-normal-state-map (kbd "RET") 'insert-newline-after)

    (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
    (define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)

    (evilem-default-keybindings "SPC")

    (after 'evil-leader
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
            "L" (lambda () (interactive)(enlarge-window-horizontally -5)))))
;;; init-keybinding.el ends here
