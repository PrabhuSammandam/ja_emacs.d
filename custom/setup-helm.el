(use-package helm
  :init
  (progn
    (require 'helm-config)
    (helm-mode 1)

;;    (global-set-key (kbd "C-x C-f") 'helm-find-files)
;;    (global-set-key (kbd "C-c r") 'helm-recentf)
;;    (global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
;;    (global-set-key (kbd "C-c h o") 'helm-occur)

;;    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
;;    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
;;    (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
;;    (define-key global-map [remap list-buffers] 'helm-buffers-list)
;;    (define-key global-map [remap find-file] 'helm-find-files)

    ;; show minibuffer history with Helm
;;    (define-key minibuffer-local-map (kbd "M-p") 'helm-minibuffer-history)
;;    (define-key minibuffer-local-map (kbd "M-n") 'helm-minibuffer-history)

    )
  :bind(
	("M-x" . helm-M-x)
	("M-y" . helm-show-kill-ring)
	("C-x b". helm-mini)
	("C-x C-f" . helm-find-files)
	)
  :config
  (setq helm-echo-input-in-header-line t)
  (setq helm-split-window-in-side-p t);open helm buffer inside current window, not occupy whole other window
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
