;;; init-mu4e.el --- mu4e-specific configurations
(provide 'init-mu4e)

(require 'mu4e)

(after 'mu4e
  
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
    
    ;; setup some handy shortcuts
    ;; you can quickly switch to your Inbox -- press ``ji''
    ;; then, when you want archive some messages, move them to
    ;; the 'All Mail' folder by pressing ``ma''.
  (setq mu4e-maildir-shortcuts
    '( ("/INBOX"               . ?i)
       ("/[Gmail].Sent Mail"   . ?s)
       ("/[Gmail].Trash"       . ?t)
       ("/[Gmail].All Mail"    . ?a)))
    
  (setq
    user-mail-address "jjin082693@gmail.com"
    user-full-name  "Jonathan Jin")
    
    ;; allow for updating mail using 'U' in the main view:
  (setq mu4e-get-mail-command "offlineimap")
    
  (setq mu4e-user-mail-address-list
    '("jjin082693@gmail.com"
       "jjin082693@uchicago.edu"
       "jonathan@jjin.me"))
    
  (setq mu4e-compose-signature
    (concat
      "Jonathan Jin\n"
      "http://jjin.me\n"))

  (setq
    ;; don't keep message buffers around
    message-kill-buffer-on-exit t
    
    mu4e-html-renderer 'w3m
    mu4e-html2text-command "w3m -dump -T text/html")

  ;; sending mail -- replace USERNAME with your gmail username
  ;; also, make sure the gnutls command line utils are installed
  ;; package 'gnutls-bin' in Debian/Ubuntu

  ;; (require 'smtpmail)
  (setq
    message-send-mail-function 'smtpmail-send-it
    smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
    smtpmail-auth-credentials '(("smtp.gmail.com" 587
                                  "jjin082693@gmail.com" nil))
    smtpmail-smtp-server "smtp.gmail.com"
    smtpmail-smtp-service 587))

  ;; alternatively, for emacs-24 you can use:
  ;; (setq message-send-mail-function 'smtpmail-send-it
  ;;     smtpmail-stream-type 'starttls
  ;;     smtpmail-default-smtp-server "smtp.gmail.com"
  ;;     smtpmail-smtp-server "smtp.gmail.com"
  ;;     smtpmail-smtp-service 465)

;;; init-mu4e.el ends here
