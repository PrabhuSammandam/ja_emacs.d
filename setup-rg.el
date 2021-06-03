;;; set-rg -- Custom rg setup
;;; Commentary:
;;; Code:

(use-package rg
  :ensure t
  :config
  (rg-enable-default-bindings)
  (setq rg-custom-type-aliases
   (quote
    (("ctap" . "*.tmpl *.xml *.part *.js")
     ("tmpl" . "*.tmpl *.xml"))))
  )

(provide 'setup-rg)

;;; setup-rg.el ends here

