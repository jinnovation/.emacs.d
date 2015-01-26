(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

(defconst bg-color "black")
(defconst default-font "Terminus 12")
(defconst linum-mode-excludes
    '(doc-view-mode magit-mode)
    "List of major modes preventing linum to be enabled in the buffer.")
