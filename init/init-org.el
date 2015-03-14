;;i init-org.el --- Org-mode-specific configurations

(provide 'init-org)

(require 'ox-latex)

(setq
  org-agenda-files '("~/agenda")

  org-latex-create-formula-image-program 'imagemagick
  org-latex-listings 'minted
  org-tags-column -80
  org-enforce-todo-dependencies           t
  org-enforce-todo-checkbox-dependencies  t
  org-pretty-entities                     t
  org-src-fontify-natively                t
  org-alphabetical-lists                  t
  
  org-todo-keywords
  '((sequence "TODO(t)" "IN-PROGRESS(r)" "|"  "DONE(d)"))
  
  org-todo-keyword-faces
  '(("TODO" . org-todo) ("IN-PROGRESS" . "yellow") ("DONE" . org-done))
  
  org-agenda-custom-commands
  '(("h" "Homework"
      ((agenda "" ((org-agenda-ndays 14)
                    (org-agenda-start-on-weekday nil)
                    (org-agenda-prefix-format " %-12:c%?-12t% s")))
        (tags-todo "CATEGORY=\"HW\""
          ((org-agenda-prefix-format "%b")))))
     
     ("r" "Reading"
       ((tags-todo "CATEGORY=\"Reading\""
          ((org-agenda-prefix-format "%:T "))))))
  
  org-latex-pdf-process
  '("pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f"
     "pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f" 
     "pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f"))

;; (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))

(add-hook 'org-mode-hook
  (lambda ()
    (add-to-list 'org-structure-template-alist
      '("C" "#+BEGIN_COMMENT\n?\n#+END_COMMENT" ""))
    (fic-mode)))

(add-to-list 'org-latex-packages-alist '("" "minted"))

(defun my-org-autodone (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'my-org-autodone)

;;; init-org.el ends here
