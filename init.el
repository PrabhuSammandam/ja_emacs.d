;;===============================================================================
;; USE-PACKAGE INITIALIZATION
;;===============================================================================
(require 'package)

(add-to-list 'package-archives
         '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")
;;===============================================================================
;; USE-PACKAGE INITIALIZATION
;;===============================================================================


;;--------------------------GLOBAL KEY-BINDINGS----------------------------------
(global-set-key (kbd "s-x") 'kill-this-buffer)
(global-set-key (kbd "s-d") 'dired)
(global-set-key (kbd "s-o") 'ace-window)
;;--------------------------GLOBAL KEY-BINDINGS----------------------------------

(add-hook 'after-init-hook 'global-company-mode)
(setq-default case-fold-search nil)

(require 'setup-helm)
(require 'uncrustify)

(use-package company
  :init
  (setq global-company-mode t)
  :ensure t
  )

(use-package company-rtags)
;;(use-package flycheck)
;;(use-package flycheck-rtags)

(require 'setup-projectile)

(require 'setup-rtags)
(require 'setup-magit)

(use-package highlight-symbol
  :ensure t
  :init
  (add-hook 'c-mode-hook #'highlight-symbol-mode)
  (add-hook 'c++-mode-hook #'highlight-symbol-mode)
  (add-hook 'objc-mode-hook #'highlight-symbol-mode)
  )

(use-package helm-rtags)

(use-package flycheck
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'flycheck-mode)
  :config
  (setq-default
	flycheck-display-errors-delay        0.3
	flycheck-check-syntax-automatically  '(mode-enabled save)
	flycheck-indication-mode             'right-fringe
	)
  (setq-default flycheck-gcc-language-standard "c++11")
  (setq-default flycheck-clang-language-standard "c++11")
  )

(use-package flycheck-rtags
  :ensure t
  :after flycheck rtags
  :config
  (defun my-flycheck-rtags-setup ()
	 (flycheck-select-checker 'rtags)
	 (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
	 (setq-local flycheck-check-syntax-automatically nil)
	 )
  (add-hook 'c-mode-hook #'my-flycheck-rtags-setup)
  (add-hook 'c++-mode-hook #'my-flycheck-rtags-setup)
  (add-hook 'objc-mode-hook #'my-flycheck-rtags-setup)
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(custom-safe-themes
	(quote
	 ("3860a842e0bf585df9e5785e06d600a86e8b605e5cc0b74320dfe667bcbe816c" "8b4d8679804cdca97f35d1b6ba48627e4d733531c64f7324f764036071af6534" "274fa62b00d732d093fc3f120aca1b31a6bb484492f31081c1814a858e25c72e" default)))
 '(custom-enabled-themes (quote ("274fa62b00d732d093fc3f120aca1b31a6bb484492f31081c1814a858e25c72e")))
 '(load-theme (quote ("grandshell")))
 '(gdb-enable-debug t)
 '(gdb-many-windows nil)
 '(gdb-show-main t)
 '(highlight-symbol-idle-delay 0.5)
 '(menu-bar-mode nil)
 '(package-selected-packages
	(quote
	 (ggtags helm-gtags grandshell-theme flatui-dark-theme dracula-theme realgud ace-window flycheck-rtags flycheck cmake-font-lock cmake-ide cmake-mode cmake-project helm-rtags company-rtags highlight-symbol magit rtags projectile company helm use-package)))
 '(projectile-globally-ignored-directories
	(quote
	 (".cquery_cached_index" ".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work")))
 '(projectile-globally-ignored-file-suffixes (quote (".o")))
 '(projectile-indexing-method (quote native))
 '(rtags-periodic-reparse-timeout 1)
 '(rtags-symbolnames-case-insensitive t)
 '(show-paren-mode t)
 '(tab-width 3)
 '(tool-bar-mode nil))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:inherit default :background "wheat" :foreground "black")))))

(put 'narrow-to-region 'disabled nil)

(add-hook 'c-mode-hook
	       (lambda ()
				(unless (or (file-exists-p "make_evo")
								(file-exists-p "make_evo"))
				  (set (make-local-variable 'compile-command) "./make_evo release hmgtb1 process=epg "))))

;;-------------
;;Add color to the current GUD line (obrigado google)

(defvar gud-overlay
  (let* ((ov (make-overlay (point-min) (point-min))))
	 (overlay-put ov 'face 'secondary-selection)
	 ov)
  "Overlay variable for GUD highlighting.")

(defadvice gud-display-line (after my-gud-highlight act)
  "Highlight current line."
  (let* ((ov gud-overlay)
			(bf (gud-find-file true-file)))
	 (with-current-buffer bf
		(move-overlay ov (line-beginning-position) (line-beginning-position 2)
						  ;;(move-overlay ov (line-beginning-position) (line-end-position)
						  (current-buffer)))))

(defun gud-kill-buffer ()
  "kill the GUD buffer"
  (if (derived-mode-p 'gud-mode)
		(delete-overlay gud-overlay)))

(add-hook 'kill-buffer-hook 'gud-kill-buffer)
;;-------------------------------------------------------------

(defun ja/kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun ja/kill-dired-buffers ()
  (interactive)
  (mapc (lambda (buffer) 
			 (when (eq 'dired-mode (buffer-local-value 'major-mode buffer)) 
				(kill-buffer buffer))) 
		  (buffer-list)))
