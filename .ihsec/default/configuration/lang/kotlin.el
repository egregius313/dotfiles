(eval-when-compile
  (require 'use-package))

(use-package kotlin-mode
  :straight t)
  

(use-package flycheck-kotlin
  :straight t

  :after (kotlin-mode))

