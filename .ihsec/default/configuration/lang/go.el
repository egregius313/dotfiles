(use-package go-mode
  :straight t

  :hook
  (go-mode . gofmt-before-save)

  :bind
  ("C-c <tab>" . #'gofmt))
