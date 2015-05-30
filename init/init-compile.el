;;; init-compile.el --- compilation mode configs

(provide 'init-compile)
(require 'ansi-color)

(use-package ansi-color
  :config
  (setq ansi-color-faces-vector
    [default bold shadow italic underline bold bold-italic bold]))
                                        ;
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))

(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(setq compilation-scroll-output t)

;;; init-compile ends here
