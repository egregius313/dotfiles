;; -*- lexical-binding: t -*-

(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(use-package paredit
  :hook
  (lisp-mode . paredit-mode))

(use-package sly
  :commands (sly sly-editing-mode)
  
  :custom
  (inferior-lisp-program "/usr/bin/sbcl")

  (sly-lisp-implementations
   `((sbcl (,inferior-lisp-program
			"--core"
			,(expand-file-name "sbcl.core-for-slime" user-emacs-directory)))))
  
  :config
  (add-hook 'common-lisp-hook 'sly-editing-mode)
  (add-hook 'sly-mode-hook 'paredit-mode)
  (add-hook 'sly-mode-hook 'rainbow-delimiters-mode))


(provide 'config-lang/common-lisp)
