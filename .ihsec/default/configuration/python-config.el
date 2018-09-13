(use-package jedi
  :ensure t

  :config
  (use-package company-jedi
	:ensure t

	:config
	(add-to-list 'company-backends 'company-jedi))
  
  :hook
  (python-mode . jedi-mode))


(use-package elpy
  :after flycheck
  :ensure t

  :config
  (progn
	(elpy-enable)
	(setq elpy-modules (delq 'elpy-module-flymake elpy-modules)))
  
  :hook
  ((elpy-mode . flycheck-mode)
   (python-mode . elpy-mode)))


(use-package blacken
  :ensure t

  :config
  (unless (executable-find "black")
	(call-process "pip3" nil 0 nil "install" "black"))
  
  :hook
  ((python-mode . blacken-mode)))


(use-package isortify
  :ensure t

  :hook
  (python-mode . isortify-mode))


(use-package ein
  :ensure t)


(add-to-list 'auto-mode-alist '("Pipfile" . toml-mode))
