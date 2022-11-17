(use-package lsp-mode
  :ensure t
  :hook
  ;; (js-mode . lsp)
  ;; (js2-mode . lsp)
  ;; (python-mode . lsp)
  ;; (sh-mode . lsp)
  (csharp-mode . lsp)
  (java-mode . lsp)
  (c-mode . lsp)
  (c++-mode . lsp)
  (perl-mode . lsp)
  :commands lsp
  :bind
  (
    :map lsp-mode-map
         ("M-." . 'lsp-find-definition)
         ("M-," . 'lsp-find-references)
         ("M-<left>" . 'xref-pop-marker-stack)
         ("M-RET" . 'lsp-execute-code-action)
         )
  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  (setq lsp-idle-delay 0.500)
  (setq lsp-log-io nil) ; if set to true can cause a performance hit
  (setq lsp-file-watch-threshold 2000)
  ;; How to define the query driver
  ;; From compile_commands.json get the compiler command path which is usally the first line.
  ;; You can also give the whole compiler command path for query driver like --query-driver=/home/psammandam/disk/office/repo/code//BLD_SKYWORTH_MTK_K8_AARCH64_LNUX_BHARTI_01/platform_cfg/linux/compiler/mtk_gcc_x86_linux_01/bin/aarch64-linux-gnu-gcc
  ;; For each cross compiler give the query driver like --query-driver=/**/aarch64-* --query-driver=/**/arm64-*
  ;; multiple --query-driver command argument is working.
  (setq lsp-clients-clangd-args '("--log=error"
                                  "--query-driver=/**/code/**/mtk_gcc_x86_linux_01/bin/aarch64-*-g*"
                                  "--query-driver=/**/code/**/stbgcc-6.3-1.8/bin/aarch64-*-g*"
                                  "--query-driver=/**/esp8266/**/xtensa-lx106-elf/bin/xtensa-lx106-*-g*"
                                  "--background-index"
                                  "--clang-tidy"
                                  "--enable-config"
;;                                  "--pch-storage=memory"
;;                                  "--header-insertion-decorators"
                                  "--header-insertion=never"
                                  "--limit-references=0"
                                  "--limit-results=0"
                                  ;;"--completion-style=detailed"
                                  ))
  )
;; (define-key lsp-ui-mode-map (kbd "M-.") 'lsp-find-definition)
;; (define-key lsp-ui-mode-map (kbd "M-,") 'lsp-find-references)
;; (define-key lsp-ui-mode-map (kbd "M-<left>") 'xref-pop-marker-stack )

(use-package lsp-ui
  :ensure t
  :bind
  (
    ;; :map lsp-ui-mode-map
    ;;      ("M-." . 'lsp-ui-peek-find-definitions)
    ;;      ("M-," . 'lsp-ui-peek-find-references)
    ;;      ("M-<left>" . 'xref-pop-marker-stack)
         )
  )

(use-package helm-lsp
  :ensure t
  :bind
  (
    :map lsp-mode-map
         ("M-l" . 'helm-imenu)
        )
  )

(use-package ccls
  :ensure t
  :config
  (defun ccls/callee () (interactive) (lsp-find-custom "$ccls/call" '(:callee t)))
  (defun ccls/caller () (interactive) (lsp-find-custom "$ccls/call"))
  (defun ccls/vars (kind) (lsp-ui-peek-find-custom "$ccls/vars" `(:kind ,kind)))
  (defun ccls/base (levels) (lsp-ui-peek-find-custom "$ccls/inheritance" `(:levels ,levels)))
  (defun ccls/derived (levels) (lsp-ui-peek-find-custom "$ccls/inheritance" `(:levels ,levels :derived t)))
  (defun ccls/member (kind) (interactive) (lsp-ui-peek-find-custom "$ccls/member" `(:kind ,kind)))
  ;; References w/ Role::Role
  (defun ccls/references-read () (interactive)
         (lsp-find-custom "textDocument/references"
                          (plist-put (lsp--text-document-position-params) :role 8)))

  ;; References w/ Role::Write
  (defun ccls/references-write ()
    (interactive)
    (lsp-find-custom "textDocument/references"
                     (plist-put (lsp--text-document-position-params) :role 16)))


  ;; The meaning of :role corresponds to https://github.com/maskray/ccls/blob/master/src/symbol.h

  ;; References w/ Role::Address bit (e.g. variables explicitly being taken addresses)
  (defun ccls/references-address ()
    (interactive)
    (lsp-find-custom "textDocument/references"
                     (plist-put (lsp--text-document-position-params) :role 128)))

  ;; References w/ Role::Dynamic bit (macro expansions)
  (defun ccls/references-macro ()
    (interactive)
    (lsp-find-custom "textDocument/references"
                     (plist-put (lsp--text-document-position-params) :role 64)))

  ;; References w/o Role::Call bit (e.g. where functions are taken addresses)
  (defun ccls/references-not-call ()
    (interactive)
    (lsp-find-custom "textDocument/references"
                     (plist-put (lsp--text-document-position-params) :excludeRole 32)))

  (defun my/highlight-pattern-in-text (pattern line)
    (when (> (length pattern) 0)
      (let ((i 0))
        (while (string-match pattern line i)
          (setq i (match-end 0))
          (add-face-text-property (match-beginning 0) (match-end 0) 'isearch t line)
          )
        line)))

  (with-eval-after-load 'lsp-methods
  ;;; Override
    ;; This deviated from the original in that it highlights pattern appeared in symbol
    (defun lsp--symbol-information-to-xref (pattern symbol)
      "Return a `xref-item' from SYMBOL information."
      (let* ((location (gethash "location" symbol))
             (uri (gethash "uri" location))
             (range (gethash "range" location))
             (start (gethash "start" range))
             (name (gethash "name" symbol)))
        (xref-make (format "[%s] %s"
                           (alist-get (gethash "kind" symbol) lsp--symbol-kind)
                           (my/highlight-pattern-in-text (regexp-quote pattern) name))
                   (xref-make-file-location (string-remove-prefix "file://" uri)
                                            (1+ (gethash "line" start))
                                            (gethash "character" start)))))

    (cl-defmethod xref-backend-apropos ((_backend (eql xref-lsp)) pattern)
      (let ((symbols (lsp--send-request (lsp--make-request
                                         "workspace/symbol"
                                         `(:query ,pattern)))))
        (mapcar (lambda (x) (lsp--symbol-information-to-xref pattern x)) symbols)))
    )
  )

(provide 'setup-lsp-development)

