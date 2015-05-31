(add-to-list 'load-path (expand-file-name "~/.emacs.d/init"))

;; packages not managed by Cask or package.el
(add-to-list 'load-path (expand-file-name "~/.emacs.d/pkg"))

(require 'cask)
(cask-initialize)
(pallet-mode t)

(require 'use-package)
(require 'diminish)

(setq ring-bell-function 'ignore)
(setq-default x-stretch-cursor t)

(use-package ess-site
  :init
  (setq inferior-R-args "--quiet")
  
  :config
  (bind-key "C-c C-w" nil inferior-ess-mode-map))

(use-package conf-mode
  :mode
  (("\\.service\\'"    . conf-unix-mode)
    ("\\.timer\\'"      . conf-unix-mode)
    ("\\.target\\'"     . conf-unix-mode)
    ("\\.mount\\'"      . conf-unix-mode)
    ("\\.automount\\'"  . conf-unix-mode)
    ("\\.slice\\'"      . conf-unix-mode)
    ("\\.socket\\'"     . conf-unix-mode)
    ("\\.path\\'"       . conf-unix-mode)
    ("conf$"            . conf-mode)
    ("rc$"              . conf-mode)))

(use-package pdf-tools
  :config
  (pdf-tools-install))

(use-package paradox
  :config
  (setq paradox-github-token t))

(use-package ace-window
  :init
  (setq aw-keys '(?a ?r ?s ?t ?q ?w ?f ?p))
  
  :config
  (add-to-list 'aw-ignored-buffers "mu4e-update"))

(use-package web-mode
  :mode "\\.erb$")

(use-package window-purpose
  :disabled t
  :init
  (setq purpose-user-regexp-purposes
    '(("^\\*elfeed"         . admin)))

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

  :config
  (bind-key "W" 'purpose-set-window-purpose purpose-mode-prefix-map)

  (purpose-x-magit-multi-on)
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
  :init
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
  (setq circe-color-nicks-everywhere t)

  :config
  (add-hook 'circe-chat-mode-hook 'my-circe-prompt)
  (defun my-circe-prompt ()
    (lui-set-prompt
      (concat (propertize (concat (buffer-name) ">")
                'face 'circe-prompt-face)
        " ")))

  (enable-circe-color-nicks)

  (use-package helm-circe
    :config
    (bind-key "i" 'helm-circe jjin/chat-map)
    (bind-key "n" 'helm-circe-new-activity jjin/chat-map)))

(use-package sass-mode
  :disabled t
  :init
  (setq scss-compile-at-save nil)
  :config
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
  :mode ("Gemfile" "Guardfile")
  :config
  (defvaralias 'ruby-indent-level 'tab-width)

  (add-hook 'ruby-mode-hook
    (lambda ()
      (local-set-key (kbd "RET")
        'newline-and-indent)
      (ruby-end-mode))))

(use-package helm
  :init
  (setq
    helm-M-x-fuzzy-match t
    helm-external-programs-associations '(("pdf" . "zathura"))
    helm-split-window-in-side-p t)
  
  :config
  (helm-mode 1)
  (helm-autoresize-mode t))

(use-package markdown-mode+
  :config
  (add-hook 'markdown-mode-hook 'auto-fill-mode)
  (add-hook 'markdown-mode-hook 'fic-mode))

(use-package ansi-color
  :init
  (setq ansi-color-faces-vector
    [default bold shadow italic underline bold bold-italic bold])
  (setq compilation-scroll-output t)
  :config
  (defun colorize-compilation-buffer ()
    (toggle-read-only)
    (ansi-color-apply-on-region (point-min) (point-max))
    (toggle-read-only))

  (add-hook 'compilation-filter-hook 'colorize-compilation-buffer))

(use-package hydra
  :commands defhydra
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

  (use-package evil-nerd-commenter
    :config
    (defhydra hydra-comment (prog-mode-map "H-c"
                              :exit t)
      "commenting"
      ("i" evilnc-comment-or-uncomment-lines)
      ("l" evilnc-quick-comment-or-uncomment-to-the-line)
      ("c" evilnc-copy-and-comment-lines)
      ("p" evilnc-comment-or-uncomment-paragraphs)
      ("v" evilnc-toggle-invert-comment-line-by-line))))

(use-package mu4e
  :commands (mu4e-main-mode
              mu4e-view-mode
              mu4e-about-mode
              mu4e-headers-mode
              mu4e-compose-mode)
  :bind (("H-M" . mu4e)
          ("H-m u" . mu4e-update-mail-and-index)
          ("H-m i" . mu4e-interrupt-update-mail))
  :init
  :config
  (bind-key "H-u" 'mu4e-update-mail-and-index mu4e-headers-mode-map)

  (setq
    mu4e-maildir "~/mail"

    mu4e-drafts-folder "/[Gmail].Drafts"
    mu4e-sent-folder   "/[Gmail].Sent Mail"
    mu4e-trash-folder  "/[Gmail].Trash"
    mu4e-refile-folder "/[Gmail].All Mail")

  ;; don't save message to Sent Messages, Gmail/IMAP takes care of this
  ;; (See the documentation for `mu4e-sent-messages-behavior' if you have
  ;; additional non-Gmail addresses and want assign them different
  ;; behavior.)
  (setq mu4e-sent-messages-behavior 'delete)

  ;; you can quickly switch to your Inbox -- press ``ji''
  (setq mu4e-maildir-shortcuts
    '(("/INBOX"               . ?i)
       ("/[Gmail].Sent Mail"   . ?s)
       ("/[Gmail].Trash"       . ?t)
       ("/[Gmail].All Mail"    . ?a)))

  ;; allow for updating mail using 'U' in the main view:
  (setq mu4e-get-mail-command "offlineimap")

  (setq mu4e-user-mail-address-list
    '("jjin082693@gmail.com"
       "jjin082693@uchicago.edu"
       "jonathan@jjin.me"))

  (defvaralias 'mu4e-compose-signature 'message-signature)

  ;; don't keep message buffers around
  (setq message-kill-buffer-on-exit t)

  (setq
    mu4e-html-renderer 'w3m
    mu4e-html2text-command "w3m -dump -T text/html")

  ;; make sure the gnutls command line utils are installed
  ;; (require 'smtpmail)

  (setq
    message-send-mail-function 'smtpmail-send-it
    smtpmail-stream-type 'starttls
    smtpmail-default-smtp-server "smtp.gmail.com"
    smtpmail-smtp-server "smtp.gmail.com"
    smtpmail-smtp-service 587)

  (add-hook 'mu4e-view-mode-hook
    'visual-line-mode)

  (add-hook 'mu4e-compose-pre-hook
    (defun my-set-from-address ()
      "Set the From address based on the To address of the original."
      (let ((msg mu4e-compose-parent-message)) ;; msg is shorter...
        (when msg
          (setq user-mail-address
            (cond
              ;; TODO; pull from mu4e-user-mail-address-list
              ((mu4e-message-contact-field-matches msg :to "jjin082693@gmail.com")
                "jjin082693@gmail.com")
              ((mu4e-message-contact-field-matches msg :to "jjin082693@uchicago.edu")
                "jjin082693@uchicago.edu")
              (t "jonathan@jjin.me")))))))

  (use-package gnus-dired
    :config
    ;; make the `gnus-dired-mail-buffers' function also work on message-mode derived
    ;; modes, such as mu4e-compose-mode
    (defun gnus-dired-mail-buffers ()
      (let (buffers)
        (save-current-buffer
          (dolist (buffer (buffer-list t))
            (set-buffer buffer)
            (when (and (derived-mode-p 'message-mode)
                    (null message-sent-message-via))
              (push (buffer-name buffer) buffers))))
        (nreverse buffers)))

    (setq gnus-dired-mail-mode 'mu4e-user-agent)
    (add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)))

(use-package doc-view
  :init
  (setq doc-view-resolution 200))

(mapc 'require '(init-fn
                  init-keybinding
                  init-general

                  init-modes
                  init-linum
                  init-appearance

                  ;; languages
                  init-c
                  init-js
                  init-lisp
                  init-latex

                  ;; environments
                  init-mac))

(use-package git-commit-mode
  :commands git-commit-mode)

(use-package gitconfig-mode
  :mode "gitconfig")

(use-package evil
  :defines evil-normal-state-map
  :init
  (setq evil-esc-delay 0)
  
  :config
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

       paradox-menu-mode

       circe-chat-mode circe-server-mode circe-query-mode circe-channel-mode
       elfeed-search-mode elfeed-show-mode))
  (append-to-list 'evil-insert-state-modes '(org-capture-mode
                                              git-commit-mode))
  
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

(use-package org
  :commands (org-mode org-capture-mode)
  :bind (("H-C" . org-capture)
          ("H-A" . org-agenda))
  :init
  (setq org-agenda-files '("~/agenda")
    org-return-follows-link t

    org-export-dispatch-use-expert-ui t
    
    org-latex-create-formula-image-program 'imagemagick
    org-latex-listings 'minted
    org-tags-column -80

    org-enforce-todo-dependencies t
    org-enforce-todo-checkbox-dependencies  t

    org-pretty-entities t
    org-src-fontify-natively t
    org-list-allow-alphabetical t

    org-todo-keywords
    '((sequence "TODO(t)" "IN-PROGRESS(r)" "|"  "DONE(d)"))

    org-todo-keyword-faces
    '(("TODO" . org-todo) ("IN-PROGRESS" . "yellow") ("DONE" . org-done))

    org-agenda-custom-commands
    '(("s" "Schoolwork"
        ((agenda "" ((org-agenda-ndays 14)
                      (org-agenda-start-on-weekday nil)
                      (org-agenda-prefix-format " %-12:c%?-12t% s")))
          (tags-todo "CATEGORY=\"Schoolwork\""
            ((org-agenda-prefix-format "%b")))))

       ("r" "Reading"
         ((tags-todo "CATEGORY=\"Reading\""
            ((org-agenda-prefix-format "%:T ")))))
       ("m" "Movies"
         ((tags-todo "CATEGORY=\"Movies\""
            ((org-agenda-prefix-format "%:T "))))))

    org-latex-pdf-process (list "latexmk -shell-escape -pdf %f")

    org-entities-user
    '(("supsetneqq" "\\supsetneqq" t "" "[superset of above not equal to]"
        "[superset of above not equal to]" "⫌")
       ("subsetneqq" "\\subsetneqq" t "" "[suberset of above not equal to]"
         "[suberset of above not equal to]" "⫋")))
  :config
  (use-package ox-latex)
  (use-package ox-bibtex)
  (bind-key "H-t" 'org-todo org-mode-map)
  (bind-key "H-e" 'org-export-dispatch org-mode-map)
  (bind-key "M-p" 'outline-previous-visible-heading org-mode-map)
  (bind-key "M-n" 'outline-next-visible-heading org-mode-map)
  (bind-key "H-s" 'org-edit-src-save org-src-mode-map)

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
  
  (bind-key "H-o" 'hydra-org/body org-mode-map)
  (plist-put org-format-latex-options :scale 1.5)

  (add-to-list 'org-structure-template-alist
    '("C" "#+BEGIN_COMMENT\n?\n#+END_COMMENT" ""))

  (add-hook 'org-mode-hook
    (lambda ()
      (fic-mode)))

  (setq org-latex-packages-alist
    '(("" "minted") ("usenames,dvipsnames,svgnames" "xcolor")))

  (defun my-org-autodone (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-log-states)   ; turn off logging
      (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

  (add-hook 'org-after-todo-statistics-hook 'my-org-autodone)

  (org-babel-do-load-languages
    'org-babel-load-languages
    '((emacs-lisp . t)
       (latex . t)
       (R . t)))

  (setq org-confirm-babel-evaluate nil
    org-export-babel-evaluate nil)

  (setq org-latex-minted-options
    '(("linenos" "true")
       ("fontsize" "\\scriptsize")
       ("frame" "lines")
       ("bgcolor" "LightGray")))

  (setq org-export-latex-hyperref-format "\\ref{%s}")

  (setq
    org-src-window-setup 'current-window
    org-agenda-window-setup 'current-window)

  (setq org-blank-before-new-entry
    '((heading . true) (plain-list-item . auto)))

  (setq
    ;; FIXME: parameter-ize dir `agenda'
    org-default-notes-file "~/agenda/notes.org"

    org-capture-templates
    '(("r" "Reading" entry (file "~/agenda/reading.org")
        "* TODO %?\n  Entered on %U\n  %i")))

  (setq org-modules
    '(org-bbdb
       org-bibtex
       org-docview
       org-gnus
       org-info
       org-irc
       org-mhe
       org-rmail
       org-w3m)))

(use-package projectile
  :config
  (setq projectile-enable-caching t
    projectile-completion-system 'grizzl
    projectile-switch-project-action 'helm-projectile)

  (projectile-global-mode))

(use-package haskell-mode
  :config
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indent))

