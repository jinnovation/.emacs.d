(require 'mu4e)

;; default
(setq mu4e-maildir "~/mail")

(setq mu4e-drafts-folder "/[Gmail].Drafts")
(setq mu4e-sent-folder   "/[Gmail].Sent Mail")
(setq mu4e-trash-folder  "/[Gmail].Trash")
(setq mu4e-refile-folder "/[Gmail].All Mail")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; (See the documentation for `mu4e-sent-messages-behavior' if you have
;; additional non-Gmail addresses and want assign them different
;; behavior.)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
    '( ("/INBOX"               . ?i)
         ("/[Gmail].Sent Mail"   . ?s)
         ("/[Gmail].Trash"       . ?t)
         ("/[Gmail].All Mail"    . ?a)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; something about ourselves
(setq
    user-mail-address "jjin082693@gmail.com"
    user-full-name  "Jonathan Jin"
    mu4e-compose-signature
    (concat
        "Jonathan Jin\n"
        "http://jjin.me\n"))

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

;; (require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
    starttls-use-gnutls t
    smtpmail-starttls-credentials '(("smtp.gmail.com" 465 nil nil))
    smtpmail-auth-credentials
    '(("smtp.gmail.com" 465 "jjin082693@gmail.com" nil))
    smtpmail-default-smtp-server "smtp.gmail.com"
    smtpmail-smtp-server "smtp.gmail.com"
    smtpmail-smtp-service 465)

;; alternatively, for emacs-24 you can use:
;; (setq message-send-mail-function 'smtpmail-send-it
;;     smtpmail-stream-type 'starttls
;;     smtpmail-default-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-service 465)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

(setq
    mu4e-html-renderer 'w3m
    mu4e-html2text-command "w3m -dump -T text/html"
    mu4e-update-interval 300  
    )

(add-hook 'mu4e-index-updated-hook
    '(lambda ()
         (shell-command "notify-send 'Mail database updated.' &")))
