(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)


(use-package menu-bar
  :custom
  (menu-bar-mode nil))


(use-package tool-bar
  :custom
  (tool-bar-mode nil))


(use-package monokai-theme
  :straight t

  :custom
  (custom-enabled-themes '(monokai))
  
  :config
  (add-to-list
   'custom-safe-themes
   '("2925ed246fb757da0e8784ecf03b9523bccd8b7996464e587b081037e0e98001" default))
  (load-theme 'monokai))


(use-package hl-line
  :if window-system
  :straight t

  :hook
  (prog-mode . hl-line-mode))


(use-package pretty-mode
  :if window-system
  :straight t
  :config
  (global-pretty-mode t))


(use-package rainbow-delimiters
  :straight t

  :hook
  (prog-mode . rainbow-delimiters-mode))


(set-frame-font "Fira Code 8")
