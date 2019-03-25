(use-package nyan-mode
  :straight t

  :custom
  (nyan-animate-nyancat t)  
  (nyan-wavy-trail nil)

  :config
  (nyan-mode 1))


(use-package doom-modeline
  :straight t

  :custom
  (doom-modeline-buffer-file-name-style 'buffer-name)
  (doom-modeline-major-mode-color-icon t)

  :config
  (doom-modeline-mode 1))
