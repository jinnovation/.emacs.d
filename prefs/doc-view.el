(add-hook 'doc-view-mode-hook           ;FIXME: convert to eval-after-load
    (lambda ()
        (define-key doc-view-mode-map (kbd "j") 'doc-view-next-line-or-next-page)
        (define-key doc-view-mode-map (kbd "k")
            'doc-view-previous-line-or-previous-page)
        (define-key doc-view-mode-map (kbd "g") 'doc-view-first-page)
        (define-key doc-view-mode-map (kbd "G") 'doc-view-last-page)
        (evil-local-mode -1)
        (doc-view-fit-width-to-window)))
