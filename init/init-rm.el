;;; init-rm.el --- rich-minority-mode configs
(provide 'init-rm)

(if-package-installed "rich-minority"
  (defconst my-rm-excluded-modes
    '(
       " MRev"
       " Helm"
       " Undo-Tree"
       " pair"
       " Fill"
       " FIC"
       " company"
       " EvilOrg"
       " end"
       " Ace - Window"
       " =>"                            ; aggressive-indent
       " Rbow"))
  (dolist (mode my-rm-excluded-modes)
    (add-to-list 'rm-excluded-modes mode)))

;;; init-rm.el ends here
