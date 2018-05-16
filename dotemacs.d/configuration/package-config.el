(progn
  (require 'package)
  (package-initialize)
  (package-refresh-contents))


(unless (package-installed-p 'use-package)
  (package-install 'use-package))


(use-package use-package-chords
  :ensure t

  :config
  (key-chord-mode 1))
