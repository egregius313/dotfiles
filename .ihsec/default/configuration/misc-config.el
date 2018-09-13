(defalias 'yes-or-no-p 'y-or-n-p)


(use-package async
  :ensure t

  :init
  (dired-async-mode 1))


(use-package which-key
  :ensure t
  :diminish which-key-mode

  :config
  (which-key-mode 1))


(use-package treemacs
  :ensure t

  :bind
  (("s-t" . treemacs-select-window)
   ("C-c t" . treemacs-select-window)))


(use-package super-save
  :ensure t

  :diminish super-save-mode

  :config
  (progn
	(super-save-mode 1)
	(setq super-save-auto-save-when-idle t)
	(setq auto-save-default nil)))


(use-package beacon
  :ensure t

  :diminish beacon-mode
  
  :config
  (beacon-mode 1))


(use-package expand-region
  :ensure t

  :bind
  ("C-q" . er/expand-region))



(use-package restclient
  :ensure t)






;; (define-key Man-mode-map "/" (key-binding (kbd "C-s")))




