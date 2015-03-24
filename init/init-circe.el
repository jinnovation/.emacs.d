;;; init-circe.el --- circe and IRC configs

(provide 'init-circe)

(require 'lui-autopaste)

(setq circe-default-nick "jjin")

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

(setq circe-reduce-lurker-spam t)
(setq circe-format-server-topic "*** Topic change by {origin}: {topic-diff}")

(add-hook 'circe-channel-mode-hook 'enable-lui-autopaste)

(add-hook 'circe-chat-mode-hook 'my-circe-prompt)
(defun my-circe-prompt ()
  (lui-set-prompt
    (concat (propertize (concat (buffer-name) ">")
              'face 'circe-prompt-face)
      " ")))

;;; init-circe.el ends here
