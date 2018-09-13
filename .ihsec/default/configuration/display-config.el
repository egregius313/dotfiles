(use-package diminish
  :ensure t)


(progn
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  
  (show-paren-mode 1)
  (setq show-paren-delay 0)
  (setq line-number-mode t)
  (setq column-number-mode t))


(when window-system
  (add-hook 'prog-mode-hook 'hl-line-mode)
  
  (use-package pretty-mode
	:ensure t
	:config
	(global-pretty-mode t)))



(setq display-time-24hr-format t)
(setq display-time-format "%H:%M - %B %d %Y")
(display-time-mode 1)


(when (boundp 'display-line-numbers-mode)
  (setq display-line-numbers-type 'relative)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode))


(use-package rainbow-delimiters
  :ensure t

  :hook
  (prog-mode . rainbow-delimiters-mode))


(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq spaceline-buffer-encoding-abbrev-p nil)
  (setq spaceline-line-column-p t)
  (setq spaceline-line-p t)
  ;; (setq powerline-default-separator (quote arrow))
  (setq powerline-default-separator nil)
  (spaceline-spacemacs-theme))


(set-frame-font "Fira Code 10")
