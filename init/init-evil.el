;;; init-evil.el --- Evil-mode-specific configurations (with all derivatives)

(provide 'init-evil)

(require 'init-fn)

(require 'evil)

(setq evil-esc-delay 0)
(global-evil-search-highlight-persist t)

(append-to-list 'evil-insert-state-modes
  '(git-commit-mode))

(append-to-list 'evil-emacs-state-modes
    '(erc-mode
       elfeed-search-mode
       elfeed-show-mode
       eshell-mode
       calendar-mode
       circe-chat-mode
       circe-server-mode
       circe-query-mode
       circe-channel-mode

       finder-mode
       info-mode

       eww-mode
       eww-bookmark-mode

       dired-mode
       image-mode
       image-dired-thumbnail-mode
       image-dired-display-image-mode

       git-rebase-mode

       inferior-ess-mode

       paradox-menu-mode))

(global-evil-leader-mode)
(global-evil-surround-mode 1)

(evil-mode 1)

;;; init-evil.el ends here
