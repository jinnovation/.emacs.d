;;; init-packages.el --- initialization for "required" packages"

(provide 'init-packages)

(defconst package-list
    '(helm
         helm-ag
         helm-projectile
         helm-swoop
         projectile
         org
         magit
         smart-mode-line
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

         auctex))

;;; init-packages.el ends here
