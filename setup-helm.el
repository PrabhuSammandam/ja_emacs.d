;;; setup-helm --- Custom helm setup
;;; Commentary:
;;; Code:

(use-package helm
  :ensure t
  :diminish
  :init
  (helm-mode)
 ;; (progn
    ;; (require 'helm-config)
  ;;  )
  :bind(
	("M-x" . helm-M-x)
	("M-y" . helm-show-kill-ring)
	("<f12>". helm-mini)
	("C-x C-f" . helm-find-files)
	([remap isearch-occur] . helm-occur) ;; remapping the inbuild isearch-occur with helm-occur
	("M-s o" . helm-occur)
	:map helm-map
	("<tab>" . helm-execute-persistent-action)
	("C-z" . helm-select-action)
	:map minibuffer-local-map
	("M-n" . helm-minibuffer-history)
	("M-p" . helm-minibuffer-history)
	)
  :config
  (setq helm-echo-input-in-header-line t)
  (setq helm-split-window-inside-p t);open helm buffer inside current window, not occupy whole other window
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 20)

  (setq helm-boring-file-regexp-list
	(append
	 '("\\.cquery_cached_index\\(/\\|$\\)")
	 helm-boring-file-regexp-list
	 )
	)
  (setq helm-ff-skip-boring-files t)

  (setq helm-boring-buffer-regexp-list
	(append
	 '(".*\.o$")
	 helm-boring-buffer-regexp-list
	 )
	)
  (setq helm-skip-boring-buffers t)

)

(provide 'setup-helm)
;;; setup-helm.el ends here
