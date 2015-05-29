(add-to-list 'load-path (expand-file-name "~/.emacs.d/init"))

;; packages not managed by Cask or package.el
(add-to-list 'load-path (expand-file-name "~/.emacs.d/pkg"))

(require 'cask)
(cask-initialize)
(pallet-mode t)

(require 'ess-site)

(pdf-tools-install)

(setq paradox-github-token t)
(setq ansi-color-faces-vector
  [default bold shadow italic underline bold bold-italic bold])

(mapc 'require '(init-fn
                  init-keybinding
                  init-general

                  init-hydra

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

                  ;; init-purpose

                  ;; environments
                  init-mac))
