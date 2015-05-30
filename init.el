(add-to-list 'load-path (expand-file-name "~/.emacs.d/init"))

;; packages not managed by Cask or package.el
(add-to-list 'load-path (expand-file-name "~/.emacs.d/pkg"))

(require 'cask)
(cask-initialize)
(pallet-mode t)

(require 'use-package)

(use-package ess-site
  :config
  (bind-key "C-c C-w" nil inferior-ess-mode-map))

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

  (purpose-compile-user-configuration))

(use-package helm
  :bind (("C-x m" . helm-M-x)
          ("H-f f" . helm-find-files)
          ("H-b b" . helm-buffers-list)))

(use-package elfeed
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
  :bind ("H-I" . circe))

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
       " EvilOrg"
       " end"
       " Ace - Window"
       " =>"                            ; aggressive-indent
       " Rbow"))
  (dolist (mode my-rm-excluded-modes)
    (add-to-list 'rm-excluded-modes mode)))

(mapc 'require '(init-fn
                  init-keybinding
                  init-general

                  init-hydra

                  init-org
                  init-evil
                  init-doc-view
                  init-helm
                  init-modes
                  init-projectile
                  init-linum
                  init-appearance

                  init-gnus
                  init-mu4e
                  init-circe

                  ;; languages
                  init-ruby
                  init-c
                  init-js
                  init-haskell
                  init-lisp
                  init-markdown
                  init-latex
                  init-r

                  init-compile

                  ;; environments
                  init-mac))
