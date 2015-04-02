;;; init-ruby.el --- Ruby-specific configurations

(provide 'init-ruby)

(defvaralias 'ruby-indent-level 'tab-width)

(add-hook 'ruby-mode-hook
  (lambda ()
    (local-set-key (kbd "RET")
      'newline-and-indent)
    (ruby-end-mode)))

;;; init-ruby.el ends here
