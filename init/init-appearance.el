;;; init-appearance.el --- Color and font configurations

(provide 'init-appearance)
(require 'init-fn)

(defconst bg-color "black")
(defconst default-font "Terminus 08")
(set-default-font default-font)

(setq font-face-main "DejaVu Sans Mono")
(setq font-size-small "10")
(setq font-size-bigger "15")
(setq font-setting-bigger (format "%s-%s" font-face-main font-size-bigger))
(setq font-setting-small (format "%s-%s" font-face-main font-size-small))

(load-theme 'gotham t)

(set-background-color bg-color)
(set-face-attribute 'fringe nil :background bg-color)

(after 'linum
    (set-face-attribute 'linum nil :background bg-color))

;; FIXME: make color dependent on color scheme
(if-package-installed "evil-search-highlight-persist"
    (set-face-attribute
        'evil-search-highlight-persist-highlight-face
        nil
        :background "DodgerBlue4"))

(set-face-attribute 'mode-line nil :font default-font)

(when (functionp 'set-fontset-font)
    (set-fontset-font "fontset-default"
        'unicode
        (font-spec :family "DejaVu Sans Mono")))

(set-face-attribute
    'hydra-face-blue
    nil
    :foreground "DodgerBlue4")

;;; init-appearance.el ends here
