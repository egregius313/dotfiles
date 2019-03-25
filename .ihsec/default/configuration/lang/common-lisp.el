(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(add-hook 'lisp-mode 'paredit-mode)


(use-package sly
  :straight t

  :config
  (setq inferior-lisp-program "/usr/bin/sbcl")
    
  :hook
  (common-lisp-mode . sly-editing-mode)
  (sly-mode . (paredit-mode rainbow-delimiters-mode)))


