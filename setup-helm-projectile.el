(use-package helm-projectile
  :ensure t
  :requires (helm projectile)
  :bind ( ("s-f" . helm-projectile-find-file) )
  :config
  (projectile-mode)
)

(provide 'setup-helm-projectile)
