(setq package-archives
    '(("melpa"         . "http://melpa.milkbox.net/packages/")
         ("marmalade"  . "http://marmalade-repo.org/packages/")
         ("gnu"        . "http://elpa.gnu.org/packages/")
         ("org"        . "http://orgmode.org/elpa/")))

(package-initialize)

(defconst init-runtimes
    '(
         "prefs/packages.el"
         "prefs/fn.el"
         "prefs/keybinding.el"
         "prefs/general.el"
         "prefs/org.el"
         "prefs/evil.el"
         "prefs/doc-view.el"
         "prefs/helm.el"
         "prefs/color.el"
         "prefs/modes.el"
         "prefs/projectile.el"
         ))
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

(setq lisp-indent-offset 4)

(setq helm-external-programs-associations '(("pdf" . "zathura")))

(sml/setup)                             ;; smart-mode-line initialize

(defadvice linum-mode (around linum-mode-selective activate)
    "Avoids enabling of linum-mode in the buffer having major mode set to one
of listed in `linum-mode-excludes'."
    (unless (member major-mode linum-mode-excludes)
        ad-do-it))

(defconst my-rm-excluded-modes
    '(
         " Helm"
         " Undo-Tree"
         " pair"
         " Fill"
         " FIC"
         " company"
         " end"))
(dolist (mode my-rm-excluded-modes)
    (add-to-list 'rm-excluded-modes mode))

(fringe-mode '(4 . 0))

(company-mode)
(setq company-idle-delay 0.0)
