;;i init-org.el --- Org-mode-specific configurations

(provide 'init-org)

(require 'ox-latex)

(setq

  org-enforce-todo-dependencies           t
  org-enforce-todo-checkbox-dependencies  t
  org-pretty-entities                     t
  org-src-fontify-natively                t
  org-alphabetical-lists                  t)

(setq org-todo-keywords
    '((sequence "TODO(t)" "IN-PROGRESS(r)" "|"  "DONE(d)")))

(setq org-todo-keyword-faces
    '(("TODO" . org-todo) ("IN-PROGRESS" . "yellow") ("DONE" . org-done)))

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

(setq
  org-tags-column -80
  org-latex-create-formula-image-program 'imagemagick
  org-latex-listings 'minted)

(add-to-list 'org-latex-packages-alist '("" "minted"))

(defun my-org-autodone (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-log-states)   ; turn off logging
        (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'my-org-autodone)

(setq org-agenda-files '("~/agenda"))

(setq org-agenda-custom-commands
  '(("j" "Homework"
      ((agenda "" ((org-agenda-ndays 14)
                    (org-agenda-start-on-weekday nil)
                    (org-agenda-prefix-format " %-12:c%?-12t% s")))
        (tags-todo "CATEGORY=\"HW\""
          ((org-agenda-prefix-format "%b")))))
     
     ("r" "Reading"
       ((tags-todo "CATEGORY=\"Reading\""
          ((org-agenda-prefix-format "%:T ")))))))

;;; init-org.el ends here
