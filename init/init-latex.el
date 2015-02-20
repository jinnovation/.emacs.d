;;; init-latex.el --- LaTeX-specific configs
(provide 'init-latex)

;; sets latex-mode to compile w/ pdflatex by default
(setq TeX-PDF-mode t)
(setq TeX-parse-self t)

(eval-after-load "tex"
    '(setcdr (assoc "LaTeX" TeX-command-list)
         '("%`%l%(mode) -shell-escape%' %t"
              TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")))

;;; init-latex.el ends here
