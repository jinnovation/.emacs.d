;;; init-appearance.el --- Color and font configurations

(provide 'init-appearance)
(require 'init-fn)

(require 'linum)
(require 'elfeed)

(defconst bg-color "black")
(defconst default-font "Terminus 08")
(set-frame-font default-font)
(set-face-attribute 'mode-line nil :font default-font)

(load-theme 'gotham t)

(set-background-color bg-color)
(set-face-attribute 'fringe nil :background bg-color)

(set-face-attribute 'linum nil :background bg-color)

;; TODO: set elfeed-search-feed-face to something less hideous

(set-face-foreground 'elfeed-search-title-face
  (face-attribute 'default :foreground))

(set-face-foreground 'elfeed-search-tag-face
  (face-attribute 'font-lock-doc-face :foreground))

;; FIXME: make color dependent on color scheme
(if-package-installed "evil-search-highlight-persist"
  (set-face-attribute
    'evil-search-highlight-persist-highlight-face
    nil
    :background "DodgerBlue4"))

(when (functionp 'set-fontset-font)
  (set-fontset-font "fontset-default"
    'unicode
    (font-spec :family "DejaVu Sans Mono")))

(set-transparency 85)

;;; init-appearance.el ends here
