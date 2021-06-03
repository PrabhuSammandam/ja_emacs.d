;;; setup-spice-mode --- Custom spice mode setup
;;; Commentary:
;;; Code:

(use-package spice-mode
  :ensure t
  :mode "\\.cir$" "\\.ckt$" "\\.net$" "\\.mod$" "\\.cdl$" "\\.chi$" "\\.inp$" "\\.sub$"
  )

(provide 'setup-spice-mode)
;;; setup-spice-mode.el ends here
