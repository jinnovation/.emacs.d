;;; init-markdown.el --- Markdown-specific configs
(provide 'init-markdown)

(add-hook 'markdown-mode-hook 'auto-fill-mode)
(add-hook 'markdown-mode-hook 'fic-mode)

;;; init-markdown.el ends here
