(column-number-mode)
(menu-bar-mode 0)
(tool-bar-mode 0)

(use-package linum
  :ensure t

  :config
  (progn
	(setq linum-format "%4d \u2502")

	(use-package hlinum
	  :ensure t
	  :config
	  (hlinum-activate)))

  :hook
  (prog-mode . linum-mode))


(use-package diminish
  :ensure t)


(use-package rainbow-delimiters
  :ensure t

  :hook
  (prog-mode . rainbow-delimiters-mode))


(use-package material-theme
  :ensure t
  
  :custom
  (custom-enable-themes '(material)))


(use-package powerline
  :if window-system
  :ensure t

  :config
  (powerline-default-theme))


(if (daemonp)
	(add-hook 'after-make-frame-functions
			  (lambda (f)
				(with-selected-frame f
				  (when (window-system f)
					(powerline-default-theme)
					(load-theme 'material)))))
  (progn
	(powerline-default-theme)
	(load-theme 'material)))


(progn
  (show-paren-mode 1)
  (setq show-paren-delay 0))
  

