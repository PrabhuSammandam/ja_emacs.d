;;; setup-helm-swoop -- Customization of helm swoop
;;; Commentary:
;;; Code:

(use-package helm-swoop
  :ensure t
  :bind(
        ("M-i" . helm-swoop)
        ("M-I" . helm-swoop-back-to-last-point)
        :map helm-swoop-map
        ("C-r" . helm-previous-line)
        ("C-s" . helm-next-line)
        ("M-m" . helm-multi-swoop-current-mode-from-helm-swoop);; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode

        ("M-i" . helm-multi-swoop-all-from-helm-swoop) ;; From helm-swoop to helm-multi-swoop-all

        :map helm-multi-swoop-map
        ("C-r" . helm-previous-line)
        ("C-s" . helm-next-line)
        :map isearch-mode-map
        ("M-i" . helm-swoop-from-isearch);; When doing isearch, hand the word over to helm-swoop

        
        )
  :config
  ;; Save buffer when helm-multi-swoop-edit complete
  (setq helm-multi-swoop-edit-save t)

  ;; If this value is t, split window inside the current window
  (setq helm-swoop-split-with-multiple-windows nil)

  ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
  (setq helm-swoop-split-direction 'split-window-horizontally)

  ;; If nil, you can slightly boost invoke speed in exchange for text color
  (setq helm-swoop-speed-or-color nil)

  ;; ;; Go to the opposite side of line from the end or beginning of line
  (setq helm-swoop-move-to-line-cycle t)

  ;; Optional face for line numbers
  ;; Face name is `helm-swoop-line-number-face`
  (setq helm-swoop-use-line-number-face t)

  ;; If you prefer fuzzy matching
  (setq helm-swoop-use-fuzzy-match t)
  )

(provide 'setup-helm-swoop)
;;; setup-helm-swoop.el ends here

