;;; setup-rtags.el --- Setting rtags
;;; Commentary:
;;; Code:

(use-package rtags
  :ensure t
  :init
  (progn
    (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
    (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
    (add-hook 'objc-mode-hook 'rtags-start-process-unless-running)
    )
  :bind(
	:map c-mode-base-map
	("M-." . rtags-find-symbol-at-point)
	("M-," . rtags-find-all-references-at-point)
	("M-<left>" . rtags-location-stack-back)
	("M-<right>" . rtags-location-stack-forward)
	("M-l" . rtags-imenu)
	)

  :config
  (rtags-enable-standard-keybindings)
  (setq rtags-autostart-diagnostics t)
  (setq rtags-completions-enabled t)
  (setq rtags-periodic-reparse-timeout 1)
  (setq rtags-symbolnames-case-insensitive t)
  (setq rtags-display-result-backend 'helm)
  (add-to-list 'company-backends 'company-rtags)
  (defun fontify-string (str mode)
    "Return STR fontified according to MODE."
    (with-temp-buffer
      (insert str)
      (delay-mode-hooks (funcall mode))
      (font-lock-default-function mode)
      (font-lock-default-fontify-region
       (point-min) (point-max) nil)
      (buffer-string)))
  (defun rtags-eldoc-function ()
    (let ((summary (rtags-get-summary-text)))
      (and summary
	   (fontify-string
	    (replace-regexp-in-string
	     "{[^}]*$" ""
	     (mapconcat
	      (lambda (str) (if (= 0 (length str)) "//" (string-trim str)))
	      (split-string summary "\r?\n")
	      " "))
	    major-mode))))
  (defun rtags-eldoc-mode ()
    (interactive)
    (setq-local eldoc-documentation-function #'rtags-eldoc-function)
    (eldoc-mode 1))

  ;; (use-package eldoc
    ;; :diminish eldoc-mode
    ;; :init (add-hook 'prog-mode-hook #'rtags-eldoc-mode)
    ;; )
  )

(provide 'setup-rtags_by_package)
;;; setup-rtags.el ends here
