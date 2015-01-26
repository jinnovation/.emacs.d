(setq projectile-enable-caching t)
(projectile-global-mode)
(setq projectile-completion-system 'grizzl)
(setq paradox-github-token "50d7f7fe0af07638a09e1a32f4ec5bba3f83f74e")

(setq-default indent-tabs-mode nil)

(setq-default tab-width 4)
(defvaralias 'js-indent-level 'tab-width)

(global-auto-revert-mode)
(when (>= emacs-major-version 24)
  (progn
      (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
      (add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/")
      (add-to-list 'custom-theme-load-path
		   "~/.emacs.d/elpa/highlight-indentation-0.5.0/")))

(load-theme 'gotham t)

(setq scss-compile-at-save nil)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome-beta")

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
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'fic-ext-mode)
(add-hook 'LaTeX-mode-hook (lambda () (TeX-fold-mode 1)))

(add-hook 'actionscript-mode-hook 'auto-fill-mode)
(add-hook 'actionscript-mode-hook 'fic-ext-mode)

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

;; Set transparency of emacs
(defun set-transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value (0 - 100 opaque): ")
  (set-frame-parameter (selected-frame) 'alpha value))
(set-transparency 80)

(setq font-face-main "DejaVu Sans Mono")
(setq font-size-small "10")
(setq font-size-bigger "15")
(setq font-setting-bigger (format "%s-%s" font-face-main font-size-bigger))
(setq font-setting-small (format "%s-%s" font-face-main font-size-small))

;; MODE LINE
(defun scale-text (cutoff-w cutoff-h)
  (interactive "nCutoff width: \nnCutoff height: ")
  (when (display-graphic-p nil)
    (set-face-attribute 'mode-line nil :font font-face-main)
    (set-face-attribute 'mode-line nil :height 100) ; FIXME: scale this too
    (cond ((> (x-display-pixel-height) (x-display-pixel-width))
           (if (> (x-display-pixel-width) cutoff-w)
               (set-face-attribute 'default nil :font font-setting-bigger)
             (set-face-attribute 'default nil :font font-setting-small)))
          ((> (x-display-pixel-width) (x-display-pixel-height))
           (if (> (x-display-pixel-height) cutoff-h)
               (set-face-attribute 'default nil :font font-setting-bigger)
             (set-face-attribute 'default nil :font font-setting-small))))))

(scale-text 1920 1080)

(eval-after-load "tex" 
  '(setcdr (assoc "LaTeX" TeX-command-list)
          '("%`%l%(mode) -shell-escape%' %t"
	    TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")))

(setq c-block-comment-prefix "* ")

(setq scroll-step 1)
(setq scroll-margin 3)
