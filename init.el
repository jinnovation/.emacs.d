(add-to-list 'load-path (expand-file-name "~/.emacs.d/init"))

;; packages not managed by Cask or package.el
(add-to-list 'load-path (expand-file-name "~/.emacs.d/pkg"))

(require 'cask)
(cask-initialize)
(pallet-mode t)

(require 'ess-site)
(require 'use-package)

(pdf-tools-install)

(setq paradox-github-token t)
(setq ansi-color-faces-vector
  [default bold shadow italic underline bold bold-italic bold])

(use-package ace-window
  :config
  (add-to-list 'aw-ignored-buffers "mu4e-update")
  (setq aw-keys '(?a ?r ?s ?t ?q ?w ?f ?p)))

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
