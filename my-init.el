(require 'package)

(add-to-list 'package-archives
         '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; (setq my-emacs-path "~/disk/laptop-backup/emacs/")
(setq my-emacs-path (getenv "EMACS_PATH"))
(setq my-rtags-path "/home/psammandam/disk/sources/src/rtags/")

(setq my-load-path (list (concat my-emacs-path "dired-du")
                         (concat my-emacs-path "shell-here")
                         (concat my-rtags-path "src")))

(setq load-path (append my-load-path  load-path) )

(require 'config-common)

(add-hook 'after-init-hook (lambda () (load-theme 'leuven)))
;; (add-hook 'after-init-hook (lambda () (load-theme 'spacemacs-dark)))

(require 'setup-helm)
(require 'setup-ace-window)
(require 'setup-projectile)
(require 'setup-helm-rg)
(require 'setup-rg)
(require 'setup-quick-find)
(require 'my_util)
(require 'setup-company)
(require 'setup-highlight-symbol)
(require 'setup-magit)
(require 'setup-util-packages)
(require 'setup-spice-mode)
(require 'setup-flycheck)
(require 'setup-helm-projectile)
(require 'setup-helm-swoop)
(require 'setup-dired)

;; package configs
(setq dired-du-size-format t)
(require 'dired-du)
(require 'thingatpt)
(require 'uncrustify)
(require 'shell-here)

;; ;; Loading the rtags

;; (require 'rtags)
;; (require 'company-rtags)
;; (require 'flycheck-rtags)
;; (require 'helm-rtags)
;; (require 'rtags-xref)
;; (require 'setup-rtags)

;; Enable the following lines when you are not having the rtags src folder.
;; -----------------RTAGS PACKAGE CONFIG START---------------------
;;(require 'setup-rtags_by_package)

;; (use-package rtags-xref
;;   :ensure t
;;   )

;; (use-package helm-rtags
;;   :ensure t
;;   )
;; -----------------RTAGS PACKAGE CONFIG END---------------------

(require 'setup-lsp-development)


;; (add-hook 'c-mode-hook 'uncrustify-mode)
;; (add-hook 'c++-mode-hook 'uncrustify-mode)
;; (add-hook 'objc-mode-hook 'uncrustify-mode)

(require 'setup-common)

(provide 'my-init)
