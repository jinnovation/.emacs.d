;;; init-evil.el --- Evil-mode-specific configurations (with all derivatives)

(provide 'init-evil)

(use-package evil
  :init
  (setq evil-esc-delay 0)
  
  :config
  (use-package org
    :config
    (append-to-list 'evil-insert-state-modes '(org-capture-mode)))
  
  (use-package git-commit-mode
    :config
    (append-to-list 'evil-insert-state-modes '(git-commit-mode)))
  
  (use-package circe
    :config
    (append-to-list 'evil-emacs-state-modes
      '(circe-chat-mode circe-server-mode circe-query-mode circe-channel-mode)))
  
  (use-package elfeed
    :config
    (append-to-list 'evil-emacs-state-modes
      '(elfeed-search-mode elfeed-show-mode)))
  
  (bind-key "<escape>" 'evil-execute-in-normal-state evil-emacs-state-map)
  (bind-key "L" 'evil-end-of-line evil-normal-state-map)
  (bind-key "H" 'evil-beginning-of-line evil-normal-state-map)
  (bind-key "C-w q" 'delete-window evil-normal-state-map)
  (bind-key "RET" 'insert-newline-after evil-normal-state-map)
  (bind-key "RET" 'newline-and-indent evil-insert-state-map)
  
  (use-package hydra
    :config
    (bind-key "C-w" 'hydra-window/body evil-normal-state-map))
  (use-package evil-numbers
    :config
    (bind-key "C-a" 'evil-numbers/inc-at-pt evil-normal-state-map)
    (bind-key "C-c -" 'evil-numbers/dec-at-pt evil-normal-state-map))
  (use-package evil-search-highlight-persist
    :config
    (bind-key "C-l" 'evil-search-highlight-persist-remove-all
      evil-normal-state-map)
    (global-evil-search-highlight-persist t))
  (evil-mode 1)
  (use-package evil-leader
    :config
    (evil-leader/set-leader "<SPC>")
    (global-evil-leader-mode))
  (use-package evil-surround
    :config
    (global-evil-surround-mode 1)))

(append-to-list 'evil-emacs-state-modes
  '(eshell-mode
     calendar-mode

     finder-mode
     info-mode

     eww-mode
     eww-bookmark-mode

     dired-mode
     image-mode
     image-dired-thumbnail-mode
     image-dired-display-image-mode
     pdf-view-mode
     pdf-outline-minor-mode

     git-rebase-mode

     inferior-ess-mode
     ess-help-mode

     paradox-menu-mode))

;;; init-evil.el ends here
