;;; init-projectile.el -- Projectile-specific configurations

(provide 'init-projectile)

(setq projectile-enable-caching t
    projectile-completion-system 'grizzl
    projectile-switch-project-action 'helm-projectile)

(projectile-global-mode)

;;; init-projectile.el ends here
