;;; init-keybinding.el --- Keybinding configs

(provide 'init-keybinding)
(require 'init-projectile)
(require 'init-fn)
(require 'hydra)
(require 'hydra-examples)

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

(if-package-installed "paradox"
    (global-set-key (kbd "<f12>") 'paradox-list-packages))

(global-set-key (kbd "M-x") 'helm-M-x)

(after 'evil
    (define-key evil-normal-state-map (kbd "C-w") 'hydra-window/body)
    (local-unset-key (kbd "C-a"))
    (local-unset-key (kbd "C-x C-x"))
    (local-unset-key (kbd "C-w"))
    (local-unset-key (kbd "C-l"))

    (define-key evil-normal-state-map (kbd "C-l")
        'evil-search-highlight-persist-remove-all)
    (define-key evil-normal-state-map (kbd "M-p") 'evil-paste-pop)
    (define-key evil-normal-state-map (kbd "L") 'evil-end-of-line)
    (define-key evil-normal-state-map (kbd "H") 'evil-beginning-of-line)
    (define-key evil-normal-state-map (kbd "RET") 'insert-newline-after)

    (define-key evil-insert-state-map (kbd "RET")
        'reindent-then-newline-and-indent)

    (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
    (define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)

    (evilem-default-keybindings "SPC")


    (after 'evil-leader
        (evil-leader/set-leader "<SPC>")
        (evil-leader/set-key
            "m" 'helm-M-x
            "w" 'save-buffer

            "b" 'hydra-buffers/body

            "rtw" 'delete-trailing-whitespace

            "c" 'hydra-comments/body

            "ar" 'align-regexp

            "g"  'hydra-magit/body
            "p" 'hydra-projectile/body

            "/" 'helm-swoop

            "ff" 'helm-find-files
            "rc" 'reload-config
            "TAB" 'persp-next
            "<backtab>" 'persp-prev
            "H" 'enlarge-window-horizontally-repeatable
            "L" (lambda () (interactive) (enlarge-window-horizontally -5)))))

(eval-after-load 'projectile
    '(evil-leader/set-key
         "w" 'projectile-save-and-test
         "W" 'save-buffer))

;;; init-keybinding.el ends here
