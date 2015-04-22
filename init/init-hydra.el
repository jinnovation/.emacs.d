;; init-hydra.el --- defining custom hydra

(provide 'init-hydra)

(defhydra hydra-zoom (global-map "H-z")
  "zoom"
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out"))

(defhydra hydra-project (global-map "H-p"
                          :exit t)
  "project"
  ("p" helm-projectile)
  ("f" helm-projectile-find-file)
  ("F" helm-projectile-find-file-in-known-projects)
  ("a" helm-projectile-ag)
  ("K" projectile-kill-buffers)
  ("c" projectile-compile-project))

(defhydra hydra-window (global-map "H-w")
  "Window management"
  ;; TODO: bindings for moving splitters
  ("w" ace-window "select" :exit t)
  ("v" split-window-right "split right")
  ("s" split-window-below "split below")
  ("j" windmove-down "move down")
  ("k" windmove-up "move up")
  ("h" windmove-left "move left")
  ("l" windmove-right "move right")
  ("q" delete-window "close")
  ("Q" kill-buffer-and-window "close and kill"))

(defhydra hydra-vc (global-map "H-g")
  "version control"
  ("s" magit-status "git status" :exit t)
  ("b" magit-blame-mode "git blame"))

(after 'org
  (defhydra hydra-org (org-mode-map "H-o"
                        :exit nil)
    "Org mode"
    ("n" outline-next-visible-heading)
    ("p" outline-previous-visible-heading)
    ("u" outline-up-heading)
    ("<tab>" org-cycle)
    ("f" org-forward-heading-same-level)
    ("b" org-backward-heading-same-level)))

;; init-hydra.el ends here
