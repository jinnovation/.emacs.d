;;; init-fn.el --- configuration functions

(provide 'init-fn)

(defmacro after (mode &rest body)
  "`eval-after-load' MODE evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,mode
     '(progn ,@body)))

(defmacro if-package-installed (package-name &rest body)
  "`eval-after-load' PACKAGE-NAME-autoloads evaluate BODY."
  `(after (concat ,package-name "-autoloads") ,@body))

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

;; Set transparency of emacs
(defun set-transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value (0 - 100 opaque): ")
  (set-frame-parameter (selected-frame) 'alpha value))

(defun enlarge-window-horizontally-repeatable (&optional inc)
  (interactive)
  (let* ((step (if inc inc 5)))
    (enlarge-window-horizontally step)))

(defun package-install-from-list (list)
  (package-refresh-contents)
  (dolist (package list)
    (unless (package-installed-p package)
      (package-install package))))

(defun projectile-save-and-test (arg)
  "Saves the current buffer, and then run project test command.

Normally, this immediately runs the default Projectile project test command;
`make test` for Makefile projects, etc. You can force prompt with a prefix ARG."
  (interactive "P")
  (save-buffer)
  (let* ((compilation-read-command (if arg t nil)))
    (projectile-test-project arg)))

(defun my-gnus-group-list-subscribed-groups ()
  "List all subscribed groups with or without un-read messages"
  (interactive)
  (gnus-group-list-all-groups 5))

(defun dired-at-current ()
  (interactive)
  (dired default-directory))

(defun prev-window ()
  (interactive)
  (other-window -1))

;;; init-fn.el ends here
