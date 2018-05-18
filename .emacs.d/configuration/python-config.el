(use-package elpy
  :after flycheck
  :ensure t

  :config
  (progn
	(elpy-enable)
	(setq elpy-modules (delq 'elpy-module-flymake elpy-modules)))
  
  :hook
  ((elpy-mode . flycheck-mode)))



(use-package py-autopep8
  :ensure t

  :hook
  (elpy-mode . py-autopep8-enable-on-save))


(use-package ein
  :ensure t)


