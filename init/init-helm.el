(provide 'init-helm)

(helm-mode 1)
(helm-autoresize-mode t)
(setq helm-M-x-fuzzy-match t)

(setq helm-external-programs-associations '(("pdf" . "zathura")))