;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; the blinking cursor is nothing, but an annoyance
(blink-cursor-mode -1)

;; smart tab behavior - indent or complete
(setq tab-always-indent 'complete)
(setq-default indent-tabs-mode nil)

(global-auto-revert-mode)
(menu-bar-mode -1)
(tool-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)
(show-paren-mode 1)
(recentf-mode 1)

;;--------------------------GLOBAL KEY-BINDINGS----------------------------------
(global-set-key (kbd "s-x") 'kill-this-buffer)
(global-set-key (kbd "s-d") 'dired)

;;--------------------------GLOBAL KEY-BINDINGS----------------------------------

(add-to-list 'auto-mode-alist '("SConstruct" . python-mode))
(add-to-list 'auto-mode-alist '("SConscript" . python-mode))

(setq recentf-max-saved-items 500)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(setq-default column-number-mode t)
(setq-default font-use-system-font t)
(setq-default size-indication-mode t)
(setq-default display-line-numbers t)
;; (setq-default case-fold-search nil)

(setq-default dired-always-read-filesystem t)
(setq dired-auto-revert-buffer (quote dired-directory-changed-p))
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(setq dired-listing-switches "-laGh1v --group-directories-first")
(put 'narrow-to-region 'disabled nil)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq tab-width 4)

;;; Rings and registers
(setq kill-ring-max 200                 ; More killed items
      kill-do-not-save-duplicates t     ; No duplicates in kill ring
      ;; Save the contents of the clipboard to kill ring before killing
      save-interprogram-paste-before-kill t)

(add-hook 'c-mode-hook
	  (lambda ()
	    (unless (or (file-exists-p "make_evo")
			(file-exists-p "make_evo"))
	      (set (make-local-variable 'compile-command) "./make_evo release tszhub1 DVRLITE=on DISABLE_JAILING_ONOFF=OFF MAKE=/usr/bin/make 2>&1 | tee compile.log "))))

;; don't start another frame
;; this is done by default in preluse
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; put windows side by side
(setq ediff-split-window-function (quote split-window-horizontally))
;;revert windows on exit - needs winner mode
(winner-mode)
(add-hook 'ediff-after-quit-hook-internal 'winner-undo)

(provide 'config-common)
