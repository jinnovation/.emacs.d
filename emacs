(load "~/.emacs.d/elpa/benchmark-init-20141004.609/benchmark-init.el")

(setq package-archives
    '(("melpa" . "http://melpa.milkbox.net/packages/")
         ("marmalade" . "http://marmalade-repo.org/packages/")
         ("gnu" . "http://elpa.gnu.org/packages/")
         ("org" . "http://orgmode.org/elpa/")))

(package-initialize)

(defconst init-runtimes
    '(
         "prefs/packages.el"
         "prefs/defaults.el"
         "fn.el"
         "keybinding.el"
         "prefs.el"
         "prefs/org.el"
         "prefs/evil.el"
         "prefs/doc-view.el"
         "prefs/helm.el"))

(dolist (file init-runtimes)
    (load-file (expand-file-name file "~/.emacs.d")))

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

(mapc (lambda (assoc) (add-to-list 'auto-mode-alist assoc))
    (list '("Gemfile" . enh-ruby-mode)
        '("Guardfile" . enh-ruby-mode)
        '("conf$" . conf-mode)
        '("rc$" . conf-mode)
        '("\\.erb$" . web-mode)
        '("emacs$" . emacs-lisp-mode)))

(setq lisp-indent-offset 4)

(sml/setup)                             ;; smart-mode-line initialize

(defadvice linum-mode (around linum-mode-selective activate)
    "Avoids enabling of linum-mode in the buffer having major mode set to one
of listed in `linum-mode-excludes'."
    (unless (member major-mode linum-mode-excludes)
        ad-do-it))

(set-background-color bg-color)
(set-face-attribute 'fringe nil :background bg-color)
(set-face-attribute 'linum nil :background bg-color)

(set-face-attribute 'evil-search-highlight-persist-highlight-face nil :background "DodgerBlue4")

(set-default-font "Terminus 12")
(set-face-attribute 'mode-line nil :font default-font)

(add-to-list 'rm-excluded-modes " Helm")
(add-to-list 'rm-excluded-modes " Undo-Tree")
(add-to-list 'rm-excluded-modes " pair")
(add-to-list 'rm-excluded-modes " Fill")
