(add-to-list 'load-path (expand-file-name "~/.emacs.d/init"))

(setq package-archives
    '(("melpa"         . "http://melpa.milkbox.net/packages/")
         ("marmalade"  . "http://marmalade-repo.org/packages/")
         ("gnu"        . "http://elpa.gnu.org/packages/")
         ("org"        . "http://orgmode.org/elpa/")))

(package-initialize)

(mapc 'require '(init-fn
                    init-packages
                    init-keybinding
                    init-general
                    init-org
                    init-evil
                    init-doc-view
                    init-helm
                    init-color
                    init-modes
                    init-projectile
                    init-ruby))

(custom-set-variables
    ;; custom-set-variables was added by Custom.
    ;; If you edit it by hand, you could mess it up, so be careful.
    ;; Your init file should contain only one such instance.
    ;; If there is more than one, they won't work right.
    '(TeX-newline-function (quote reindent-then-newline-and-indent))
    '(ansi-color-faces-vector
         [default bold shadow italic underline bold bold-italic bold]))
