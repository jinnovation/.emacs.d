;;i init-org.el --- Org-mode-specific configurations

(provide 'init-org)
(require 'ox-latex)

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

;; (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))

(setq org-latex-pdf-process
    '("pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f"
         "pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f" 
         "pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f"))

(add-hook 'org-mode-hook
    (lambda ()
        (add-to-list 'org-structure-template-alist
            '("C" "#+BEGIN_COMMENT\n?\n#+END_COMMENT" ""))
        (fic-mode)))

;; (add-hook 'org-src-mode-hook
;;     (lambda ()
;;         (evil-leader/set-key
;;             "w" 'org-edit-src-save)))

(setq org-tags-column -80)

(setq org-latex-create-formula-image-program 'imagemagick)

(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

(defun my-org-autodone (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-log-states)   ; turn off logging
        (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'my-org-autodone)

;;; init-org.el ends here
