(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(require 'diminish)


(use-package jedi
  :straight t

  :config
  (use-package company-jedi
    :straight t

    :config
    (add-to-list 'company-backends 'company-jedi))
  
  :hook
  (python-mode . jedi-mode))


(use-package elpy
  :after flycheck
  :straight t

  :config
  (progn
    (elpy-enable)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules)))
  
  :hook
  ((elpy-mode . flycheck-mode)
   (python-mode . elpy-mode)))


(use-package blacken
  :straight t
  
  :config
  (unless (executable-find "black")
    (call-process "pip3" nil 0 nil "install" "black"))
  
  :hook
  ((python-mode . blacken-mode)))


(use-package isortify
  :straight t

  :hook
  (python-mode . isortify-mode))


(use-package ein
  :straight t)


(add-to-list 'auto-mode-alist '("Pipfile" . toml-mode))
