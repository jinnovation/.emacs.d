;;; init-latex.el --- LaTeX-specific configs
(provide 'init-latex)

;; sets latex-mode to compile w/ pdflatex by default
(setq TeX-PDF-mode t)
(setq TeX-parse-self t)

(eval-after-load "tex"
    '(setcdr (assoc "LaTeX" TeX-command-list)
         '("%`%l%(mode) -shell-escape%' %t"
              TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")))

;; latex-mode-specific hooks (because latex-mode is not derived from prog-mode)
(add-hook 'LaTeX-mode-hook
    (lambda ()
        (TeX-fold-mode 1)
        (fic-ext-mode)
        (auto-fill-mode)
        (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t"
                                            TeX-run-TeX nil t))))

;;; init-latex.el ends here
