;;; set-projectile -- Custom projectile setup
;;; Commentary:
;;; Code:

(use-package projectile
  :ensure t
  :diminish
  :init
  (projectile-mode)
  :bind-keymap(
	       ("s-." . projectile-command-map)
	       )
  :bind(
	:map projectile-mode-map
	("s-f" . projectile-find-file)
	)
  :config
  (setq projectile-completion-system 'helm)
  (setq projectile-indexing-method 'alien)
  (setq projectile-enable-caching t)
  (setq projectile-switch-project-action #'projectile-dired);the top-level directory of the project is immediately opened for you in a dired buffer
  (setq projectile-globally-ignored-directories
        (append
         '("^\\.cquery_cached_index")
         '("^\\.cache$")
         projectile-globally-ignored-directories
         )
        )
  (setq projectile-globally-ignored-file-suffixes
        (append
         '(".o$" ".idx")
         projectile-globally-ignored-file-suffixes
         )
        )
  (setq projectile-globally-ignored-files
        (append '(
        	  ".DS_Store"
        	  "*.gz"
        	  "*.pyc"
        	  "*.jar"
        	  "*.tar.gz"
        	  "*.tgz"
        	  "*.zip"
        	  "*.png"
        	  "*.o"
        	  "*.so"
                  "*.idx"
        	  )
        	projectile-globally-ignored-files
        	)
        )

  )

(provide 'setup-projectile)
;;; setup-projectile.el ends here
