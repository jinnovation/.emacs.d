;; init-hydra.el --- defining custom hydra

(use-package hydra
  :config
  (use-package hydra-examples)
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
    ("w" ace-window "select" :exit t)
    ("v" split-window-right "split right")
    ("s" split-window-below "split below")
    ("j" windmove-down "move down")
    ("k" windmove-up "move up")
    ("h" windmove-left "move left")
    ("l" windmove-right "move right")
    ("H" hydra-move-splitter-left)
    ("L" hydra-move-splitter-right)
    ("J" hydra-move-splitter-down)
    ("K" hydra-move-splitter-up)
    ("p" purpose-set-window-purpose "set purpose" :exit t)
    ("z" toggle-maximize-window "toggle maximize":exit t)
    ("q" delete-window "close" :exit t)
    ("Q" kill-buffer-and-window "close and kill" :exit t))

  (defhydra hydra-vc (global-map "H-g")
    "version control"
    ("s" magit-status "git status" :exit t)
    ("b" magit-blame-mode "git blame"))

  (defhydra hydra-comment (prog-mode-map "H-c"
                            :exit t)
    "commenting"
    ("i" evilnc-comment-or-uncomment-lines)
    ("l" evilnc-quick-comment-or-uncomment-to-the-line)
    ("c" evilnc-copy-and-comment-lines)
    ("p" evilnc-comment-or-uncomment-paragraphs)
    ("v" evilnc-toggle-invert-comment-line-by-line))

  (use-package org
    :config
    (defhydra hydra-org (:exit nil)
      "Org mode"
      ("n" outline-next-visible-heading "heading: next")
      ("p" outline-previous-visible-heading "heading: prev")
      ("u" outline-up-heading "heading: up")
      ("<tab>" org-cycle)
      ("f" org-forward-heading-same-level "heading: forward")
      ("b" org-backward-heading-same-level "heading: back")
      ("t" org-todo "set TODO state")
      ("s" org-babel-next-src-block "src: next")
      ("S" org-babel-previous-src-block "src: prev"))

    (bind-key "H-o" 'hydra-org/body org-mode-map)))

(provide 'init-hydra)

;; init-hydra.el ends here
