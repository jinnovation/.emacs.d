(defun kill-current-buffer ()
    (interactive)
    (kill-buffer (current-buffer)))

(defun lock-window ()
    "Prevents frame from being used to display any other buffer"
    (interactive)
    (set-window-dedicated-p (frame-selected-window) t))

(defun window-toggle-split-direction ()
    "Switch window split from horizontally to vertically, or vice versa.

i.e. change right window to bottom, or change bottom window to right."
    (interactive)
    (require 'windmove)
    (let ((done))
        (dolist (dirs '((right . down) (down . right)))
            (unless done
                (let* ((win (selected-window))
                          (nextdir (car dirs))
                          (neighbour-dir (cdr dirs))
                          (next-win (windmove-find-other-window nextdir win))
                          (neighbour1 (windmove-find-other-window neighbour-dir win))
                          (neighbour2 (if next-win (with-selected-window next-win
                                                       (windmove-find-other-window
                                                           neighbour-dir next-win)))))

                    (setq done (and (eq neighbour1 neighbour2)
                                   (not (eq (minibuffer-window) next-win))))
                    (if done
                        (let* ((other-buf (window-buffer next-win)))
                            (delete-window next-win)
                            (if (eq nextdir 'right)
                                (split-window-vertically)
                                (split-window-horizontally))
                            (set-window-buffer (windmove-find-other-window neighbour-dir)
                                other-buf))))))))
(defun vsplit-last-buffer ()
    (interactive)
    (split-window-vertically)
    (other-window 1 nil)
    (switch-to-next-buffer))

(defun hsplit-last-buffer ()
    (interactive)
    (split-window-horizontally)
    (other-window 1 nil)
    (switch-to-next-buffer))

(defun reload-config ()
    (interactive)
    (load-file user-init-file))

(defun edit-config ()
    (interactive)
    (find-file user-init-file))

(defun insert-newline-after ()
    (interactive)
    (let ((oldpos (point)))
        (end-of-line)
        (newline-and-indent)
        (goto-char oldpos)))
