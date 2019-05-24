(eval-when-compile
  (require 'use-package))

(use-package kotlin-mode
  )
  

(use-package flycheck-kotlin
  

  :after (kotlin-mode))

