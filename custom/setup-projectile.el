(use-package projectile
  :ensure helm
  :init
	(progn
		(projectile-mode 1)
		)
	:bind-keymap(
		     ("C-c p" . projectile-command-map)
		     )
	:config
	(setq projectile-completion-system 'helm)
	(setq projectile-indexing-method 'native)
	(setq projectile-enable-caching t)
	(setq projectile-switch-project-action #'projectile-dired);the top-level directory of the project is immediately opened for you in a dired buffer
	(setq projectile-globally-ignored-directories
	      (append
	       '(".cquery_cached_index")
	       projectile-globally-ignored-directories
	      )
	      )
	(setq projectile-globally-ignored-file-suffixes
	      (append
	       '(".o")
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
        )
              projectile-globally-ignored-files
	      )
      )

)

(provide 'setup-projectile)
