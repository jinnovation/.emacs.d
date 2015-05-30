(add-to-list 'load-path (expand-file-name "~/.emacs.d/init"))

;; packages not managed by Cask or package.el
(add-to-list 'load-path (expand-file-name "~/.emacs.d/pkg"))

(require 'cask)
(cask-initialize)
(pallet-mode t)

(require 'use-package)
(require 'diminish)

(use-package ess-site
  :config
  (bind-key "C-c C-w" nil inferior-ess-mode-map)
  (setq inferior-R-args "--quiet"))

(pdf-tools-install)

(use-package paradox
  :init
  (setq paradox-github-token t))

(use-package ace-window
  :config
  (add-to-list 'aw-ignored-buffers "mu4e-update")
  (setq aw-keys '(?a ?r ?s ?t ?q ?w ?f ?p)))

(use-package window-purpose
  :disabled t
  :config
  (bind-key "W" 'purpose-set-window-purpose purpose-mode-prefix-map)

  (purpose-x-magit-multi-on)

  (setq purpose-user-mode-purposes
    '((circe-channel-mode   . comm)
       (circe-chat-mode     . comm)
       (circe-query-mode    . comm)
       (circe-lagmon-mode   . comm)
       (circe-server-mode   . comm)

       (haskell-mode        . edit)
       (ess-mode            . edit)
       (gitconfig-mode      . edit)
       (conf-xdefaults-mode . edit)
       (inferior-ess-mode   . interactive)

       (mu4e-main-mode      . admin)
       (mu4e-view-mode      . admin)
       (mu4e-about-mode     . admin)
       (mu4e-headers-mode   . admin)
       (mu4e-compose-mode   . edit)
       
       (pdf-view-mode       . view)
       (doc-view-mode       . view)))

  (setq purpose-user-regexp-purposes
    '(("^\\*elfeed"         . admin)))

  (purpose-compile-user-configuration)

  (purpose-mode)
  (purpose-load-window-layout))

(use-package helm
  :bind (("C-x m" . helm-M-x)
          ("H-f f" . helm-find-files)
          ("H-b b" . helm-buffers-list)))

(use-package elfeed
  :commands (elfeed-search-mode elfeed-show-mode)
  :bind ("H-E" . elfeed)
  :init
  (setq elfeed-feeds
    '(("http://www.aljazeera.com/Services/Rss/?PostingId=2007731105943979989" news)
       ("http://ny.curbed.com/atom.xml" realestate news)
       ("http://www.avclub.com/feed/rss/" film entertainment news)
       ("http://fivethirtyeight.com/all/feed")
       ("http://www.tor.com/rss/frontpage_full" literature)
       ("http://longform.org/feed.rss")
       ("http://feeds.feedburner.com/themillionsblog/fedw" literature)
       ("http://feeds.feedburner.com/mcsweeneys/")

       ("http://feeds.bbci.co.uk/news/world/rss.xml"                    news)
       ("http://feeds.bbci.co.uk/news/business/rss.xml"                 news)
       ("http://feeds.bbci.co.uk/news/technology/rss.xml"               news tech)
       ("http://feeds.bbci.co.uk/news/entertainment_and_arts/rss.xml"   news)

       ("http://en.boxun.com/feed/"                                     news china)

       ("http://feeds.99percentinvisible.org/99percentinvisible" design podcast)

       ("http://rss.escapistmagazine.com/news/0.xml"         entertainment videogames)
       ("http://rss.escapistmagazine.com/videos/list/1.xml"  entertainment videogames)
       ("http://www.engadget.com/tag/@gaming/rss.xml"        entertainment videogames)
       ("http://feeds.feedburner.com/RockPaperShotgun"       entertainment videogames)
       ("http://screenrant.com/feed/"                        entertainment movies)

       ;; software
       ("https://news.ycombinator.com/rss"                software news)
       ("http://usesthis.com/feed/"                       software)
       ("http://endlessparentheses.com/atom.xml"          software emacs)
       ("http://feeds.feedburner.com/codinghorror"        software)
       ("http://feeds.feedburner.com/thisdeveloperslife"  software)
       ("http://feeds.feedburner.com/oreilly/news"        software)
       ("http://www.joelonsoftware.com/rss.xml"           software)
       ("http://onethingwell.org/rss"                     software tech)
       ("http://syndication.thedailywtf.com/TheDailyWtf"  software)
       ("http://githubengineering.com/atom.xml"           software tech)

       ("http://pandodaily.com.feedsportal.com/c/35141/f/650422/index.rss"  tech)
       ("https://medium.com/feed/backchannel"                               tech software)
       ("http://feeds.feedburner.com/laptopmag"                             tech)
       ("http://recode.net/feed/"                                           tech)
       ("http://recode.net/category/reviews/feed/"                          tech)
       ("http://feeds.feedburner.com/AndroidPolice"                         tech android)
       ("http://bits.blogs.nytimes.com/feed/"                               tech)

       ("http://www.eater.com/rss/index.xml"                     food)
       ("http://ny.eater.com/rss/index.xml"                      food ny)
       ("http://notwithoutsalt.com/feed/"                        food)
       ("http://feeds.feedburner.com/nymag/Food"                 food)
       ("http://feeds.feedburner.com/seriouseatsfeaturesvideos"  food)
       ("http://feeds.feedburner.com/blogspot/sBff")

       ("http://xkcd.com/rss.xml"                      comic)
       ("http://feeds.feedburner.com/Explosm"          comic)
       ("http://feed.dilbert.com/dilbert/daily_strip"  comic)
       ("http://feeds.feedburner.com/smbc-comics/PvLb" comic)
       ("http://www.questionablecontent.net/QCRSS.xml" comic)
       ("http://phdcomics.com/gradfeed.php"            comic)

       ("http://feeds.feedburner.com/wondermark"       comic)))

  (setq elfeed-max-connections 10)

  (setq url-queue-timeout 30)
  
  :config
  (bind-key "<SPC>" 'next-line elfeed-search-mode-map))

(use-package circe
  :commands (circe-chat-mode
              circe-server-mode
              circe-query-mode
              circe-channel-mode)
  :bind ("H-I" . circe)
  :config
  (setq
    circe-default-nick "jjin"
    circe-default-user "jjin"
    circe-default-part-message "Peace."
    circe-default-quit-message "Peace.")

  (setq circe-use-cycle-completion t
    circe-reduce-lurker-spam t)

  (setq circe-network-options
    '(("Freenode"
        :nick "jjin"
        :channels ("#emacs" "#archlinux")
        :nickserv-password ,freenode-pass)
       ("Bitlbee"
         :service "6667"
         :nickserv-password ,bitlbee-pass
         :nickserv-mask "\\(bitlbee\\|root\\)!\\(bitlbee\\|root\\)@"
         :nickserv-identify-challenge "use the \x02identify\x02 command to identify yourself"
         :nickserv-identify-command "PRIVMSG &bitlbee :identify {password}"
         :nickserv-identify-confirmation "Password accepted, settings and accounts loaded")))

  (setq
    circe-format-self-say "<{nick}> {body}"
    circe-format-server-topic "*** Topic change by {origin}: {topic-diff}")

  (add-hook 'circe-chat-mode-hook 'my-circe-prompt)
  (defun my-circe-prompt ()
    (lui-set-prompt
      (concat (propertize (concat (buffer-name) ">")
                'face 'circe-prompt-face)
        " ")))

  (enable-circe-color-nicks)
  (setq circe-color-nicks-everywhere t))

(use-package sass-mode
  :disabled t
  :config
  (setq scss-compile-at-save nil)
  (add-hook 'scss-mode-hook 'rainbow-mode))

(use-package rich-minority
  :config
  (defconst my-rm-excluded-modes
    '(
       " MRev"
       " Helm"
       " Undo-Tree"
       " pair"
       " Fill"
       " FIC"
       " company"
       " end"
       " Ace - Window"
       " =>"                            ; aggressive-indent
       " Rbow"))
  (dolist (mode my-rm-excluded-modes)
    (add-to-list 'rm-excluded-modes mode)))

(use-package enh-ruby-mode
  :config
  (defvaralias 'ruby-indent-level 'tab-width)

  (add-hook 'ruby-mode-hook
    (lambda ()
      (local-set-key (kbd "RET")
        'newline-and-indent)
      (ruby-end-mode))))

(use-package helm
  :config
  (helm-mode 1)
  (helm-autoresize-mode t)
  (setq helm-M-x-fuzzy-match t)

  (setq
    helm-external-programs-associations '(("pdf" . "zathura"))
    helm-split-window-in-side-p t))

(use-package markdown-mode+
  :config
  (add-hook 'markdown-mode-hook 'auto-fill-mode)
  (add-hook 'markdown-mode-hook 'fic-mode))

(use-package ansi-color
  :config
  (setq ansi-color-faces-vector
    [default bold shadow italic underline bold bold-italic bold])
  (defun colorize-compilation-buffer ()
    (toggle-read-only)
    (ansi-color-apply-on-region (point-min) (point-max))
    (toggle-read-only))

  (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
  (setq compilation-scroll-output t))

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
    :commands org-capture-mode
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

(use-package doc-view
  :init
  (setq doc-view-resolution 200))

(mapc 'require '(init-fn
                  init-keybinding
                  init-general

                  init-org
                  init-modes
                  init-projectile
                  init-linum
                  init-appearance

                  init-mu4e

                  ;; languages
                  init-c
                  init-js
                  init-haskell
                  init-lisp
                  init-latex

                  ;; environments
                  init-mac))

(use-package git-commit-mode
  :commands git-commit-mode)

(use-package evil
  :init
  (setq evil-esc-delay 0)
  
  :config
  (append-to-list 'evil-insert-state-modes '(org-capture-mode
                                              git-commit-mode))
  (append-to-list 'evil-emacs-state-modes
    '(circe-chat-mode circe-server-mode circe-query-mode circe-channel-mode
       elfeed-search-mode elfeed-show-mode))
  
  (bind-key "<escape>" 'evil-execute-in-normal-state evil-emacs-state-map)
  (bind-key "L" 'evil-end-of-line evil-normal-state-map)
  (bind-key "H" 'evil-beginning-of-line evil-normal-state-map)
  (bind-key "C-w q" 'delete-window evil-normal-state-map)
  (bind-key "RET" 'insert-newline-after evil-normal-state-map)
  (bind-key "RET" 'newline-and-indent evil-insert-state-map)
  
  (use-package hydra
    :config
    (bind-key "C-w" 'hydra-window/body evil-normal-state-map))
  (use-package evil-numbers
    :config
    (bind-key "C-a" 'evil-numbers/inc-at-pt evil-normal-state-map)
    (bind-key "C-c -" 'evil-numbers/dec-at-pt evil-normal-state-map))
  (use-package evil-search-highlight-persist
    :config
    (bind-key "C-l" 'evil-search-highlight-persist-remove-all
      evil-normal-state-map)
    (global-evil-search-highlight-persist t))
  (evil-mode 1)
  (use-package evil-leader
    :config
    (evil-leader/set-leader "<SPC>")
    (global-evil-leader-mode))
  (use-package evil-surround
    :config
    (global-evil-surround-mode 1)))

(append-to-list 'evil-emacs-state-modes
  '(eshell-mode
     calendar-mode

     finder-mode
     info-mode

     eww-mode
     eww-bookmark-mode

     dired-mode
     image-mode
     image-dired-thumbnail-mode
     image-dired-display-image-mode
     pdf-view-mode
     pdf-outline-minor-mode

     git-rebase-mode

     inferior-ess-mode
     ess-help-mode

     paradox-menu-mode))
