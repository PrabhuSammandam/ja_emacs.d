;;; set-rg -- Custom rg setup
;;; Commentary:
;;; Code:

(use-package flycheck-clang-tidy
  :ensure t
  :after flycheck
  :hook
  (flycheck-mode . flycheck-clang-tidy-setup)
  )

(use-package flycheck-clang-analyzer
  :ensure t
  :after flycheck
  :config
  (flycheck-clang-analyzer-setup)
  )

(use-package meson-mode
  :ensure t
  )

(use-package clang-capf
  :ensure t
  )

(use-package quelpa
  :ensure t
  )

(use-package quelpa-use-package
  :ensure t
  )

(use-package clang-format
  :ensure t
  )


(provide 'setup-common)

;;; setup-rg.el ends here

