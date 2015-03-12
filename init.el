(add-to-list 'load-path (expand-file-name "~/.emacs.d/init"))

(require 'cask)
(cask-initialize)
(pallet-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
    '(ansi-color-faces-vector
         [default bold shadow italic underline bold bold-italic bold])
    '(custom-safe-themes
         (quote
             ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "62c9339d5cac3a49688abb34e98f87a6ee82003a11251f12e0ada1788090c40f" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" default)))
 '(paradox-github-token t))

(mapc 'require '(init-fn
                    init-keybinding
                    init-general
                    init-org
                    init-evil
                    init-doc-view
                    init-helm
                    init-modes
                    init-projectile
                    init-rm
                    init-linum
                    init-appearance

                    init-elfeed
                    init-gnus

                    ;; languages
                    init-ruby
                    init-c
                    init-js
                    init-haskell
                    init-lisp
                    init-sass
                    init-markdown
                    init-latex

                    init-compile

                    ;; environments
                    init-mac))
