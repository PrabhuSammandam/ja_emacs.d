;;; setup-rtags.el --- Setting rtags
;;; Commentary:
;;; Code:

(require 'rtags)
(require 'flycheck-rtags)
(require 'company-rtags)

(add-hook 'c-mode-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
(add-hook 'objc-mode-hook 'rtags-start-process-unless-running)

(define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
(define-key c-mode-base-map (kbd "M-,") 'rtags-find-all-references-at-point)
(define-key c-mode-base-map (kbd "M-<left>") 'rtags-location-stack-back)
(define-key c-mode-base-map (kbd "M-<right>") 'rtags-location-stack-forward)
(define-key c-mode-base-map (kbd "M-l") 'rtags-imenu )
(define-key c-mode-base-map (kbd "M-RET") (function company-complete))
(define-key c-mode-base-map (kbd "M-]") 'rtags-next-match )
(define-key c-mode-base-map (kbd "M-[") 'rtags-previous-match )
(define-key c-mode-base-map (kbd "M-'") 'rtags-references-tree )

(rtags-enable-standard-keybindings c-mode-base-map "s-;")
(setq rtags-autostart-diagnostics t)
(setq rtags-completions-enabled t)
(setq rtags-periodic-reparse-timeout 1)
(setq rtags-symbolnames-case-insensitive t)
(setq rtags-find-file-case-insensitive t)
(setq rtags-display-result-backend 'helm)
(setq rtags-show-containing-function t)
(setq rtags-wildcard-symbol-names t)
(setq rtags-imenu-syntax-highlighting nil)
(setq rtags-print-filenames-relative t)


(add-to-list 'company-backends 'company-rtags)
(global-company-mode)

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

(use-package eldoc
:diminish eldoc-mode
:init (add-hook 'prog-mode-hook #'rtags-eldoc-mode)
)

(defun my-flycheck-rtags-setup ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil))
(add-hook 'c-mode-hook #'my-flycheck-rtags-setup)
(add-hook 'c++-mode-hook #'my-flycheck-rtags-setup)
(add-hook 'objc-mode-hook #'my-flycheck-rtags-setup)

(provide 'setup-rtags)
;;; setup-rtags.el ends here
