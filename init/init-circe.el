;;; init-circe.el --- circe and IRC configs

(provide 'init-circe)

(setq
  circe-default-nick "jjin"
  circe-default-user "jjin"
  circe-default-part-message "Peace."
  circe-default-quit-message "Peace.")

(setq circe-use-cycle-completion t
  circe-reduce-lurker-spam t)

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

(setq
  circe-format-self-say "<{nick}> {body}"
  circe-format-server-topic "*** Topic change by {origin}: {topic-diff}")

(add-hook 'circe-chat-mode-hook 'my-circe-prompt)
(defun my-circe-prompt ()
  (lui-set-prompt
    (concat (propertize (concat (buffer-name) ">")
              'face 'circe-prompt-face)
      " ")))

(enable-circe-color-nicks)
(setq circe-color-nicks-everywhere t)

;;; init-circe.el ends here
