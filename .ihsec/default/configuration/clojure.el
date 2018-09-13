(use-package clojure-mode
  :ensure t

  :requires (paredit)

  :hook
  ((clojure-mode . paredit-mode)))


(use-package cider
  :ensure t

  :requires (company)

  :hook
  ((cider-mode . company-mode)
   (cider-repl-mode . company-mode)))
