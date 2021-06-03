;;; my_util --- Custom functions
;;; Commentary:
;;; Code:

(defun ja/restart-dctap()
  "Restarts the locally running dctap"
  (interactive "@")
  (let ((curDir default-directory))
    (shell-command (concat "sdc.sh "  " 2>&1 > /dev/null & disown") nil nil)
    (kill-buffer "*Shell Command Output*")
    )
  )

(defun ja/load-dmt-v2()
  "Loads the DMT v2 box"
  (interactive "@")
  (let ((curDir default-directory))
    (shell-command (concat "load-dmtv2.sh "  " 2>&1 > /dev/null & disown") nil nil)
    (kill-buffer "*Shell Command Output*")
    )
  )

(defun ja/perle()
  "Controls the perle plugs"
  (interactive "@")
  (let ((curDir default-directory))
    (shell-command (concat "perle.py " "5" " 2>&1 > /dev/null & disown") nil nil)
    (kill-buffer "*Shell Command Output*")
    )
  )

(defun ja/open-konsole()
  "open konsole"
  (interactive "@")
  (let ((curDir default-directory))
    (shell-command (concat "konsole " "--hide-menubar " "--hide-tabbar " "--separate " "--workdir \"" curDir "\" 2>&1 > /dev/null & disown") nil nil)
    (kill-buffer "*Shell Command Output*")
    )
  )

(defun ja/get-line-for-breakpoint ()
  "Copy current line in file to clipboard as '</path/to/file>:<line-number>'"
  (interactive)
  (let ((path-with-line-number
	 (concat (buffer-file-name) ":" (number-to-string (line-number-at-pos)))))
    (kill-new path-with-line-number)
    (message (concat path-with-line-number " copied to clipboard")))
  )

(defun ja/kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun ja/kill-dired-buffers ()
  (interactive)
  (mapc (lambda (buffer) 
	  (when (eq 'dired-mode (buffer-local-value 'major-mode buffer)) 
	    (kill-buffer buffer))) 
	(buffer-list)))

(defun mark-whole-word (&optional arg allow-extend)
  "Like `mark-word', but selects whole words and skips over whitespace.
If you use a negative prefix arg then select words backward.
Otherwise select them forward.

If cursor starts in the middle of word then select that whole word.

If there is whitespace between the initial cursor position and the
first word (in the selection direction), it is skipped (not selected).

If the command is repeated or the mark is active, select the next NUM
words, where NUM is the numeric prefix argument.  (Negative NUM
selects backward.)"
  (interactive "P\np")
  (let ((num  (prefix-numeric-value arg)))
    (unless (eq last-command this-command)
      (if (natnump num)
          (skip-syntax-forward "\\s-")
        (skip-syntax-backward "\\s-")))
    (unless (or (eq last-command this-command)
                (if (natnump num)
                    (looking-at "\\b")
                  (looking-back "\\b")))
      (if (natnump num)
          (left-word)
        (right-word)))
    (mark-word arg allow-extend)))


(global-set-key [remap mark-word] 'mark-whole-word)

(defun smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(control shift return)] 'smart-open-line-above)

(defun ja/find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))

(global-set-key (kbd "C-c I") 'ja/find-user-init-file)

(defun ja/smart-kill-whole-line (&optional arg)
  "A simple wrapper around `kill-whole-line that respects indentation."
  (interactive "P")
  (kill-whole-line arg)
  (back-to-indentation))

(global-set-key [remap kill-whole-line] 'ja/smart-kill-whole-line)

(require 'ediff-trees)

(eval
 `(defun ediff-directories-recursive (dir1 dir2 regexp)
    "Like `ediff-directories' but recurses into sub-directories. Does not follow symbolic links."
    ,(interactive-form (symbol-function 'ediff-directories))
    (let ((directory-files-original (symbol-function 'directory-files)))
      (unwind-protect
      (progn
        (fset 'directory-files (symbol-function 'directory-files-recursive))
        (ediff-directories dir1 dir2 regexp)
        (fset 'directory-files directory-files-original))))))

(eval
 (let ((directory-files-original (symbol-function 'directory-files)))


   `(defun directory-files-recursive (directory &optional full match nosort)
      "Like `directory-files' but recurses into subdirectories. Does not follow symbolic links."
      (let* ((prefix (or (and full "") directory))
         dirs
         files)
    (mapc (lambda (p)
        (let ((fullname (if full p (concat prefix "/" p))))
          (when (and (file-directory-p fullname)
                 (null (or (string-match "\\(^\\|/\\).$" p)
                       (string-match "\\(^\\|/\\)..$" p)
                       (file-symlink-p fullname))))
            (setq dirs (cons p dirs)))))
          (funcall ,directory-files-original directory full nil nosort))
    (setq dirs (nreverse dirs))
    (mapc (lambda (p)
        (when (null (file-directory-p (if full p (concat prefix "/" p))))
          (setq files (cons p files))))
          (funcall ,directory-files-original directory full match nosort))
    (setq files (nreverse files))
    (mapc (lambda (d)
        (setq files
              (append files
                  (if full
                  (apply 'directory-files-recursive (list d full match nosort))
                (mapcar (lambda (n)
                      (concat d "/" n))
                    (apply 'directory-files-recursive (list (concat prefix "/" d) full match nosort)))))))
          dirs)
    files))))

(defun recentd-track-opened-file ()
  "Insert the name of the directory just opened into the recent list."
  (and (derived-mode-p 'dired-mode) default-directory
       (recentf-add-file default-directory))
  ;; Must return nil because it is run from `write-file-functions'.
  nil)

(defun recentd-track-closed-file ()
  "Update the recent list when a dired buffer is killed.
That is, remove a non kept dired from the recent list."
  (and (derived-mode-p 'dired-mode) default-directory
       (recentf-remove-if-non-kept default-directory)))

(add-hook 'dired-after-readin-hook 'recentd-track-opened-file)
(add-hook 'kill-buffer-hook 'recentd-track-closed-file)

(defun my-generate-tab-stops (&optional width max)
  "Return a sequence suitable for `tab-stop-list'."
  (let* ((max-column (or max 200))
         (tab-width (or width tab-width))
         (count (/ max-column tab-width)))
    (number-sequence tab-width (* tab-width count) tab-width)))

(setq tab-width 4)
(setq tab-stop-list (my-generate-tab-stops))

(provide 'my_util)
;;; my_util.el ends here
