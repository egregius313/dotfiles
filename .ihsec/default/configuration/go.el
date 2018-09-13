(use-package go-mode
  :ensure t

  :config
  (add-hook
   'go-mode-hook
   (lambda
	 (add-hook 'before-save-hook #'gofmt))))
