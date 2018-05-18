(use-package which-key
  :ensure t
  :diminish which-key-mode

  :config
  (which-key-mode 1))


(use-package treemacs
  :ensure t)


(use-package super-save
  :ensure t

  :diminish super-save-mode

  :config
  (progn
	(super-save-mode 1)
	(setq super-save-auto-save-when-idle t)
	(setq auto-save-default nil)))
