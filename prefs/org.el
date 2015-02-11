(setq org-pretty-entities t)
(setq org-src-fontify-natively t)
(setq org-alphabetical-lists t)

(setq org-todo-keywords
    '((sequence "TODO(t)" "|" "REVIEW(r)" "DONE(d)")))
;;   (sequence "TO-APPLY(a)" "|" "APPLIED(A!)" "IN-PROCESS(i!)"
;; "PENDING(p!)""NONE(n!)" "REJECTED(r!)" "OFFERED(O!)" "DECLINED(D!)")))

(setq org-todo-keyword-faces
    '(("TO-APPLY" . org-todo)
         ("REVIEW". "yellow")
         ("APPLIED" . "yellow")
         ("IN-PROCESS" . "yellow")
         ("PENDING" . "yellow")
         ("NONE" . "red")
         ("REJECTED" . "red")
         ("OFFERED" . 'org-done)
         ("DECLINED" . "orange")))

(set-variable
    'org-format-latex-options
    (quote
        (:foreground default :background default :scale 1.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
            ("begin" "$1" "$" "$$" "\\(" "\\["))))

(setq org-latex-pdf-process
    '("pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f"
         "pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f" 
         "pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f"))

(add-hook 'org-mode-hook
    (lambda ()
        (add-to-list 'org-structure-template-alist
            '("C" "#+BEGIN_COMMENT\n?\n#+END_COMMENT" ""))
        (fic-ext-mode)))

(add-hook 'org-src-mode-hook
    (lambda ()
        (evil-leader/set-key
            "w" org-edit-src-save)))

(setq org-tags-column -80)
