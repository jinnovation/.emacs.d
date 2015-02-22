;;; init-evil.el --- Evil-mode-specific configurations (with all derivatives)

(provide 'init-evil)

(require 'init-fn)

(after 'evil

    (setq evil-esc-delay 0)

    (global-evil-search-highlight-persist t)

    (setq evil-insert-state-modes (cons 'git-commit-mode evil-insert-state-modes))
    (setq evil-emacs-state-modes (cons 'erc-mode evil-emacs-state-modes)))


(global-evil-leader-mode)
(global-evil-surround-mode 1)

(evil-mode 1)

;;; init-evil.el ends here
