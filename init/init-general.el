(provide 'init-general)

(setq paradox-github-token "50d7f7fe0af07638a09e1a32f4ec5bba3f83f74e")

(setq-default indent-tabs-mode nil)

(setq-default tab-width 4)
(defvaralias 'js-indent-level 'tab-width)
(defvaralias 'c-basic-offset 'tab-width)

(global-auto-revert-mode)

(setq scss-compile-at-save nil)

(setq browse-url-browser-function 'browse-url-generic
    browse-url-generic-program "chromium")

(when (fboundp 'global-linum-mode)
    (setq linum-format 'dynamic)
    (global-linum-mode 1))

(when (fboundp 'global-hl-line-mode)
    (global-hl-line-mode 1))

(when (fboundp 'column-number-mode)
    (column-number-mode 1))

(show-paren-mode 1)
(autopair-global-mode)
(delete-selection-mode +1)

(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'line-number-mode) (line-number-mode -1))

(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

;; highlights strings like TODO, FIXME, etc.
(add-hook 'prog-mode-hook 'fic-ext-mode)

;; lines do not exceed 80 lines
;; (add-hook 'c-mode-common-hook 'turn-on-auto-fill)
(add-hook 'prog-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; latex-mode-specific hooks (because latex-mode is retarded and not derived
;; from prog-mode)
(add-hook 'LaTeX-mode-hook
    (lambda ()
        (TeX-fold-mode 1)
        (fic-ext-mode)
        (auto-fill-mode)
        (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t"
                                            TeX-run-TeX nil t))))

(add-hook 'markdown-mode-hook 'auto-fill-mode)
(add-hook 'markdown-mode-hook 'fic-ext-mode)

(add-hook 'scss-mode-hook 'rainbow-mode)

(setq next-line-add-newlines t)

(setq-default fill-column 80)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq ess-ask-for-ess-directory nil)

;; sets latex-mode to compile w/ pdflatex by default
(setq TeX-PDF-mode t)
(setq TeX-parse-self t)

(add-hook 'comint-output-filter-functions
    'comint-watch-for-password-prompt)

(eval-after-load "tex" 
    '(setcdr (assoc "LaTeX" TeX-command-list)
         '("%`%l%(mode) -shell-escape%' %t"
              TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")))

(setq c-block-comment-prefix "* ")

(setq scroll-step 1)
(setq scroll-margin 3)

(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

(defconst linum-mode-excludes
    '(doc-view-mode
         magit-mode)
    "List of major modes preventing linum to be enabled in the buffer.")

