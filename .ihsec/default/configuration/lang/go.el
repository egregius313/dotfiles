(use-package go-mode
  :mode "\\.go\\'"
  :hook
  (go-mode . gofmt-before-save)

  :bind
  ("C-c <tab>" . #'gofmt))


(use-package lsp-mode
  :commands lsp
  :hook
  (go-mode . lsp))
