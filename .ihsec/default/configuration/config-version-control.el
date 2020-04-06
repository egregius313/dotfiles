;;; -*- lexical-binding: t -*-

(use-package magit
  :bind
  ("C-x g" . magit-status))

(use-package forge
  :after magit)

(use-package gist
  :defer t)

(use-package gitignore-mode
  :mode "\\.gitignore\\'"
  :defer t)

(provide 'config-version-control)
