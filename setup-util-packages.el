(use-package diminish
  :ensure t
  )

;; Hideshow
;; Hides or Show the block in the file. Call hs-minor-mode in the buffer. TODO. call this mode for specific types of buffer
(use-package hideshow
  :ensure t
  :diminish hs-minor-mode
  :hook
  (js-mode . hs-minor-mode)
  (python-mode . hs-minor-mode)
  (c-mode . hs-minor-mode)
  (c++-mode . hs-minor-mode)
  (objc-mode . hs-minor-mode)
  :bind (:map hs-minor-mode-map
	      ("C-`" . hs-toggle-hiding)))

;; Narrow/Widen
;; very usefull. Try it
(use-package fancy-narrow
  :ensure t
  :diminish
  :hook (after-init . fancy-narrow-mode))

;; Delete selection and then insert
;; default in emacs if you paste in the selection, it will not delete the old selected content. instead it will append the new content with existing content.
;; By enabling this mode, the previous selected content will be deleted and then insert the new content.
(use-package delsel
  :ensure t
  :hook (after-init . delete-selection-mode))

;; Automatically reload files was modified by external program
(use-package autorevert
  :ensure t
  :diminish
  :hook (after-init . global-auto-revert-mode))


;; Pass a URL to a WWW browser
(use-package browse-url
  :ensure t
  :defines dired-mode-map
  :bind (("C-c C-z ." . browse-url-at-point)
         ("C-c C-z b" . browse-url-of-buffer)
         ("C-c C-z r" . browse-url-of-region)
         ("C-c C-z u" . browse-url)
         ("C-c C-z e" . browse-url-emacs)
         ("C-c C-z v" . browse-url-of-file))
  :init
  (with-eval-after-load 'dired
    (bind-key "C-c C-z f" #'browse-url-of-file dired-mode-map))
  (when (featurep 'xwidget-internal)
    (bind-key "C-c C-z w" #'xwidget-webkit-browse-url)))


;; Click to browse URL or to send to e-mail address
(use-package goto-addr
  :ensure t
  :hook ((text-mode . goto-address-mode)
         (prog-mode . goto-address-prog-mode)))

;; Show number of matches in mode-line while searching
(use-package anzu
  :ensure t
  :diminish
  :bind (([remap query-replace] . anzu-query-replace)
         ([remap query-replace-regexp] . anzu-query-replace-regexp)
         :map isearch-mode-map
         ([remap isearch-query-replace] . anzu-isearch-query-replace)
         ([remap isearch-query-replace-regexp] . anzu-isearch-query-replace-regexp))
  :hook (after-init . global-anzu-mode))

;; An all-in-one comment command to rule them all
(use-package comment-dwim-2
  :ensure t  
  :bind ([remap comment-dwim] . comment-dwim-2)) ;

 
;; Drag stuff (lines, words, region, etc...) around
(use-package drag-stuff
  :ensure t
  :diminish
  :commands drag-stuff-define-keys
  :hook (after-init . drag-stuff-global-mode)
  :bind (:map drag-stuff-mode-map
	      ("M-S-<up>" . drag-stuff-up)
	      ("M-S-<down>" . drag-stuff-down)
	      ("M-S-<left>" . drag-stuff-right)
	      ("M-S-<right>" . drag-stuff-left))
  :config
  (add-to-list 'drag-stuff-except-modes 'org-mode)
  )
 
;; Multiple cursors
(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c"   . mc/edit-lines)
         ("C->"           . mc/mark-next-like-this)
         ("C-<"           . mc/mark-previous-like-this)
         ("C-c C-<"       . mc/mark-all-like-this)
         ("C-M->"         . mc/skip-to-next-like-this)
         ("C-M-<"         . mc/skip-to-previous-like-this)
         ("s-<mouse-1>"   . mc/add-cursor-on-click)
         ("C-S-<mouse-1>" . mc/add-cursor-on-click)
         :map mc/keymap
         ("C-|" . mc/vertical-align-with-space)))

(use-package recentf
  :ensure t
  :hook (after-init . recentf-mode)
  :init (setq recentf-max-saved-items 300
              recentf-exclude
              '("\\.?cache" ".cask" "url" "COMMIT_EDITMSG\\'" "bookmarks"
                "\\.\\(?:gz\\|gif\\|svg\\|png\\|jpe?g\\|bmp\\|xpm\\)$"
                "\\.?ido\\.last$" "\\.revive$" "/G?TAGS$" "/.elfeed/"
                "^/tmp/" "^/var/folders/.+$" ; "^/ssh:"
                (lambda (file) (file-in-directory-p file package-user-dir))))
  :config (push (expand-file-name recentf-save-file) recentf-exclude))

(use-package savehist
  :ensure t
  :hook (after-init . savehist-mode)
  :init (setq enable-recursive-minibuffers t ; Allow commands in minibuffers
              history-length 1000
              savehist-additional-variables '(mark-ring
                                              global-mark-ring
                                              search-ring
                                              regexp-search-ring
                                              extended-command-history)
              savehist-autosave-interval 300))

;; (use-package time
;;   :ensure t
;;   ;; :unless (display-graphic-p)
;;   :hook (after-init . display-time-mode)
;;   :init (setq display-time-24hr-format nil
;;               display-time-day-and-date t))

(use-package easy-kill
  :ensure t
  :config
  (global-set-key [remap kill-ring-save] 'easy-kill)
  (global-set-key [remap mark-sexp] 'easy-mark)
)

;; Windows-scroll commands
(use-package pager
  :ensure t
  :bind (([remap scroll-up-command] . pager-page-down)
         ([remap scroll-down-command] . pager-page-up)
         ([next]   . pager-page-down)
         ([prior]  . pager-page-up)
         ([M-up]   . pager-row-up)
         ([M-kp-8] . pager-row-up)
         ([M-down] . pager-row-down)
         ([M-kp-2] . pager-row-down)))

(use-package web-mode
  :ensure t
  :mode "\\.handlebars\\'" "\\.part\\'" "\\.tmpl\\'"
  )

(use-package js2-mode
  :ensure t
  :mode "\\.qml\\'" "\\.js\\'"
  )

(use-package auto-dim-other-buffers
  :ensure t
  :config
  (auto-dim-other-buffers-mode)
  )

(use-package restclient
  :ensure t
  :mode ("\\.http\\'" . restclient-mode)
  )

;; (use-package flycheck-pycheckers
;;   :ensure t
;;   )

;; (use-package lsp-mode
;;   :ensure t
;;   :hook
;;   (js-mode . lsp)
;;   (js2-mode . lsp)
;;   (python-mode . lsp)
;;   (sh-mode . lsp)
;;   :commands lsp
;; )

;; (use-package lsp-ui
;;   :ensure t
;;   )

;; (use-package helm-company               ; Helm frontend for company
;;   :ensure t
;;   :defer t
;;   :bind (:map company-mode-map
;;          ([remap complete-symbol] . helm-company)
;;          ([remap completion-at-point] . helm-company)
;;          :map company-active-map
;;          ("C-;" . helm-company)))

(provide 'setup-util-packages)
;;; setup-util-packages.el ends here
