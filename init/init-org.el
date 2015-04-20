;; init-org.el --- Org-mode-specific configurations

(provide 'init-org)

(require 'ox-latex)

(setq
  org-agenda-files '("~/agenda")

  org-return-follows-link t

  org-export-dispatch-use-expert-ui t

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
  '(("s" "Schoolwork"
      ((agenda "" ((org-agenda-ndays 14)
                    (org-agenda-start-on-weekday nil)
                    (org-agenda-prefix-format " %-12:c%?-12t% s")))
        (tags-todo "CATEGORY=\"Schoolwork\""
          ((org-agenda-prefix-format "%b")))))

     ("r" "Reading"
       ((tags-todo "CATEGORY=\"Reading\""
          ((org-agenda-prefix-format "%:T ")))))
     ("m" "Movies"
       ((tags-todo "CATEGORY=\"Movies\""
          ((org-agenda-prefix-format "%:T "))))))

  org-latex-pdf-process
  '("pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f"
     "pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f"
     "pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f"))

(plist-put org-format-latex-options :scale 1.5)

(add-to-list 'org-structure-template-alist
  '("C" "#+BEGIN_COMMENT\n?\n#+END_COMMENT" ""))

(add-hook 'org-mode-hook
  (lambda ()
    (fic-mode)
    (writegood-mode)))

(setq org-latex-packages-alist
  '(("" "minted") ("usenames,dvipsnames,svgnames" "xcolor")))

(defun my-org-autodone (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'my-org-autodone)

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
     (latex . t)
     (R . t)))

(setq org-latex-minted-options
  '(("linenos" "true")
     ("fontsize" "\\scriptsize")
     ("frame" "lines")
     ("bgcolor" "LightGray")))

(setq org-export-latex-hyperref-format "\\ref{%s}")

(setq
  org-src-window-setup 'current-window
  org-agenda-window-setup 'current-window)

(setq org-blank-before-new-entry
  '((heading . true) (plain-list-item . auto)))

;;; init-org.el ends here
