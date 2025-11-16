(require 'cl)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa"))

(setq package-archives '(("gnu"           . "http://elpa.gnu.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("melpa"        . "http://melpa.org/packages/")
                         ("non-gnu-elpa" . "https://elpa.nongnu.org/nongnu/")
                         ("org"          . "https://orgmode.org/elpa/")))

(package-initialize)

;; straight.el bootstrapping
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

;; For whatever godawful reason something in here is loading Org prior to the
;; (use-package org) block, which causes esoteric load failures, e.g. functions
;; missing that should be there.
;;
;; Remove this whenever you find the root cause.
(straight-use-package 'org)

;; The =:if= clause lets us suppress configuration/loading of a given package if
;; a provided condition doesn't hold. The following will log such cases
;; non-fatally.
(defun jjin/use-package-if-prehook (name _keyword pred rest state)
  (unless pred (error "predicated failed; skipping package")))

(advice-add 'use-package-handler/:if :before 'jjin/use-package-if-prehook)

(use-package diminish :straight t)

(use-package system-packages
    :straight t
    :custom
    (system-packages-use-sudo nil)
    :init
    (when (eq system-type 'darwin)
      (setq system-packages-package-manager 'brew)))

(use-package dash :straight t)

(setq default-directory "~")
(setq command-line-default-directory "~")

(defvar jjin-ext-file-handlers
  `((,(intern "darwin") . (:image
                           ("open")
                           :video
                           ("open" "vlc")))
    (,(intern "gnu/linux") . (:image
                              ("feh")
                              :video
                              ("vlc"))))
  "An alist mapping `system-type' values to priority lists of
  file handlers, e.g. image viewers or video players.")

(defun jjin-kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(defun jjin-window-toggle-split-direction ()
  "Switch window split from horizontally to vertically, or vice versa.

i.e. change right window to bottom, or change bottom window to right."
  (interactive)
  (require 'windmove)
  (let ((done))
    (dolist (dirs '((right . down) (down . right)))
      (unless done
        (let* ((win (selected-window))
               (nextdir (car dirs))
               (neighbour-dir (cdr dirs))
               (next-win (windmove-find-other-window nextdir win))
               (neighbour1 (windmove-find-other-window neighbour-dir win))
               (neighbour2 (if next-win (with-selected-window next-win
                                          (windmove-find-other-window
                                           neighbour-dir next-win)))))

          (setq done (and (eq neighbour1 neighbour2)
                          (not (eq (minibuffer-window) next-win))))
          (if done
              (let* ((other-buf (window-buffer next-win)))
                (delete-window next-win)
                (if (eq nextdir 'right)
                    (split-window-vertically)
                  (split-window-horizontally))
                (set-window-buffer (windmove-find-other-window neighbour-dir)
                                   other-buf))))))))

(defun jjin-set-opacity (value)
  "Sets the opacity of the frame window. 0=transparent/100=opaque"
  (interactive "nOpacity Value (0 - 100 opaque): ")
  (set-frame-parameter (selected-frame) 'alpha value))

;; credit: https://github.com/abo-abo/hydra/blob/master/hydra-examples.el
(defun jjin-move-splitter-left (arg)
  "Move window splitter left."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'right))
      (shrink-window-horizontally arg)
    (enlarge-window-horizontally arg)))

;; credit: https://github.com/abo-abo/hydra/blob/master/hydra-examples.el
(defun jjin-move-splitter-right (arg)
  "Move window splitter right."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'right))
      (enlarge-window-horizontally arg)
    (shrink-window-horizontally arg)))

;; credit: https://github.com/abo-abo/hydra/blob/master/hydra-examples.el
(defun jjin-move-splitter-up (arg)
  "Move window splitter up."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'up))
      (enlarge-window arg)
    (shrink-window arg)))

;; credit: https://github.com/abo-abo/hydra/blob/master/hydra-examples.el
(defun jjin-move-splitter-down (arg)
  "Move window splitter down."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'up))
      (shrink-window arg)
    (enlarge-window arg)))

(defun jjin-get-current-displays ()
  "Get alist of attributes of displays w/ Emacs buffers."
  (interactive)
  (remove-if
   (lambda (disp)
     (eq nil (cdr (assoc 'frames disp))))
   (display-monitor-attributes-list)))

(defun jjin-fontify-frame (&optional _)
  "Set font and font size dynamically for the given frame."
  (let* ((attrs (frame-monitor-attributes))
         (width (fourth (first attrs)))
         (size 12))
    (when (= width 3840)                 ; external monitor 4k
      (setq size 16))
    ;; FIXME: Integrate w/ jjin/font-priority-list
    ;; FIXME: Need a jjin/get-font-for-frame function that returns the frame's
    ;; currently active font if none in jjin/font-priority-list are found
    (set-frame-font (format "Iosevka %s" size))))

(setq tramp-verbose 4)
(defconst jjin/secrets-file "~/.secrets.el")
(when (file-exists-p jjin/secrets-file) (load-file jjin/secrets-file))

(setq ring-bell-function 'ignore)

(setq large-file-warning-threshold nil)

(setq
 inhibit-startup-screen t
 inhibit-startup-message t
 initial-scratch-message nil
 visible-bell nil
 use-dialog-box nil)

(setq-default
 indent-tabs-mode nil
 tab-width 4)

(setq next-line-add-newlines t)

(setq scroll-step 1
      scroll-conservatively 10000
      scroll-margin 3)

(setq use-short-answers t)

(when window-system
  (tool-bar-mode     0)
  (scroll-bar-mode   0)
  (menu-bar-mode     0)
  (line-number-mode  0))

(blink-cursor-mode 0)

(global-auto-revert-mode)
(setq auto-revert-remote-files t)

(global-hl-line-mode 1)
(column-number-mode  1)
(show-paren-mode     1)

(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(electric-pair-mode)

(delete-selection-mode +1)

(add-hook 'prog-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

(fringe-mode '(4 . 0))

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(put 'dired-find-alternate-file 'disabled nil)

(setq echo-keystrokes 0)

(use-package image-dired
    :after dash
    :init
    (if-let* ((handlers (alist-get system-type jjin-ext-file-handlers))
              (handler (-first 'executable-find (plist-get handlers :image))))
        (setq image-dired-external-viewer (executable-find handler))))

(setq term-ansi-default-program (getenv "SHELL"))

(setq enable-remote-dir-locals t)

(setq custom-file "~/.emacs-custom.el")
(when (file-exists-p custom-file) (load custom-file))

(use-package midnight
    :init
  (setq clean-buffer-list-delay-general 0.006)) ; 10 minutes

(setq-default fill-column 100)

;; This sets indentation such that plists aren't indented oddly.
;;
;; Specifically, instead of this:
;; (:foo "bar"
;;       :baz 1)
;;
;; You now get:
;; (:foo "bar"
;;  :baz 1)
(setq lisp-indent-function #'common-lisp-indent-function)

(display-fill-column-indicator-mode 1)

(use-package gotham-theme
    :if window-system
    :disabled t
    :config
    (load-theme 'gotham t))

(use-package nord-theme
    :if window-system
    :straight t
    :disabled t
    :custom (nord-comment-brightness 10)
    :config
    (load-theme 'nord t))

(use-package kaolin-themes
    :if window-system
    :straight t
    :config
    (load-theme 'kaolin-ocean t))

(setq-default x-stretch-cursor t)

(setq custom-safe-themes t)

(defun jjin/switch-to-scratch-or-create ()
  "Switches to scratch buffer if it exists, creating it if not."
  (interactive)
  (switch-to-buffer "*scratch*"))

(defun jjin/font-installed-p (font-name)
  "Returns t if FONT-NAME is found to be installed; nil otherwise."
  (not (null (x-list-fonts font-name))))

;; FIXME: This needs to tap homebrew/cask-fonts first
;; FIXME: This currently does not work, since
;; `system-packages-package-installed-p' isn't anything more than an alias to
;; `executable-find', making this useless.
;; (system-packages-ensure "font-iosevka")

;; FIXME:
;;
;; Elements in font-priority-list should consist of:
;;   - Font name;
;;   - Sizes for: large screens; small screens; etc.
;;
;; This can allow consuming functions e.g. jjin-fontify-frame to select both the
;; name and size based on the display the current frame resides on.
(defvar jjin/font-priority-list
  '("Iosevka Nerd Font 12" "Iosevka 12" "IBM Plex Mono 12" "Source Code Pro 14" "Terminus (TTF) 16")
  "Priority-sorted list of fonts to attempt to set frame to.")

;; TODO: Install font-iosevka

(if window-system
    (-when-let (font-name (-first 'jjin/font-installed-p jjin/font-priority-list))
      (set-frame-font font-name)))

;; (when (functionp 'set-fontset-font)
;;   (set-fontset-font "fontset-default"
;;                     'unicode
;;                     (font-spec :family "DejaVu Sans Mono")))

(jjin-set-opacity 90)

(add-hook 'window-size-change-functions #'jjin-fontify-frame)

(add-to-list 'default-frame-alist '(undecorated . t))
(when (eq system-type 'darwin)
  (add-to-list 'auth-sources 'macos-keychain-internet)

  (setq mac-command-modifier 'meta)
  (setq mac-right-command-modifier 'meta)
  (setq mac-option-modifier 'super)
  (setq mac-right-option-modifier 'super)
  (setq system-uses-terminfo nil))


;;    =compilation-mode= invokes shell in a non-interactive shell, which means
;;    that configurations in =.bashrc= do not get surfaced. This can cause
;;    complications in cases where, for instance, successful compilation is
;;    predicated on conditions set within a provisioned profile file that I do not
;;    control. When Bash is started non-interactively, it looks for =BASH_ENV= in
;;    the environment, expands its value if it appears there, and uses the
;;    expanded value as the name of a file to read and execute. As such, we set
;;    that environment value to our startup file here.
(when (eq system-type 'darwin) (setenv "BASH_ENV" "$HOME/.bashrc"))

;; For this to work, make sure EDITOR and/or VISUAL are set to `emacsclient'.
(use-package server
    :config
  (unless (server-running-p) (server-start)))

(use-package nested-dir-local
    :disabled t
    :straight (:repo "git@github.com:jinnovation/nested-dir-locals.el.git"))

(defvar jjin/help-modes '(helpful-mode
                          help-mode
                          Man-mode
                          woman-mode
                          Info-mode
                          godoc-mode))

(defun jjin/help-buffer-p (buf &optional act)
  "Check if BUF is a 'help' buffer.

ACT is a buffer action that enables use in
`display-buffer-alist'."
  (member (with-current-buffer buf major-mode) jjin/help-modes))

(setq switch-to-buffer-in-dedicated-window 'pop)
(setq switch-to-buffer-obey-display-actions t)
(setq window-sides-slots '(1 1 1 1))
(setq window-sides-vertical t)

(add-to-list 'display-buffer-alist
             `(jjin/help-buffer-p
               (display-buffer--maybe-same-window
                display-buffer-reuse-window
                display-buffer-reuse-mode-window)
               (mode . ,jjin/help-modes)
               (inhibit-same-window . nil)))

(add-to-list 'tab-bar-format 'tab-bar-format-align-right t)
(add-to-list 'tab-bar-format 'tab-bar-format-global t)

(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

;; keybindings

(define-prefix-command 'jjin-vc-map)
(bind-key "C-c v" 'jjin-vc-map)

(bind-keys :map global-map
           ("C-x k"              . jjin-kill-current-buffer)
           ("C-x m"              . execute-extended-command)
           ("RET"                . newline-and-indent))

(unbind-key "<menu>")
(unbind-key "M-`")
(unbind-key "C-c C-w")
(unbind-key "C-x C-n")      ; set-goal-column
(unbind-key "s-t")          ; ns-popup-font-panel
(unbind-key "s-w")          ; delete-frame

(unbind-key "<f10>")
(unbind-key "<f11>")
(unbind-key "M-<f10>")
(unbind-key "<escape> <f10>")

(bind-keys :map global-map
           ("<s-backspace>" . backward-kill-word)
           ("s-s" . save-buffer)
           ("s-b" . switch-to-buffer)
           ("s-`" . recompile))

(use-package hydra
    :commands defhydra
    :straight t)

(use-package pretty-hydra
    :straight t
    :after all-the-icons
    :config
    (pretty-hydra-define jjin-hydra-exec
        (:title (with-material "apps" "Apps" 1 -0.05))
      ("General" ()))

    (defvar jjin/bottom-window-default-height 0.3
      "Default height ratio for bottom side window.")

    (defvar jjin/bottom-window-enlarged-height 0.8
      "Enlarged height ratio for bottom side window.")

    (defvar jjin/bottom-window-enlarged-p nil
      "Track whether bottom window is currently enlarged.")

    (defun jjin/toggle-bottom-window-enlarge ()
      "Toggle bottom side window between default and enlarged sizes."
      (interactive)
      (if-let ((bottom-window (get-window-with-predicate
                               (lambda (win)
                                 (eq (window-parameter win 'window-side) 'bottom)))))
          (let* ((target-height (if jjin/bottom-window-enlarged-p
                                    jjin/bottom-window-default-height
                                  jjin/bottom-window-enlarged-height))
                 (target-lines (floor (* (frame-height) target-height)))
                 (delta (- target-lines (window-height bottom-window))))
            (window-resize bottom-window delta)
            (setq jjin/bottom-window-enlarged-p (not jjin/bottom-window-enlarged-p)))
        (message "No bottom side window found")))

    (pretty-hydra-define jjin-hydra-window
        (:title (with-octicon "browser" "Windows" 1 -0.05))

      ("Move"
       (("h" windmove-left "move left")
        ("l" windmove-right "move right")
        ("j" windmove-down "move down")
        ("k" windmove-up "move up"))
       "Split"
       (("H" jjin-move-splitter-left "move splitter left")
        ("L" jjin-move-splitter-right "move splitter right")
        ("J" jjin-move-splitter-down "move splitter down")
        ("K" jjin-move-splitter-up "move splitter up")
        ("|" jjin-window-toggle-split-direction "toggle split")
        ("s" split-window-below "split window (below)")
        ("v" split-window-right "split window (right)"))

       "Side Windows"
       (("`" window-toggle-side-windows "toggle")
        ("e" jjin/toggle-bottom-window-enlarge "enlarge bottom" :toggle jjin/bottom-window-enlarged-p))

       "Other"
       (("q" delete-window "delete window")
        ("Q" kill-buffer-and-window "kill buffer, delete window")
        ("b" balance-windows "balance")
        ("S" ace-swap-window "swap places with...")
        (";" ace-window "select window" :exit t))))

    (pretty-hydra-define jjin-buffer-hydra
        (:title (with-material "code" "Buffers" 1 -0.005) :color teal)
      ("Name"
       (("r" rename-buffer "Rename"))))

    (bind-key "C-c b" 'jjin-buffer-hydra/body)

    (bind-key "s-w" 'jjin-hydra-window/body)
    (bind-key "s-<escape>" 'jjin-hydra-exec/body))

(use-package major-mode-hydra
    :straight t
    :bind
    ("s-SPC" . major-mode-hydra))

;; Virtualenv-aware shim for finding the right Python executables. Useful for
;; language server functionality etc.
(use-package pet
    :straight t
    :after (exec-path-from-shell)
    :config
    (add-hook 'python-base-mode-hook (lambda ()
                                       (setq-local python-shell-interpreter (pet-executable-find "python")
                                                   python-shell-virtualenv-root (pet-virtualenv-root))
                                       (pet-eglot-setup))))
;; (add-hook 'python-base-mode-hook 'pet-mode -10))

(use-package breadcrumb
    :straight t
    :config
    (breadcrumb-mode))

(use-package eglot
    :hook ((tsx-ts-mode . eglot-ensure)
           (python-ts-mode . eglot-ensure)
           (typescript-ts-mode . eglot-ensure))
    :ensure-system-package (typescript-language-server gopls)
    :after (pet)
    :config

    ;; TODO: Add `eglot-rename' to embark for 'identifier

    (defun jjin/eglot-organize-buffer-imports ()
      (apply #'eglot-code-action-organize-imports (eglot--region-bounds)))

    (defcustom jjin/eglot-format-ignore-files (list)
      "Files to suppress LSP-based auto-format for.")

    (defun jjin/eglot-format-buffer-with-ignore ()
      "Only apply `eglot-format-buffer' if current file name is not in `jjin/eglot-format-ignore-files'."
      (if (not (member buffer-file-name jjin/eglot-format-ignore-files))
          (eglot-format-buffer)
        (message "Skipping buffer!")))

    (defun jjin/setup-eglot-hooks ()
      (add-hook 'before-save-hook #'jjin/eglot-organize-buffer-imports nil t)
      (add-hook 'before-save-hook #'jjin/eglot-format-buffer-with-ignore nil t))

    (add-hook 'eglot-managed-mode-hook #'jjin/setup-eglot-hooks))

(use-package lsp-mode
    :disabled t
    :straight t
    ;; (terraform-mode . lsp-deferred)
    ;; (yaml-mode . lsp-deferred))
    ;; TODO:
    ;; For Python, would like the following installed:
    ;;   - python-lsp-server
    ;;   - python-lsp-black
    ;;   - pylsp-mypy
    ;;   - pyls-isort
    :custom
    (lsp-ui-sideline-enable nil)         ; Disable until the weird text
                                        ; overflow issue is fixed
    (lsp-signature-render-documentation nil)
    (lsp-pyls-configuration-sources ["flake8"])
    (lsp-pyls-plugins-pycodestyle-enabled nil)
    (lsp-pylsp-server-command '("pylsp"))
    (lsp-pyls-server-command '("pylsp"))
    (lsp-enable-snippet nil)
    (lsp-log-io t)
    (lsp-document-sync-method nil)
    (lsp-print-performance t)
    (lsp-before-save-edits nil)
    (lsp-signature-render-documentation t)
    (lsp-pyls-plugins-pydocstyle-enabled t)
    (lsp-pyls-plugins-pyflakes-enabled nil)
    (lsp-pyls-plugins-flake8-enabled t)
    (lsp-pyls-plugins-pydocstyle-convention "pep257")
    (lsp-pyls-plugins-mccabe-enabled nil)
    (lsp-go-codelenses nil)
    (lsp-go-use-gofumpt t)
    :init
    ;; (setq lsp-document-sync-method 'lsp--sync-incremental)
    (add-hook 'hack-local-variables-hook
              (lambda () (when (derived-mode-p 'python-mode) (lsp))))
    :config
    (when (-contains? (lsp-session-folders (lsp-session)) (f-expand "~"))
      (warn "LSP workspace folders list contains home dir; this can be problematic, consider removing."))

    (lsp-register-custom-settings '(("gopls.completeUnimported" t t)
                                    ("gopls.staticcheck" t t)
                                    ("pyls.plugins.pyls_mypy.enabled" t t)
                                    ("pyls.plugins.pyls_mypy.live_mode" nil t)))

    ;; FIXME: Oncen gopackagesdriver is available, set up here to cooperate w/
    ;; Bazel projects.
    (defun lsp-go-install-save-hooks ()
      (add-hook 'before-save-hook #'lsp-format-buffer t t)
      (add-hook 'before-save-hook #'lsp-organize-imports t t))
    (add-hook 'go-mode-hook #'lsp-go-install-save-hooks))

(use-package bazel-mode
    :disabled t
    :straight (emacs-bazel-mode :type git :host github :repo "bazelbuild/emacs-bazel-mode"))

(setq c-block-comment-prefix "* ")

(c-set-offset 'arglist-intro '+)
(c-set-offset 'arglist-close 0)

(use-package editorconfig
    :straight t
    :config
    (editorconfig-mode 1))

(require 'go-ts-mode)

(use-package lsp-ivy
    :disabled t
    :straight t
    :after (ivy lsp-mode))

(use-package lsp-ui
    :disabled t
    :straight t
    :after lsp-mode
    :custom
    (lsp-ui-doc-enable nil "doc display on hover uses posframes (don't work well w/ macos fullscreen)")
    (lsp-ui-sideline-show-hover t))

(add-to-list 'auto-mode-alist '("emacs$" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("Cask" . emacs-lisp-mode))

(defvaralias 'js-indent-level 'tab-width)

(use-package js2-mode
    :mode (("\\.js$" . js2-mode)
           ("\\.jsx$" . js2-jsx-mode))
    :straight t)

(use-package json-mode
    :straight t)

(add-to-list 'auto-mode-alist '("zshrc$" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.zsh$" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.bats$" . sh-mode))

(use-package graphviz-dot-mode
    :straight t)

(use-package mermaid-mode
    :straight t
    :mode (("\\.mmd$" . mermaid-mode)))

(use-package haskell-mode
    :disabled t
    :config
    (add-hook 'haskell-mode-hook 'turn-on-haskell-indent))

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines t)))

(use-package protobuf-mode
    :straight t)

(add-to-list 'major-mode-remap-alist
             '(python-mode . python-ts-mode))

(setq python-fill-docstring-style 'pep-257)

(setq python-indent-def-block-scale 1)

(use-package pyvenv
    :straight t
    :init
    (setenv "WORKON_HOME" "~/.pyenv/versions"))

(use-package elisp-autofmt
    :straight t
    :disabled t
    :commands (elisp-autofmt-mode elisp-autofmt-buffer))

(use-package buttercup
    :straight t)

(use-package markdown-mode
    :straight t
    :mode "\\.md$"
    :bind (:map markdown-mode-map
                ("M-]" . markdown-demote)
                ("M-[" . markdown-promote))
    :custom
    (markdown-asymmetric-header t)
    :config
    (add-hook 'markdown-mode-hook 'auto-fill-mode))

(defun jjin/treesit-install-grammar-maybe (lang)
  "Installs Tree-sitter grammar for LANG if and only if it is not already
  installed and available."
  (unless (treesit-language-available-p lang)
    (treesit-install-language-grammar lang)))

(use-package treesit
    :custom
  (treesit-language-source-alist
   '((tsx "https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "tsx/src")
     (go "https://github.com/tree-sitter/tree-sitter-go" "v0.20.0" "src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml" "v0.5.0" "src")
     (gomod "https://github.com/camdencheek/tree-sitter-go-mod" "v1.0.2" "src")
     (python "https://github.com/tree-sitter/tree-sitter-python" "v0.23.6" "src")
     (rust "https://github.com/tree-sitter/tree-sitter-rust" "v0.23.3" "src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "typescript/src")
     (typst "https://github.com/uben0/tree-sitter-typst" "v0.10-2" "src")))
  :config
  (mapc #'jjin/treesit-install-grammar-maybe (mapcar #'car treesit-language-source-alist)))

(use-package rust-ts-mode)

(use-package typescript-ts-mode)

(use-package typst-ts-mode
    :after (treesit major-mode-hydra)
    :straight (typst-ts-mode :type git :host sourcehut :repo "meow_king/typst-ts-mode" :files (:defaults "*.el"))
    :config
    (defun jjin/run-typstfmt-maybe ()
      "Runs typstfmt on the current buffer if it is installed."
      (interactive)
      (when (and (executable-find "typstfmt") (buffer-file-name))
        (shell-command (format "typstfmt %s" (buffer-file-name)))))

    ;; FIXME: For some reason doesn't work?
    ;; (defun jjin/typst-install-save-hooks ()
    ;;   (add-hook 'before-save-hook #'jjin/run-typstfmt-maybe t t))

    ;; (add-hook 'typst-ts-mode-hook #'jjin/typst-install-save-hooks)

    (major-mode-hydra-define typst-ts-mode
        (:title "Typst: Commands")
      ("Compilation"
       (("C" typst-ts-mode-compile "Compile")
        ("c" typst-ts-mode-compile-and-preview "Compile and preview")
        ;; FIXME: Display whether currently on or off
        ("w" typst-ts-mode-watch-toggle "Watch toggle"))
       "Format"
       (("f" jjin/run-typstfmt-maybe "Auto-format")))))

(use-package yaml-ts-mode)

(use-package jinja2-mode
    :straight t)

(use-package ace-link
    :straight t
    :after org ;; fn ace-link-org loads org-mode
    :commands (ace-link-eww ace-link-setup-default)
    :init (ace-link-setup-default))

(use-package ace-window
    :commands ace-window
    :straight t
    :init
    (setq aw-keys '(?a ?r ?s ?t ?q ?w ?f ?p))

    :config
    ;; technically should be able to use mu4e~update-name but for whatever reason
    ;; the mu4e update index function uses the hardcoded string w/ space padding.
    (add-to-list 'aw-ignored-buffers " *mu4e-update*"))

(use-package conf-mode
    :mode
  (;; systemd
   ("\\.service\\'"     . conf-unix-mode)
   ("\\.timer\\'"      . conf-unix-mode)
   ("\\.target\\'"     . conf-unix-mode)
   ("\\.mount\\'"      . conf-unix-mode)
   ("\\.automount\\'"  . conf-unix-mode)
   ("\\.slice\\'"      . conf-unix-mode)
   ("\\.socket\\'"     . conf-unix-mode)
   ("\\.path\\'"       . conf-unix-mode)

   ;; general
   ("conf\\(ig\\)?$"   . conf-mode)
   ("rc\\(_local\\)?$" . conf-mode)))

(use-package corfu
    :straight t
    :custom
    (corfu-auto t)
    (corfu-auto-prefix 2)
    (corfu-cycle t)
    :config
    (global-corfu-mode)
    (corfu-echo-mode)
    (corfu-history-mode))

(setq dired-listing-switches "-alh")

(use-package dired-open
    :straight t
    :after dash
    :init
    (if-let* ((handler-vid (-first 'executable-find
                                   (plist-get
                                    (alist-get system-type jjin-ext-file-handlers)
                                    :video)))
              (path (executable-find handler-vid)))
        (setq dired-open-extensions `(("mp4" . ,(executable-find handler-vid))
                                      ("avi" . ,(executable-find handler-vid))))))

(use-package dirvish
    :straight t
    :init
    (pretty-hydra-define+ jjin-hydra-exec nil
      ("General" (("d" dirvish "dirvish" :exit t))))

    :config
    (dirvish-override-dired-mode))

(use-package doc-view
    :init
  (setq doc-view-resolution 200))

(use-package docker
    :straight t)

;; TODO: Set up native dockerfile-ts-mode
(use-package dockerfile-mode
    :straight t
    :mode (("Dockerfile.*$" . dockerfile-mode)))

(use-package ediff
    :custom
  (ediff-window-setup-function 'ediff-setup-windows-plain))

(use-package exec-path-from-shell
    :straight t
    :custom
    (exec-path-from-shell-variables '("PATH"
                                      "MANPATH"
                                      "GOPATH"
                                      "GOROOT"
                                      "GO111MODULE"
                                      "JENKINS_USER"
                                      "JENKINS_API_TOKEN"))
    ;; (exec-path-from-shell-shell-name "zsh")
    (exec-path-from-shell-shell-name shell-file-name)
    :config
    (exec-path-from-shell-initialize))

(use-package vterm
    ;; :ensure-system-package cmake
    :straight t
    :bind (:map global-map
                ("s-v" . vterm))
    :hook
    (vterm-mode . goto-address-mode)
    :custom
    (vterm-shell "/bin/zsh")
    (vterm-kill-buffer-on-exit t)

    :init
    (add-to-list 'display-buffer-alist
                 `("\\*vterm" (display-buffer-reuse-mode-window display-buffer-in-side-window)
                              (side . bottom)
                              (window-parameters . ((no-delete-other-windows . t)))
                              (window . root)
                              (window-height . ,jjin/bottom-window-default-height)))

    :config
    (with-eval-after-load 'evil
      (add-to-list 'evil-emacs-state-modes 'vterm-mode)))

(use-package evil
    :straight t
    :defines evil-normal-state-map
    :custom
    (evil-esc-delay 0)
    :config
    (evil-set-leader '(normal motion) (kbd "SPC"))
    (evil-define-key 'normal 'global (kbd "<leader>s") 'save-buffer)

    (mapc (lambda (m) (add-to-list 'evil-emacs-state-modes m t))
          '(eshell-mode
            calendar-mode
            diff-mode

            finder-mode
            info-mode

            eww-mode
            eww-bookmark-mode

            dired-mode
            image-mode
            image-dired-thumbnail-mode
            image-dired-display-image-mode

            git-rebase-mode

            help-mode

            sql-interactive-mode
            org-capture-mode))
    ;; FIXME: what's the diff between set-initial-state and adding to list directly?
    (evil-set-initial-state 'term-mode 'emacs)

    (bind-keys :map evil-emacs-state-map
               ("<escape>" . evil-execute-in-normal-state))

    (evil-mode 1))

(use-package evil-numbers
    :after evil
    :straight t
    :config
    (bind-keys :map evil-normal-state-map
               ("C-a"   . evil-numbers/inc-at-pt)
               ("C-c -" . evil-numbers/dec-at-pt)))

(use-package evil-search-highlight-persist
    :after evil
    :straight t
    :config
    (bind-key "C-l" 'evil-search-highlight-persist-remove-all
              evil-normal-state-map)
    (global-evil-search-highlight-persist t)

    (set-face-attribute
     'evil-search-highlight-persist-highlight-face
     nil
     :background (face-attribute 'match :background)))

(use-package evil-surround
    :after evil
    :straight t
    :config
    (global-evil-surround-mode 1))

(use-package evil-nerd-commenter
    :after evil
    :straight t
    :pretty-hydra
    ((:color teal)
     ("Commenting"
      (("i" evilnc-comment-or-uncomment-lines "Comment/Uncomment Lines")
       ("c" evilnc-copy-and-comment-lines "Copy and comment"))))
    :bind ("C-c c" . evil-nerd-commenter-hydra/body)
    :config
    (evil-define-key '(normal motion) 'global (kbd "<leader>c") 'evil-nerd-commenter-hydra/body))

(use-package flycheck
    :straight t
    :defines flycheck-mode-hook
    :config
    (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package gif-screencast
    :straight t
    :custom
    (gif-screencast-args '("-x"))
    ;; I have no idea why this value works but it does so whatever
    (gif-screencast-scale-factor 2.0)
    (gif-screencast-cropping-program "mogrify")
    (gif-screencast-capture-format "ppm"))

(bind-keys :map jjin-vc-map
           ("g" . vc-git-grep))

(setq vc-handled-backends '(git))

(use-package git-commit-mode
    :commands git-commit-mode)

(use-package gitconfig-mode
    :disabled t
    :straight t
    :mode "gitconfig")

(use-package gitignore-mode
    :disabled t
    :straight t
    :mode "gitignore")

(defun jjin/magit-fetch-from-origin-master ()
  (interactive)
  (magit-git-fetch "origin" "master"))

(defun jjin/magit-checkout-previous-branch ()
  (interactive)
  (if-let ((p (magit-get-previous-branch)))
      (magit-checkout p)
    (error "No previous branch")))

;; TODO: Magit has migrated to using transient, so all commented sections will
;; eventually need to be updated or removed.

(use-package transient
    :straight (:source melpa)
    :init
    (setq transient-show-common-commands nil))

(use-package git-modes
    :straight t)

;; TODO: magit "sidebar" functionality
;; - dedicated-window: https://www.masteringemacs.org/article/demystifying-emacs-window-manager
(use-package magit
    :straight t
    :custom
    (magit-log-arguments '("--graph" "--decorate" "--color"))
    (magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1)
    (magit-status-initial-section '(((unstaged) (status))
                                    ((staged) (status))))
    :hook
    (magit-revision-mode . goto-address-mode)
    :init
    ;; On status buffer init, jump to either unstaged changes or staged changes,
    ;; if present

    (add-to-list
     'safe-local-variable-values
     '(magit-status-headers-hook . (list
                                    magit-insert-error-header
                                    magit-insert-diff-filter-header
                                    magit-insert-head-branch-header
                                    magit-insert-upstream-branch-header
                                    magit-insert-push-branch-header)))

    (defun jjin/magit-status-at (dir)
      "Open Magit status buffer for project at root DIR."
      (magit-status dir))

    (defun jjin/magit-buffer-p (buf &optional act)
      (with-current-buffer buf
        (derived-mode-p 'magit-mode)))

    ;; FIXME: for modes that are not status buffer:
    ;; - if something magit-mode-y already in the side indow, open it as a "regular" window
    ;; - otherwise, open it in side window
    (add-to-list 'display-buffer-alist
                 '(jjin/magit-buffer-p
                   (display-buffer-reuse-window display-buffer-in-side-window)
                   (side . right)
                   (window-parameters . ((no-delete-other-windows . t)))
                   (window-width . 100)))

    :bind (:map jjin-vc-map
                ("!" . magit-git-command-topdir)
                ("C" . magit-branch-and-checkout)
                ("F" . magit-pull)
                ("P" . magit-push)
                ("b" . magit-blame)
                ("c" . magit-checkout)
                ("d" . magit-diff)
                ("f" . magit-fetch)
                ("l" . magit-log)
                ("m" . magit-merge)
                ("v" . magit-status)
                ("z" . magit-stash)
                :map magit-mode-map
                ("X" . magit-reset-hard))

    :commands (magit-status)
    :config
    (with-eval-after-load 'git-rebase
      (bind-keys :map git-rebase-mode-map ("u" . git-rebase-undo)))

    ;; removes 1.4.0 warning in arguably cleaner way
    (remove-hook 'after-init-hook 'magit-maybe-show-setup-instructions)

    (defadvice magit-blame-mode (after switch-to-emacs-state activate)
      (if magit-blame-mode
          (evil-emacs-state 1)
        (evil-normal-state 1)))

    (with-eval-after-load 'evil
      (add-to-list 'evil-emacs-state-modes 'magit-popup-mode))

    (transient-append-suffix 'magit-commit 'magit-commit:--reuse-message
      '("-m"
        "Attach message"
        "--message="
        :prompt "Message"
        :reader magit-read-string))

    (defun jjin/magit-diff-upstream (&optional args files)
      (interactive (magit-diff-arguments))
      ;; FIXME: Use of HEAD here causes the diff buffer to reload when switching
      ;; branches. Fetch the explicit branch ref to keep the original diff
      ;; resilient.
      (magit-diff-range "@{u}..HEAD" args))

    (transient-insert-suffix 'magit-diff 'magit-show-commit
      '("U" "Diff upstream" jjin/magit-diff-upstream))

    (defun jjin/magit-find-file-from-upstream (file)
      "Same behavior as `magit-find-file', but specifically for the
 upstream branch."
      (interactive
       (list (magit-read-file-from-rev (magit-get-upstream-branch) "Find file")))
      (magit-find-file (magit-get-upstream-branch) file))

    (transient-append-suffix 'magit-fetch 'magit-fetch-all
      '("U" "origin/master" jjin/magit-fetch-from-origin-master))

    ;; Suppress diff display when the commit in question is a merge
    ;; (advice-add 'magit-commit-diff :before-until 'magit-merge-in-progress-p)
    )

;; (plist-put magit-merge-popup :actions (cons "Actions" (plist-get magit-merge-popup :actions)))
;; (plist-put magit-merge-popup
;;            :actions
;;            (cons '(?U "Upstream" (lambda (ignored &optional args)
;;                                    (interactive (magit-diff-arguments))
;;                                    (magit-merge "@{u}" args)))
;;                  (plist-get magit-merge-popup :actions)))

;; (plist-put
;;  magit-merge-popup
;;  :actions
;;  (cons
;;   (lambda ()
;;     (concat (propertize "Merge into " 'face 'magit-popup-heading)
;;             (propertize (or (magit-get-current-branch) "HEAD") 'face 'magit-branch-local)
;;             (propertize " from" 'face 'magit-popup-heading)))
;;   (plist-get magit-merge-popup :actions)))

;; (magit-define-popup-action 'magit-branch-popup
;;   ?P
;;   (lambda ()
;;     (if-let ((p (magit-get-previous-branch)))
;;         "Checkout previous branch"
;;       "No previous branch"))
;;   'jjin/magit-checkout-previous-branch))

(use-package forge
    :straight t
    :after (magit transient)
    :config
    ;; (transient-append-suffix forge-dispatch 'forge-visit-pullreq )

    ;; To add tokens to keychain:
    ;;
    ;; security add-internet-password -a "username^forge" -r "htps" -s "api.github.com"

    ;; (magit-add-section-hook 'magit-status-sections-hook 'forge-insert-authored-pullreqs 'forge-insert-pullreqs nil)
    ;; (magit-add-section-hook 'magit-status-sections-hook 'forge-insert-requested-reviews 'forge-insert-pullreqs nil)
    ;; (magit-add-section-hook 'magit-status-sections-hook 'forge-insert-assigned-issues 'forge-insert-issues nil)
    ;; (magit-add-section-hook 'magit-status-sections-hook 'forge-insert-authored-issues 'forge-insert-issues nil))
    )

(use-package helpful
    :straight t
    :bind (("C-h f" . #'helpful-callable)
           ("C-h v" . #'helpful-variable)
           ("C-h k" . #'helpful-key)
           :map helpful-mode-map
           ("Q"     . #'helpful-kill-buffers)
           ("g"     . #'helpful-update))
    :init
    (with-eval-after-load 'projectile
      (add-to-list 'projectile-globally-ignored-modes "helpful-mode"))
    (with-eval-after-load 'evil
      (add-to-list 'evil-motion-state-modes 'helpful-mode)))

(use-package highlight-indent-guides
    :straight t
    :custom
    (highlight-indent-guides-method 'character))

(use-package vertico
    :straight (:files (:defaults "extensions/*"))
    :custom
    (vertico-grid-min-columns 4)
    (vertico-multiform-commands '((org-roam-node-find grid)))
    :config
    (vertico-mode 1)
    (vertico-multiform-mode 1))

(use-package vertico-prescient
    :straight t
    :after vertico
    :config
    (prescient-persist-mode 1)
    (vertico-prescient-mode 1))

(use-package orderless
    :straight t
    :custom (completion-styles '(orderless)))

(use-package marginalia
    :straight t
    :config
    (marginalia-mode)
    (add-to-list 'marginalia-prompt-categories '("\\<[Pp]roject\\>" . jjin/project)))

(use-package consult
    :straight t
    :demand t
    :after (embark-consult)
    :bind
    (([remap isearch-forward] . consult-line)
     ([remap switch-to-buffer] . consult-buffer))
    :config
    (with-eval-after-load 'projectile
      (bind-key [remap projectile-ripgrep] 'consult-ripgrep)))

(use-package embark
    :straight t
    :demand t
    :after (embark-consult)
    :bind
    (("C-;" . embark-act))
    :config
    (defvar-keymap jjin/project-actions
      :parent embark-general-map
      :doc "Keymap for actions on projects."
      "v" #'jjin/projectile-vterm-at
      "g" #'jjin/magit-status-at)

    (add-to-list 'embark-keymap-alist '(jjin/project . jjin/project-actions)))

(use-package embark-consult
    :straight t)

(use-package consult-project-extra
    :straight t
    :bind (:map projectile-command-map ("<SPC>" . consult-project-extra-find)))

(use-package consult-projectile
    :disabled t
    :after (consult projectile)
    :straight (consult-projectile
               :type git
               :host gitlab
               :repo "OlMon/consult-projectile"
               :branch "master")
    :bind (:map projectile-command-map
                ("<SPC>" . consult-projectile))
    :config
    (with-eval-after-load 'projectile
      (setq consult-project-root-function #'projectile-project-root)))

;; =mu4e= has a notion of "marks" that it uses to represent actions on messages
;; -- refiling to specific directories, trashing, etc. These marks can
;; furthermore be performed at the thread level to, for instance, archive an
;; entire thread in one go.
;;
;; Oftentimes, I find myself wanting to archive only the very first email in a
;; given thread, and trashing the rest. With vanilla =mu4e=, my best bet to do
;; so is to mark an entire thread first with "delete," then to manually mark the
;; thread head for archiving. Obviously, I'd like to perform this workflow with
;; a single "meta-mark."
(defun jjin/mu4e-msg-thread-head-p (&optional msg)
  "Given an mu4e message s-expression `msg', return t if the
message is the absolute head of a thread, and nil otherwise. If
`msg' is not provided, use the current message at point."
  (let* ((_msg (or msg (mu4e-message-at-point)))
         (thread (plist-get _msg :thread))
         (level (plist-get thread :level)))
    (zerop level)))

;; FIXME: This mark doesn't co-operate well when trying to apply to subthread.
(defvar jjin/mu4e-mark-refile-first-delete-rest
  '(refile-first
    :char ("R" . " ")
    :prompt "Refile head, delete rest"
    :dyn-target
    (lambda (target msg)
      (let ((f-folder-get
             (if (jjin/mu4e-msg-thread-head-p msg)
                 'mu4e-get-refile-folder
               'mu4e-get-trash-folder)))
        (funcall f-folder-get msg)))
    :action
    (lambda (docid msg target)
      (let* ((key-mark
              (if (jjin/mu4e-msg-thread-head-p msg)
                  'refile
                'trash))
             (mark (alist-get key-mark mu4e-marks))
             (f-action (plist-get mark :action)))
        (funcall f-action docid msg target))))
  "An mu4e mark action that, when applied to messages in a
thread, will archive the head of the thread and trash the rest.")

(use-package mu4e
    :disabled t
    :ensure-system-package mu
    :custom
    (mail-user-agent 'mu4e-user-agent)
    (mu4e-view-show-addresses t)
    (mu4e-compose-context-policy 'ask)
    (mu4e-update-interval nil)
    (mu4e-headers-skip-duplicates t)
    (mu4e-view-show-images t)
    (mu4e-compose-signature-auto-include nil)
    (mu4e-html2text-command 'mu4e-shr2text)
    ;; don't keep message buffers around
    (message-kill-buffer-on-exit t)
    (mu4e-context-policy 'pick-first)
    (mu4e-headers-include-related nil)
    (mu4e-view-use-gnus nil)
    (mu4e-change-filenames-when-moving t)
    (mu4e-split-view 'single-window)
    (mu4e-compose-format-flowed t)
    (message-send-mail-function 'smtpmail-send-it)
    (mu4e-bookmarks '((:query "(maildir:\"/personal/INBOX\" OR maildir:\"/work/INBOX\") flag:unread"
                       :name "Unread INBOXes"
                       :key ?U)))
    :commands (mu4e mu4e-update-mail-and-index)
    :init
    (defhydra jjin-hydra-mu4e (:exit t)
      "Auxiliary commands for mu4e"
      ("m" mu4e-update-mail-and-index "update"))

    (setq mu4e-completing-read-function 'completing-read)

    (major-mode-hydra-define mu4e-headers-mode
        (:title "Mail")
      ("Indexing"
       (("U" mu4e-update-mail-and-index "Update mail and index")
        ("u" mu4e-update-index "Update index"))))

    (pretty-hydra-define+ jjin-hydra-exec nil
      ("General" (("m" mu4e "mu4e" :exit t))))

    :config
    (with-eval-after-load 'ivy
      (setq mu4e-completing-read-function 'ivy-completing-read))

    ;; don't save message to Sent Messages for GMail accounts; Gmail/IMAP takes
    ;; care of this
    (setq mu4e-sent-messages-behavior
          (lambda ()
            (if (string= (message-sendmail-envelope-from) "jonathan.jin@hinge.co")
                'delete
              'sent)))

    (setq mu4e-maildir-shortcuts
          '(("/personal/INBOX"   . ?i)
            ("/personal/Sent"    . ?s)
            ("/personal/Drafts"  . ?d)
            ("/personal/Archive" . ?a)
            ("/work/INBOX" . ?I)
            ("/work/sent" . ?S)
            ("/work/drafts" . ?D)
            ("/work/archive" . ?A)))

    (setq mu4e-get-mail-command (if (not (executable-find "mbsync")) "true" "mbsync -Va"))

    (setq shr-use-colors nil)
    (setq shr-use-fonts nil)

    (add-hook 'mu4e-view-mode-hook 'visual-line-mode)

    (use-package gnus-dired
        :config
      ;; make the `gnus-dired-mail-buffers' function also work on message-mode derived
      ;; modes, such as mu4e-compose-mode
      (defun gnus-dired-mail-buffers ()
        (let (buffers)
          (save-current-buffer
            (dolist (buffer (buffer-list t))
              (set-buffer buffer)
              (when (and (derived-mode-p 'message-mode)
                         (null message-sent-message-via))
                (push (buffer-name buffer) buffers))))
          (nreverse buffers)))

      (setq gnus-dired-mail-mode 'mu4e-user-agent)
      (add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode))

    (set-face-attribute 'mu4e-header-highlight-face nil :underline nil)

    (add-to-list 'mu4e-view-actions
                 '("View in browser" . mu4e-action-view-in-browser)
                 t)
    (add-to-list 'mu4e-view-actions
                 '("Capture message" . mu4e-action-capture-message)
                 t)

    (defun mu4e-message-maildir-matches (msg rx)
      (when rx
        (if (listp rx)
            ;; if rx is a list, try each one for a match
            (or (mu4e-message-maildir-matches msg (car rx))
                (mu4e-message-maildir-matches msg (cdr rx)))
          ;; not a list, check rx
          (string-match rx (mu4e-message-field msg :maildir)))))

    (setq mu4e-contexts
          `(,(make-mu4e-context
              :name "personal"
              :match-func
              (lambda (msg)
                (when msg
                  (or
                   (mu4e-message-maildir-matches msg "^/personal")
                   (mu4e-message-contact-field-matches msg :to "jjin082693@gmail.com")
                   (mu4e-message-contact-field-matches msg :to "me@jonathanj.in"))))
              :vars `((user-mail-address . "me@jonathanj.in")
                      (mu4e-compose-signature . ,(concat "Jonathan Jin"))

                      (smtpmail-smtp-user . "me@jonathanj.in")
                      (smtpmail-smtp-server . "smtp.fastmail.com")
                      (smtpmail-smtp-service . 465)
                      (smtpmail-stream-type . ssl)

                      (user-full-name . "Jonathan Jin")
                      (mu4e-sent-folder . "/personal/Sent")
                      (mu4e-trash-folder . "/personal/Trash")
                      (mu4e-drafts-folder . "/personal/Drafts")
                      (mu4e-refile-folder . "/personal/Archive")))

             ,(make-mu4e-context
               :name "work"
               :match-func
               (lambda (msg)
                 (when msg
                   (or
                    (mu4e-message-maildir-matches msg "^/work")
                    (mu4e-message-contact-field-matches msg :to "jonathan.jin@hinge.co"))))
               :vars `((user-mail-address . "jonathan.jin@hinge.co")
                       (mu4e-compose-signature . ,(concat "Jonathan Jin"))

                       (smtpmail-smtp-user . "jonathan.jin@hinge.co")
                       (smtpmail-smtp-server . "smtp.gmail.com")
                       (smtpmail-smtp-service . 587)
                       (smtpmail-stream-type . nil)

                       (user-full-name . "Jonathan Jin")
                       (mu4e-sent-folder . "/work/sent")
                       (mu4e-trash-folder . "/work/trash")
                       (mu4e-drafts-folder . "/work/drafts")
                       (mu4e-refile-folder . "/work/Archive")))))

    ;; Sets `mu4e-user-mail-address-list' to the concatenation of all
    ;; `user-mail-address' values for all contexts. If you have other mail
    ;; addresses as well, you'll need to add those manually.
    (setq mu4e-user-mail-address-list
          (delq nil
                (mapcar (lambda (context)
                          (when (mu4e-context-vars context)
                            (cdr (assq 'user-mail-address (mu4e-context-vars context)))))
                        mu4e-contexts)))

    (add-to-list 'mu4e-marks jjin/mu4e-mark-refile-first-delete-rest)

    ;; (setq projectile-globally-ignored-modes (remove-if 'symbolp projectile-globally-ignored-modes ))
    (with-eval-after-load 'projectile
      (mapc
       (lambda (mode)
         (add-to-list 'projectile-globally-ignored-modes (symbol-name mode)))
       '(mu4e-headers-mode
         mu4e~update-mail-mode
         mu4e~main-toggle-mail-sending-mode
         mu4e-main-mode
         mu4e-view-mode
         mu4e~view-define-mode
         mu4e-compose-mode
         mu4e-org-mode))))

;; NB(@jinnovation): Copied wholesale from org-compat.el. This *should* be
;; accessible, but for some reason is not, resulting in (void-function
;; org-file-name-concat) when loading up org-mode buffers.
;;
;; TODO: Investigate and remove sometime.
(if (fboundp 'file-name-concat)
    (defalias 'org-file-name-concat #'file-name-concat)
  (defun org-file-name-concat (directory &rest components)
    "Append COMPONENTS to DIRECTORY and return the resulting string.

Elements in COMPONENTS must be a string or nil.
DIRECTORY or the non-final elements in COMPONENTS may or may not end
with a slash -- if they don't end with a slash, a slash will be
inserted before contatenating."
    (save-match-data
      (mapconcat
       #'identity
       (delq nil
             (mapcar
              (lambda (str)
                (when (and str (not (seq-empty-p str))
                           (string-match "\\(.+\\)/?" str))
                  (match-string 1 str)))
              (cons directory components)))
       "/"))))


(use-package org
    :bind (:map org-mode-map
                ("RET" . org-return-indent)
                ("M-p" . outline-previous-visible-heading)
                ("M-n" . outline-next-visible-heading)
                ("s-t" . org-todo)
                ("M-[" . org-metaleft)
                ("M-]" . org-metaright)
                :map org-src-mode-map
                ([remap evil-write] . org-edit-src-save))
    :straight t
    :mode ("\\.org$" . org-mode)

    :custom
    (org-adapt-indentation t)
    (org-catch-invisible-edits 'show-and-error)
    (org-return-follows-link t)
    (org-export-dispatch-use-expert-ui t)
    (org-clock-out-remove-zero-time-clocks t)
    (org-latex-create-formula-image-program 'imagemagick)
    (org-latex-listings nil)
    ;; (org-latex-listings 'minted)
    (org-tags-column -80)
    (org-enforce-todo-dependencies t)
    (org-enforce-todo-checkbox-dependencies  t)
    (org-pretty-entities t)
    (org-src-fontify-natively t)
    (org-list-allow-alphabetical t)
    (org-special-ctrl-a/e t)
    (org-deadline-warning-days 7)
    (org-confirm-babel-evaluate nil)
    (org-export-use-babel t)
    (org-src-window-setup 'current-window)
    (org-agenda-window-setup 'current-window)
    :init
    (setq
     ;;  org-latex-pdf-process (list "latexmk -shell-escape -pdf %f")

     org-entities-user
     '(("supsetneqq" "\\supsetneqq" t "" "[superset of above not equal to]"
        "[superset of above not equal to]" "⫌")
       ("subseteq" "\\subseteq" t "" "[subset of above equal to]" "subset of above equal to" "⊆")
       ("subsetneqq" "\\subsetneqq" t "" "[suberset of above not equal to]"
        "[suberset of above not equal to]" "⫋")))

    :config
    ;; (plist-put org-format-latex-options :scale 1.5)

    ;; NB(jjin): Uncomment if you want syntax highlighting for code snippets
    ;; (setq org-latex-packages-alist
    ;;   '(("" "minted") ("usenames,dvipsnames,svgnames" "xcolor")))

    (defun jjin/org-autodone (n-done n-not-done)
      "Switch entry to DONE when all subentries are done, to TODO otherwise."
      (let (org-log-done org-log-states)   ; turn off logging
        (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

    (add-hook 'org-after-todo-statistics-hook 'jjin/org-autodone)

    (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (latex     . t)
       (python    . t)
       ;; FIXME: Make this contingent on ob-ipython
       ;; (ipython   . t)
       (R         . t)
       (octave    . t)
       (matlab    . t)
       (shell     . t)))

    (setq org-latex-minted-options
          '(("linenos" "true")
            ("fontsize" "\\scriptsize")
            ("frame" "lines")))

    (setq org-export-latex-hyperref-format "\\ref{%s}")

    (setq org-blank-before-new-entry
          '((heading . true)
            (plain-list-item . auto)))

    (setq org-capture-templates
          `(("r" "Reading" entry (file "~/proj/lists/read.org")
                 "* TODO %?\n  Entered on %U\n  %i")
            ("t" "Task" entry (file "")
                 "* TODO %?\n %i")))

    (setq org-refile-targets '((nil . (:maxlevel . 10))))

    (setq org-export-with-smart-quotes t)
    (with-eval-after-load 'ace-link
      ;; (bind-keys :map org-agenda-mode-map
      ;;            ("M-o" . ace-link-org))
      (bind-keys :map org-mode-map
                 ("M-o" . ace-link-org))))

(use-package ox-latex
    :disabled t
    :after org)

(use-package ox-bibtex
    :disabled t
    :after org)

(use-package ox-md
    :after org)

(use-package ob-python
    :after org
    :init
    (setq org-babel-python-command "python3"))

(use-package evil-org
    :straight t
    :after (evil org)
    :diminish evil-org-mode
    :config
    (add-hook 'org-mode-hook 'evil-org-mode)
    (evil-org-set-key-theme)
    (setq evil-org-special-o/O '(table-row)))

(use-package org-contrib
    :straight t
    :after org)

(use-package ox-extra
    :after (org-contrib org)
    :config
    (ox-extras-activate '(latex-header-blocks ignore-headlines)))

(use-package org-msg
    :disabled t
    :straight t
    ;; load after mu4e to pick up mail-user-agent setting
    :after (mu4e org)
    :custom
    (org-msg-default-alternatives '(text html))
    (org-msg-options "html-postamble:nil num:nil toc:nil author:nil email:nil")
    (org-msg-signature "

#+begin_signature
-- \\\\
Jonathan Jin
#+end_signature")
    :config
    (org-msg-mode))

(use-package all-the-icons
    :straight t

    :config
    (defun with-faicon (icon str &optional height v-adjust)
      (s-concat (all-the-icons-faicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))

    (defun with-fileicon (icon str &optional height v-adjust)
      (s-concat (all-the-icons-fileicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))

    (defun with-octicon (icon str &optional height v-adjust)
      (s-concat (all-the-icons-octicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))

    (defun with-material (icon str &optional height v-adjust)
      (s-concat (all-the-icons-material icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str)))

(use-package nerd-icons
    :straight t)
;; (nerd-icons-install-fonts)

(use-package doom-modeline
    :straight t
    :custom
    (doom-modeline-icon t)
    (doom-modeline-vcs-max-length 24)
    (doom-modeline-buffer-file-name-style 'truncate-except-project)
    (doom-modeline-buffer-encoding nil)
    :config
    (setq doom-modeline-height (min doom-modeline-height (default-font-height)))

    (doom-modeline-def-modeline 'jjin
        '(bar workspace-name window-number modals matches buffer-info remote-host selection-info )
      '(misc-info k8s mu4e debug lsp minor-modes input-method indent-info process vcs check))

    (add-hook 'doom-modeline-mode-hook (lambda () (doom-modeline-set-modeline 'jjin t)))

    (doom-modeline-mode 1))

(use-package pdf-tools
    :straight t
    :mode ("\\.pdf$" . pdf-view-mode)
    :config
    (pdf-tools-install)

    (let ((foreground-orig (car pdf-view-midnight-colors)))
      (setq pdf-view-midnight-colors
            (cons "white" "black")))

    (with-eval-after-load 'evil
      (progn
        (add-to-list 'evil-emacs-state-modes 'pdf-outline-buffer-mode)
        (add-to-list 'evil-emacs-state-modes 'pdf-view-mode))))


(use-package projectile
    :straight t
    :diminish projectile-mode
    :ensure-system-package (rg . ripgrep)
    :custom
    (projectile-ignored-projects '("/Users/jjin/"))
    (projectile-enable-caching t)
    (projectile-sort-order 'recently-active)
    (projectile-globally-ignored-directory-names '("~"))
    (projectile-globally-ignored-files
     '("TAGS" "GPATH" "GRTAGS" "GSYMS" "GTAGS"))

    (projectile-project-root-functions '(projectile-root-local
                                         projectile-root-bottom-up
                                         projectile-root-top-down
                                         projectile-root-top-down-recurring))
    :config

    ;; People at this company really like to use nested Makefiles
    (delete "Makefile" projectile-project-root-files)

    (defun jjin/projectile-absolute-compilation-dir-maybe ()
      "Return the default compilation dir of the current Projectile project type.

Only returns non-nil if it is an absolute path; otherwise, return
nil."
      (let* ((type (projectile-project-type))
             (comp-dir (projectile-default-compilation-dir type)))
        (if (and comp-dir (file-name-absolute-p comp-dir)) comp-dir nil)))
    (with-eval-after-load 'ivy
      (setq projectile-completion-system 'ivy))

    (defun jjin/projectile-vterm-at (dir)
      "Invoke `vterm' in the given project dir.

Switch to the project specific term buffer if it already exists.

This is a 'fork' of `projectile-run-vterm' to enable directory injection, for
use as an Embark action."

      (let* ((project (projectile-acquire-root dir))
             (buffer (projectile-generate-process-name "vterm" nil project)))
        (unless (buffer-live-p (get-buffer buffer))
          (unless (require 'vterm nil 'noerror)
            (error "package 'vterm' is not available"))
          (projectile-with-default-dir project
            (vterm buffer)))
        (switch-to-buffer buffer)))

    (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
    (with-eval-after-load 'evil
      (evil-define-key 'normal 'global (kbd "<leader>p") 'projectile-command-map))

    (advice-add 'projectile-compilation-dir
                :before-until
                'jjin/projectile-absolute-compilation-dir-maybe)

    ;; MacOS file system is case insensitive. This means that, when combined with
    ;; top-down root discovery, .git directory's `description' file conflicts with
    ;; the `DESCRIPTION' element -- intended for R projects -- in the default
    ;; value of `projectile-project-root-file'.
    ;;
    ;; Since I really don't use R and don't plan to anytime soon, removing it from
    ;; here. Can revisit if/when ever necessary.
    (setq projectile-project-root-files
          (remove "DESCRIPTION" projectile-project-root-files))
    (bind-key "<f12>"
              (lambda ()
                "Save all project buffers and compile"
                (interactive)
                (projectile-save-project-buffers)
                (let (compilation-read-command)
                  (projectile-compile-project nil)))
              projectile-mode-map)

    (projectile-global-mode)

    (add-to-list 'projectile-globally-ignored-modes "term-mode"))

(use-package rich-minority
    :straight t
    :config
    (defconst my-rm-excluded-modes
      '(
        " pair"
        " Fill"
        " end"
        " Ace - Window"))
    (dolist (mode my-rm-excluded-modes)
      (add-to-list 'rm-excluded-modes mode)))

(use-package tramp
    :custom
  (tramp-default-method "ssh")
  (password-cache-expiry nil)
  :config
  (add-to-list 'tramp-remote-path "~/bin"))

(use-package undo-tree
    :straight t
    :diminish undo-tree-mode
    :bind ("C-<backspace>" . undo-tree-undo)
    :config
    (global-undo-tree-mode)
    (with-eval-after-load 'evil
      (evil-set-undo-system 'undo-tree)))

(use-package w3m
    :straight t
    :bind (:map w3m-mode-map
                ("P" . w3m-view-previous-page)
                ("n" . w3m-tab-next-buffer)
                ("p" . w3m-tab-previous-buffer)
                ("w" . w3m-delete-buffer))
    :commands w3m
    :init
    (setq w3m-fill-column 80)

    :config
    (with-eval-after-load 'evil
      (add-to-list 'evil-emacs-state-modes 'w3m-session-select-mode))
    (with-eval-after-load 'ace-link
      (bind-keys :map w3m-mode-map
                 ("o" . ace-link-w3m)))

    (unbind-key "B" w3m-mode-map))

(use-package w3m-session
    :after w3m)

(use-package ripgrep
    :straight t)

(use-package which-key :straight t)

(use-package terraform-mode
    :straight t)

(defun jjin-hinge-auth-kubectl (context-name)
  "Authenticate kubectl for the given CONTEXT-NAME."
  (cond ((string-prefix-p "dev-ue1-eks" context-name)
         (let ((shell-command-switch "-ic"))
           (compile "aws-profile -o hinge-dev")))
        ((string-prefix-p "prod-ue1-eks" context-name)
         (let ((shell-command-switch "-ic"))
           (compile "aws-profile -o hinge-prod")))))

(use-package kele
    :straight (:local-repo "~/dev/jinnovation/kele.el" :type git :host github :repo "jinnovation/kele.el")
    :config
    (kele-mode 1)
    (add-hook #'kele-context-after-switch-functions #'jjin-hinge-auth-kubectl)
    (bind-key (kbd "s-k") kele-command-map kele-mode-map))

(use-package aggressive-indent
    :straight t
    :config
    (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode))

(use-package shell-maker
    :straight t)

(use-package acp
    :straight t)

(use-package agent-shell
    :straight (:repo "https://github.com/xenodium/agent-shell")
    :after (shell-maker acp)
    :bind (("s-a" . #'agent-shell))
    :hook (agent-shell-mode . bug-reference-mode)
    :custom
    (agent-shell-header-style 'graphical)
    (agent-shell-file-completion-enabled t)
    (agent-shell-show-welcome-message nil)

    :config
    (defun jjin/agent-shell-mode-p (buf &optional act)
      "Check if BUF is an agent-shell buffer.

ACT is buffer action that enables use in `display-buffer-alist.'"
      (with-current-buffer buf (derived-mode-p 'agent-shell-mode)))

    (add-to-list 'display-buffer-alist
                 '(jjin/agent-shell-mode-p
                   (display-buffer-reuse-window display-buffer-in-side-window)
                   (side . right)
                   (window-parameters . ((no-delete-other-windows . t)))
                   (window-width . 100)))

    (setq agent-shell-anthropic-claude-environment
          (agent-shell-make-environment-variables :inherit-env t))

    (add-to-list 'evil-emacs-state-modes #'agent-shell-mode)

    (setq agent-shell-anthropic-authentication
          (agent-shell-anthropic-make-authentication :login t)))
