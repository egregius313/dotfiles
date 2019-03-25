(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)


(use-package clojure-mode
  :straight t

  :requires (paredit)

  :hook
  ((clojure-mode . paredit-mode)))


(use-package cider
  :straight t

  :requires (company)

  :hook
  ((cider-mode . company-mode)
   (cider-repl-mode . company-mode)))
