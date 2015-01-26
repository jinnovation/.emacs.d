(load "~/.emacs.d/elpa/benchmark-init-20141004.609/benchmark-init.el")

(defconst user-init-dir "~/.emacs.d/")

(setq package-archives
    '(("melpa" . "http://melpa.milkbox.net/packages/")
         ("marmalade" . "http://marmalade-repo.org/packages/")
         ("gnu" . "http://elpa.gnu.org/packages/")
         ("org" . "http://orgmode.org/elpa/")))

(package-initialize)

(defun load-user-file (file)
    (interactive "f")
    "Load a file in current user's configuration directory"
    (load-file (expand-file-name file user-init-dir)))


(load-user-file "fn.el")
(load-user-file "require.el")
(load-user-file "keybinding.el")
(load-user-file "prefs.el")

(load-user-file "prefs/org.el")
(load-user-file "prefs/evil.el")
(load-user-file "prefs/defaults.el")

(when (eq system-type 'darwin)
    (setq mac-command-modifier 'meta))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-newline-function (quote reindent-then-newline-and-indent))
    '(ansi-color-faces-vector
         [default bold shadow italic underline bold bold-italic bold])
 '(paradox-github-token t))

(add-to-list 'auto-mode-alist '("Gemfile" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))
(add-to-list 'auto-mode-alist '("conf$" . conf-mode))
(add-to-list 'auto-mode-alist '("conky" . rainbow-mode))
(add-to-list 'auto-mode-alist '("conky" . conf-space-mode))
(add-to-list 'auto-mode-alist '("rc$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))

(setq lisp-indent-offset 4)
