(use-package rtags
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
   (setq rtags-display-result-backend 'helm)
   (add-to-list 'company-backends 'company-rtags)
)

(provide 'setup-rtags)
