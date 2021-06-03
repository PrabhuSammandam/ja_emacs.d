;;; setup-flycheck --- Customization of flycheck
;;; Commentary:
;;; Code:

(use-package flycheck
  :ensure t
  :diminish ;;don't show in the mode line
  :init
  (add-hook 'prog-mode-hook #'flycheck-mode)
  :config
  (setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))
  (setq-default
   flycheck-display-errors-delay        0.3
   ;; flycheck-check-syntax-automatically  '(mode-enabled save)
   ;; flycheck-indication-mode             'right-fringe
   )
  ;; (setq-default flycheck-gcc-language-standard "c++11")
  ;; (setq-default flycheck-clang-language-standard "c++11")
  )

(provide 'setup-flycheck)
;;; setup-flycheck.el ends here
