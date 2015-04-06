(add-to-list 'load-path (expand-file-name "~/.emacs.d/init"))

;; packages not managed by Cask or package.el
(add-to-list 'load-path (expand-file-name "~/.emacs.d/pkg"))

(require 'cask)
(cask-initialize)
(pallet-mode t)

(require 'malyon)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
  '(ansi-color-faces-vector
     [default bold shadow italic underline bold bold-italic bold])
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
                  init-mu4e
                  init-circe
                  init-aw

                  ;; languages
                  init-ruby
                  init-c
                  init-js
                  init-haskell
                  init-lisp
                  init-sass
                  init-markdown
                  init-latex
                  init-r

                  init-compile

                  init-purpose

                  ;; environments
                  init-mac))
