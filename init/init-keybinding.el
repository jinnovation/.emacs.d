;;; init-keybinding.el --- Keybinding configs

(provide 'init-keybinding)
   
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

;;; init-keybinding.el ends here
