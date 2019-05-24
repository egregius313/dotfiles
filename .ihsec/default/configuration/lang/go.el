(use-package go-mode
  :hook
  (go-mode . gofmt-before-save)

  :bind
  ("C-c <tab>" . #'gofmt))
