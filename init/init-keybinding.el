;;; init-keybinding.el --- Keybinding configs

(provide 'init-keybinding)

(use-package init-fn
  :bind (("C-x |" . window-toggle-split-direction)
          ("C-x k" . kill-current-buffer)))

(unbind-key "<menu>")
(unbind-key "M-`")
(unbind-key "C-c C-w")
(unbind-key "M-x")
(unbind-key "C-x C-n")      ; set-goal-column

(unbind-key "<f10>")
(unbind-key "<f11>")
(unbind-key "M-<f10>")
(unbind-key "<escape> <f10>")

(bind-key "H-s" 'save-buffer)

(define-prefix-command 'jjin/chat-map)
(bind-key "H-i" 'jjin/chat-map)

;; buffer manipulation
(bind-key "H-b k" 'kill-current-buffer)
(bind-key "H-b n" 'next-buffer)

(bind-key "H-a r" 'align-regexp)

(bind-key "C-<tab>" 'other-window)
(bind-key "\<C-S-iso-lefttab>" 'prev-window)

(bind-key "H-D" 'dired-at-current)

(use-package undo-tree
  :bind ("C-<backspace>" . undo-tree-undo))

(bind-key "C-u" 'kill-whole-line universal-argument-map)
(bind-key "M-u" 'universal-argument-more universal-argument-map)

;;; init-keybinding.el ends here
