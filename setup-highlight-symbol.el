;;; setup-highlight-symbol --- customization of highlight-symbol
;;; Commentary:
;;; Code:

(use-package highlight-symbol
  :ensure t
  :init
  (add-hook 'c-mode-hook #'highlight-symbol-mode)
  (add-hook 'c++-mode-hook #'highlight-symbol-mode)
  (add-hook 'objc-mode-hook #'highlight-symbol-mode)
  )

(provide 'setup-highlight-symbol)
;;; setup-highlight-symbol.el ends here
