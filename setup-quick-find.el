(use-package bind-key
  :ensure t)

(defun dired-timesort (filename &optional wildcards)
  (let ((dired-listing-switches "-lhat"))
    (dired filename wildcards)))

(defmacro quick-find (key file &optional path find-args)
  "Bind the KEY to the function."
  `(bind-key
    ,key
    (cond
     ((stringp ,find-args)
      '(lambda (&optional arg)
         (interactive)
         (find-dired (expand-file-name ,file ,path) ,find-args)))
     ((and
       ;; (not (tramp-tramp-file-p (expand-file-name ,file ,path)))
       (or (file-directory-p (expand-file-name ,file ,path))
           (not (file-exists-p (expand-file-name ,file ,path)))))
      '(lambda (&optional arg)
         (interactive)
         (dired-timesort (expand-file-name ,file ,path))))
     (t
      '(lambda (&optional arg)
         (interactive)
         (find-file (expand-file-name ,file ,path)))))))

(quick-find "C-h C-x C-b" "/home/psammandam/disk/office/bein/")
(quick-find "C-h C-x C-c" "~/disk/office/checkin/ctap")
(quick-find "C-h C-x C-i" user-init-file)
(quick-find "C-h C-x C-q" "/home/psammandam/disk/laptop-backup/emacs/setup-quick-find.el" )

(provide 'setup-quick-find)
;;; setup-quick-find.el ends here
