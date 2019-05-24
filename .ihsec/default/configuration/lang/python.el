(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(require 'diminish)


(use-package jedi
  :defer t
  
  :config
  (use-package company-jedi
    :ensure t

    :config
    (add-to-list 'company-backends 'company-jedi))
  
  :hook
  (python-mode . jedi-mode))


(use-package elpy
  :after flycheck
  :defer t
  
  :config
  (progn
    (elpy-enable)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules)))
  
  :hook
  ((elpy-mode . flycheck-mode)
   (python-mode . elpy-mode)))


(use-package blacken
  :defer t
  
  :config
  (unless (executable-find "black")
    (call-process "pip3" nil 0 nil "install" "black"))
  
  :hook
  ((python-mode . blacken-mode)))


(use-package isortify
  :defer t
  
  :hook
  (python-mode . isortify-mode))


(use-package ein
  :defer t)


(add-to-list 'auto-mode-alist '("Pipfile" . toml-mode))
