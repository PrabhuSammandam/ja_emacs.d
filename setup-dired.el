;;; setup-dired --- Customisation of dired package
;;; Commentary:
;;; Code:

(add-hook 'dired-mode-hook
	  (lambda ()
	    ;; Set dired-x buffer-local variables here.  For example:
	    ;; (dired-recent-mode 1)
	    ;; (dired-omit-mode 1)
;;            (dired-hide-details-mode 1)
	    ))

(eval-after-load "dired" '(progn
			    (define-key dired-mode-map (kbd "M-<up>")
			      (lambda ()
				(interactive)
				(find-alternate-file "..")))
			    ))

(eval-after-load "dired" '(progn
			    (define-key dired-mode-map (kbd "<tab>")
			      (lambda ()
				(interactive)
				(dired-find-file)))
			    ))

;; In order to have dired-jump and dired-jump-other-window (see Miscellaneous Commands) work before dired and dired-x have been properly loaded you should set-up an autoload for these functions.

(autoload 'dired-jump "dired-x"
  "Jump to Dired buffer corresponding to current buffer." t)

(autoload 'dired-jump-other-window "dired-x"
  "Like \\[dired-jump] (dired-jump) but in other window." t)

(global-set-key "\C-cf" (quote find-name-dired))

(define-key global-map "\C-x\C-j" 'dired-jump)
(define-key global-map "\C-x4\C-j" 'dired-jump-other-window)

(provide 'setup-dired)
;;; setup-dired.el ends here
