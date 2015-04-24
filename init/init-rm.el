;;; init-rm.el --- rich-minority-mode configs
(provide 'init-rm)

(if-package-installed "rich-minority"
  (setq rm-blacklist ".*"))

;;; init-rm.el ends here
