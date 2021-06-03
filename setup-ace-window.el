;;; ace-window --- Customisation of ace-window
;;; Commentary:
;;; Code:

(use-package ace-window
  :ensure t
  :bind
  ("M-o" . ace-window)
  :config
  ;; (setq aw-dispatch-always t)
  (setq aw-ignore-current t)
  )
(provide 'setup-ace-window)
;;; setup-ace-window.el ends here
