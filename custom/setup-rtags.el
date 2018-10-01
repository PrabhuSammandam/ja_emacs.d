(use-package rtags
  :init
  (progn
  (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
  (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
  (add-hook 'objc-mode-hook 'rtags-start-process-unless-running)
  (add-to-list 'company-backends 'company-rtags)
  )
  
:config
(rtags-enable-standard-keybindings)
(setq rtags-autostart-diagnostics t)
(setq rtags-completions-enabled t)
(setq rtags-display-result-backend 'helm)
(add-to-list 'company-backends 'company-rtags)
(define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
(define-key c-mode-base-map (kbd "M-,") 'rtags-find-all-references-at-point)
(define-key c-mode-base-map (kbd "M-?") 'rtags-display-summary)
)

(use-package company-rtags
)

(use-package helm-rtags
  )

(provide 'setup-rtags)
