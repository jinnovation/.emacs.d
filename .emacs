(load "~/.emacs.d/elpa/benchmark-init-20141004.609/benchmark-init.el")

                                        ; TODO: account for CLI mode in settings (highline etc)
(defconst user-init-dir "~/.emacs.d/")

;; (add-to-list 'load-path (expand-file-name user-init-dir))

(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                            ("marmalade" . "http://marmalade-repo.org/packages/")
                            ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(defun load-user-file (file)
    (interactive "f")
    "Load a file in current user's configuration directory"
    (load-file (expand-file-name file user-init-dir)))


(load-user-file "fn.el")
(load-user-file "require.el")
(load-user-file "keybinding.el")
(load-user-file "prefs.el")

(load-user-file "prefs/org.el")
(load-user-file "prefs/evil.el")
(load-user-file "prefs/defaults.el")

(when (eq system-type 'darwin)
    (setq mac-command-modifier 'meta))

(custom-set-variables
    ;; custom-set-variables was added by Custom.
    ;; If you edit it by hand, you could mess it up, so be careful.
    ;; Your init file should contain only one such instance.
    ;; If there is more than one, they won't work right.
    '(TeX-newline-function (quote reindent-then-newline-and-indent))
    '(ansi-color-faces-vector
         [default bold shadow italic underline bold bold-italic bold])
    '(custom-safe-themes
         (quote
             ("1d9492749ca290d1702b2f331b99a2692cda19fb1e4aae4b9e75515027afbf3b" "1ba463f6ac329a56b38ae6ac8ca67c8684c060e9a6ba05584c90c4bffc8046c3" "784d5ee4d33befba6a21702ead67f98346770be7cc17ab64952ae3866a403743" "a774c5551bc56d7a9c362dca4d73a374582caedb110c201a09b410c0ebbb5e70" "60f04e478dedc16397353fb9f33f0d895ea3dab4f581307fbf0aa2f07e658a40" "a3e2f3fffac2887d98884789c501f9dd94d0a58eef818425011c9b8c77c8fa3e" "154250c2205fefd7c48215c88f5c226e44354dbdaf9815ea25e03f21a560c063" "53e29ea3d0251198924328fd943d6ead860e9f47af8d22f0b764d11168455a8e" "73fe242ddbaf2b985689e6ec12e29fab2ecd59f765453ad0e93bc502e6e478d6" "96efbabfb6516f7375cdf85e7781fe7b7249b6e8114676d65337a1ffe78b78d9" "e83c94a6bfab82536cef63610ec58d08dfddd27752d860763055daf58d028aad" "246a51f19b632c27d7071877ea99805d4f8131b0ff7acb8a607d4fd1c101e163" "1177fe4645eb8db34ee151ce45518e47cc4595c3e72c55dc07df03ab353ad132" "9c26d896b2668f212f39f5b0206c5e3f0ac301611ced8a6f74afe4ee9c7e6311" "968d1ad07c38d02d2e5debffc5638332696ac41af7974ade6f95841359ed73e3" "68769179097d800e415631967544f8b2001dae07972939446e21438b1010748c" "7fa9dc3948765d7cf3d7a289e40039c2c64abf0fad5c616453b263b601532493" "050beead9159996a613ba4bc734de8b13b882f1c6596d1dffa4f51d096662cf6" "88b663861db4767f7881e5ecff9bb46d65161a20e40585c8128e8bed8747dae5" "a68fa33e66a883ce1a5698bc6ff355b445c87da1867fdb68b9a7325ee6ea3507" "383806d341087214fd44864170161c6bf34a41e866f501d1be51883e08cb674b" "b8f561a188a77e450ab8a060128244c81dea206f15c1152a6899423dd607b327" "47583b577fb062aeb89d3c45689a4f2646b7ebcb02e6cb2d5f6e2790afb91a18" "3b1973119d3ca55a31abffd64cf6b7d12ce9de125ae07574dd43b90c5f9d5896" "f81e1ca8cefb9d4ded877d39f082c812294bcac41fce5be7230caa6cc83bde37" "e2513931db049905295c70d8a466dba4aad87c769de84474c9b2b9033b654b95" "bc078224bd6b94486f3437265699cb1e4f5e3b91a64f8e65ada8d7ec13fa3f52" "a5a1e3cd5f790846f4eec5fcff52935e5ef6d713a0f9342fef12eccfd9e9eff0" "5ce9c2d2ea2d789a7e8be2a095b8bc7db2e3b985f38c556439c358298827261c" "bad832ac33fcbce342b4d69431e7393701f0823a3820f6030ccc361edd2a4be4" "86b5f552577fab41d24f72cb5458bf9c9c87af65e89159c50c2b8cfb20bb3087" "79243bbd9c07f2baf551c2038009afc866da65fb8073a2efce3a469efc0c1bc5" "3b7e62b9884f1533f8eac5d21b252e5b8098274d7d9096521db84e4f10797ae3" "7a2c92b6267b84ae28a396f24dd832e29a164c1942f1f8b3fe500f1c25f8e09d" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "60a2ebd7effefeb960f61bc4772afd8b1ae4ea48fae4d732864ab9647c92093a" default)))
    '(magit-diff-use-overlays nil)
    '(magit-use-overlays nil)
    '(org-agenda-files (quote ("~/Dropbox/UCHICAGO4/recruitment/recruitment.org")))
    '(org-file-apps
         (quote
             ((auto-mode . emacs)
                 ("\\.mm\\'" . default)
                 ("\\.x?html?\\'" . default)
                 ("\\.pdf\\'" . "zathura %s"))))
    '(paradox-github-token t t)
    '(syslog-debug-face
         (quote
             ((t :background unspecified :foreground "#A1EFE4" :weight bold))))
    '(syslog-error-face
         (quote
             ((t :background unspecified :foreground "#F92672" :weight bold))))
    '(syslog-hour-face (quote ((t :background unspecified :foreground "#A6E22E"))))
    '(syslog-info-face
         (quote
             ((t :background unspecified :foreground "#66D9EF" :weight bold))))
    '(syslog-ip-face (quote ((t :background unspecified :foreground "#E6DB74"))))
    '(syslog-su-face (quote ((t :background unspecified :foreground "#FD5FF0"))))
    '(syslog-warn-face
         (quote
             ((t :background unspecified :foreground "#FD971F" :weight bold)))))

(add-to-list 'auto-mode-alist '("Gemfile" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))
(add-to-list 'auto-mode-alist '("conf$" . conf-mode))

(add-to-list 'auto-mode-alist '("conky" . rainbow-mode))
(add-to-list 'auto-mode-alist '("conky" . conf-space-mode))

(add-to-list 'auto-mode-alist '("rc$" . conf-mode))

(add-to-list 'auto-mode-alist '("\\.fsh$" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.vsh$" . glsl-mode))

(add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))

(setq lisp-indent-offset 4)
