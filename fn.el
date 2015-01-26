(defun kill-current-buffer ()
    (interactive)
    (kill-buffer (current-buffer)))

(defun lock-window ()
    "Prevents frame from being used to display any other buffer"
    (interactive)
    (set-window-dedicated-p (frame-selected-window) t))
