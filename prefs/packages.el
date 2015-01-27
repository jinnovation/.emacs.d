(defconst package-list
    '(
         helm
         helm-ag
         helm-projectile
         helm-swoop
         projectile
         org
         magit
         smart-mode-line
         wakatime-mode
         gotham-theme

         evil
         evil-easymotion
         evil-leader
         evil-nerd-commenter
         evil-numbers
         evil-search-highlight-persist
         evil-surround

         git-commit-mode
         git-rebase-mode
         gitconfig-mode
         gitignore-mode

         auctex
         
         )
    "required packages."
    )

(dolist (package package-list)
    (unless (package-installed-p package)
        (message "%s" "Emacs is now refreshing its package database...")
        (package-refresh-contents)
        (message "%s" " done.")
        (package-install package)))
