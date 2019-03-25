(defalias 'yes-or-no-p 'y-or-n-p)


(use-package async
  :straight t

  :init
  (dired-async-mode 1))


(use-package which-key
  :straight t
  :diminish which-key-mode

  :config
  (which-key-mode 1))


(use-package treemacs
  :straight t

  :bind
  (("s-t" . treemacs-select-window)
   ("C-c t" . treemacs-select-window)))


(use-package super-save
  :straight t

  :diminish super-save-mode

  :custom
  (super-save-auto-save-when-idle t)
  (auto-save-default nil)
  
  :config
  (super-save-mode 1))


;; (use-package beacon
;;   :when window-system
;;   :straight t
;;   :diminish beacon-mode  
;;   :config
;;   (beacon-mode 1))


(use-package expand-region
  :straight t

  :config
  (use-package change-inner
	:straight t

	:bind
	(("M-i" . change-inner)
	 ("M-o" . change-outer)))
  
  :bind
  ("C-q" . er/expand-region))



(use-package restclient
  :straight t)






;; (define-key Man-mode-map "/" (key-binding (kbd "C-s")))




