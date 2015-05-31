;;; init-appearance.el --- Color and font configurations

(provide 'init-appearance)

(use-package init-fn)

(defconst bg-color "black")
(defconst default-font "Terminus 08")
(set-frame-font default-font)
(set-face-attribute 'mode-line nil :font default-font)

(use-package gotham-theme
  :config
  (load-theme 'gotham t))

(set-background-color bg-color)
(set-face-attribute 'fringe nil :background bg-color)

(use-package linum
  :config
  (set-face-attribute 'linum nil :background bg-color))

(use-package evil-search-highlight-persist
  :config
  (set-face-attribute
    'evil-search-highlight-persist-highlight-face
    nil
    :background (face-attribute 'match :background)))

(when (functionp 'set-fontset-font)
  (set-fontset-font "fontset-default"
    'unicode
    (font-spec :family "DejaVu Sans Mono")))

(set-transparency 85)

;;; init-appearance.el ends here
