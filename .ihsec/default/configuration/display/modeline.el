(use-package nyan-mode
  :commands (nyan-mode)
  
  :custom
  (nyan-animate-nyancat t)  
  (nyan-wavy-trail nil)

  :config
  (add-hook 'doom-modeline-mode-hook 'nyan-mode))


(use-package doom-modeline
  :commands (doom-modeline-mode)
  
  :custom
  (doom-modeline-buffer-file-name-style 'buffer-name)
  (doom-modeline-major-mode-color-icon t)

  :config
  ;; (doom-modeline-mode 1)
  (add-hook 'after-init-hook #'doom-modeline-mode))

