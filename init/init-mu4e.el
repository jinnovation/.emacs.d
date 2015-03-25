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

  (setq mu4e-compose-signature
    (concat
      "Jonathan Jin\n"
      "github.com/jinnovation\n"
      "jjin.me\n"))

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
    smtpmail-smtp-service 587))

;;; init-mu4e.el ends here
