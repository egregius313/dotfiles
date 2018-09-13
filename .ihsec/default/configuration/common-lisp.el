(add-hook 'lisp-mode 'paredit-mode)



(use-package slime
  :ensure t
  
  :config
  (load (expand-file-name "~/quicklisp/slime-helper.el"))
  (setq inferior-lisp-program "/usr/bin/sbcl")
  (setq slime-lisp-implementations
		`((sbcl ("/usr/bin/sbcl" "--core"
				 ,(expand-file-name "~/.emacs.d/sbcl.core-for-slime"))
				:coding-system utf-8-unix)))

  :hook
  (slime-repl-mode . paredit-mode))



(use-package slime-company
  :ensure t

  :after slime
  
  :config
  (slime-setup '(slime-company))

  :hook
  ((lisp-mode slime-repl-mode) . company-mode))



