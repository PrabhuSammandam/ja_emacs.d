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
;;--------------------------GLOBAL KEY-BINDINGS----------------------------------

(require 'setup-helm)
(require 'uncrustify)

(use-package company
  :ensure t
  :config
  (setq global-company-mode t)
 )

(require 'setup-projectile)
(require 'setup-rtags)
(require 'setup-magit)

(use-package highlight-symbol)

(use-package helm-rtags)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (adwaita)))
 '(global-hl-line-mode t)
 '(menu-bar-mode nil)
 '(package-selected-packages
	(quote
	 (helm-rtags company-rtags highlight-symbol magit rtags projectile company helm use-package)))
 '(show-paren-mode t)
 '(tab-width 3)
 '(tool-bar-mode nil))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:inherit default :background "wheat" :foreground "black")))))

