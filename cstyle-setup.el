;;; ctyle-setup --- Customization of C/C++ code style and indentation
;;; Commentary:
;;
;;

;;; Code:
(defvar current-indentation-spaces 4 "Indentation in spaces.")
(defvar c-available-styles-list (list "personal" "ethereum")
  "A list of the available C/C++ coding styles to choose from.")
;; set the default style
(defvar my-c-default-style "personal"
  "The style to be chosen by default out of the `c-available-styles-list'.")

(setq current-indentation-spaces 4)
(setq tab-stop-list
      '(4 8 12 14 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))

;; Create my personal style.
(defconst my-c-style
  '((c-tab-always-indent        . t)
    ;; always syntactically analyze and indent macros
    (c-syntactic-indentation-in-macros . t)
    ;; auto align backslashes for continuation
    (c-auto-align-backslashes . t)
    (c-comment-only-line-offset . 4)
    (c-hanging-braces-alist     . ((substatement-open after)
                                   (brace-list-open)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi))
    (c-offsets-alist            . (
                                   ;; lineup the current argument line under the
                                   ;; first argument
                                   ;; (arglist-close . c-lineup-arglist)
                                   (arglist-close . 0) ;; <-- or not
                                   (substatement-open . 0)
                                   (case-label        . 0)
                                   (block-open        . 4)
                                   (inline-open       . 4)
                                   ;; all opens should be indented
                                   (brace-list-open   . 4)
                                   ;; indent after case
                                   (statement-case-intro   . 4)
                                   ;; indent after entering a block
                                   (statement-block-intro   . 4)
                                   ;; indent after entering a function definition
                                   (defun-block-intro   . 4)
                                   ;; indent when entering class/struct
                                   (inclass   . 4)
                                   ;; don't indent the first line in a topmost construct
                                   (topmost-intro . 0)
                                   ;; first line after if/while/for/do/else
                                   (substatement . 4)
                                   ;; don't indent when in extern scope
                                   (inextern-lang . 0)
                                   ;; when ; does not end a stmt don't indent
                                   (statement-cont . 0)
                                   ;; c++ constructor member initi no indent
                                   (member-init-intro . 0)
                                   (member-init-cont . 0)
                                   ;; don't indent c++ namespace
                                   (innamespace . 0)
                                   ;; don't indent first comments
                                   (comment-intro . 0)
                                   ;; indent a continued statement
                                   (statement-cont . 4)
                                   ;; do not indent a goto jump label
                                   (label . 0)
                                   
                                   ))
    ;; echo syntactic info when presing TAB. If `t' helps with debugging.
    (c-echo-syntactic-information-p . t))
  "My C/C++ Programming Style.")
(c-add-style "personal" my-c-style)

(defun my-c-mode-hook ()
  "C/C++ hook for my personal style."
  (subword-mode 1) ;all word movement goes across Capitalized words
  (setq-default c-indent-tabs-mode nil)   ; Spaces instead of tabs
  (setq-default indent-tabs-mode nil)     ; Spaces instead of tabs
  (setq-default c-indent-level 4)         ; A TAB is equivilent to 4 spaces
  (setq-default c-basic-offset 4)
  (setq-default tab-width 4)              ; Default tab width is 4
  (setq-default c-argdecl-indent 0)       ; Do not indent argument decl's extra
  (setq-default c-tab-always-indent t)
  (setq-default backward-delete-function nil) ; DO NOT expand tabs when deleting
  (c-set-style "personal"))

;; Create ethereum c/c++ style
(defconst ethereum-c-style
  '((c-tab-always-indent        . t)
    ;; always syntactically analyze and indent macros
    (c-syntactic-indentation-in-macros . t)
    ;; auto align backslashes for continuation
    (c-auto-align-backslashes . t)
    (c-comment-only-line-offset . 4)
    (c-hanging-braces-alist     . ((substatement-open after)
                                   (brace-list-open)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi))
    (c-offsets-alist            . (
                                   ;; lineup the current argument line under the
                                   ;; first argument
                                   ;; (arglist-close . c-lineup-arglist)
                                   (arglist-close . 0) ;; <-- or not
											  (arglist-cont-nonempty . 4)
                                   (substatement-open . 0)
                                   (case-label        . 0)
											  (label             . 0)
                                   (block-open        . 4)
                                   ;; Don't indent first brace of a class's function
                                   (inline-open       . 0)
                                   ;; all opens should be indented
                                   (brace-list-open   . 4)
                                   ;; indent after case
                                   (statement-case-intro   . 4)
                                   ;; indent after entering a block
                                   (statement-block-intro   . 4)
                                   ;; indent after entering a function definition
                                   (defun-block-intro   . 4)
                                   ;; indent when entering class/struct
                                   (inclass   . 4)
                                   ;; don't indent the first line in a topmost construct
                                   (topmost-intro . 0)
                                   ;; first line after if/while/for/do/else
                                   (substatement . 4)
                                   ;; don't indent when in extern scope
                                   (inextern-lang . 0)
                                   ;; when ; does not end a stmt do indent
                                   (statement-cont . 4)
                                   ;; c++ constructor member initi no indent
                                   (member-init-intro . 4)
                                   (member-init-cont . 4)
                                   ;; don't indent c++ namespace
                                   (innamespace . 0)
                                   ;; don't indent first comments
                                   (comment-intro . 0)
                                   
                                   ))
    ;; echo syntactic info when presing TAB. If `t' helps with debugging.
    (c-echo-syntactic-information-p . t))
  "Ethereum C/C++ programming style.")
