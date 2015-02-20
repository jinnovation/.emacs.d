;;; init-rm.el --- rich-minority-mode configs
(provide 'init-rm)

(after "rich-minority-autoloads"
    (defconst my-rm-excluded-modes
        '(
             " MRev"
             " Helm"
             " Undo-Tree"
             " pair"
             " Fill"
             " FIC"
             " company"
             " end"))
    (dolist (mode my-rm-excluded-modes)
        (add-to-list 'rm-excluded-modes mode))
    )

;;; init-rm.el ends here