(c-add-style "ethereum" ethereum-c-style)

(defun ethereum-c-mode-hook ()
  "C/C++ hook for ethereum development."
  (subword-mode 1) ;all word movement goes across Capitalized words
  (setq-default c-indent-tabs-mode t)     ; tabs instead of spaces
  (setq-default indent-tabs-mode t)       ; tabs instead of spaces
  (setq-default c-indent-level 4)         ; A TAB is equivalent to 4 spaces
  (setq-default c-basic-offset 4)
  (setq-default tab-width 4)              ; Default tab width is 4
  (setq-default c-argdecl-indent 0)       ; Do not indent argument decl's extra
  (setq-default c-tab-always-indent t)
  (setq-default backward-delete-function nil) ; DO NOT expand tabs when deleting
  (c-set-style "ethereum"))


(defun c-style-remove-all-hooks ()
  "Remove all style hooks from `c-mode-common-hook'."
  (remove-hook 'c-mode-common-hook 'my-c-mode-hook)
  (remove-hook 'c-mode-common-hook 'ethereum-c-mode-hook))

(defvar cstyle-read-history nil
  "`completing-read' history of `c-style-read'.")

(defun c-style-read (prompt &optional default)
  "Select a c-style from the list of available c-styles with given PROMPT.

If DEFAULT is provided then this is shown as the default choide of prompt.

Returns the c-style as a string or nil if not found."
  (let* ((candidates c-available-styles-list)
         (input (ido-completing-read prompt candidates nil
                                     'require-match nil
                                     'cstyle-read-history
                                     default)))
    (if (string= input "")
        (user-error "No style name entered")
      input)))


(defun c-style-change (chosen-style)
  "Change the current C/C++ coding style with the CHOSEN-STYLE."
  (interactive
   (list (c-style-read "Choose a C/C++ coding style: " my-c-default-style)))
  (c-style-remove-all-hooks)
  (cond
   ((string-equal chosen-style "personal")
    (add-hook 'c-mode-common-hook 'my-c-mode-hook))

   ((string-equal chosen-style "ethereum")
    (add-hook 'c-mode-common-hook 'ethereum-c-mode-hook))

   (:else
    (error "Illegal style provided to c-style-change"))))

;; also load the default style at the beginning
(c-style-change my-c-default-style)

(provide 'cstyle-setup)
;;; cstyle-setup.el ends here
