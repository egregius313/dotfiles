;;; -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(require 'diminish)

(use-package go-mode
  :mode "\\.go\\'"
  :hook
  (go-mode . gofmt-before-save)
  (go-mode . lsp)

  :bind
  (:map go-mode-map
        ("C-c <tab>" . gofmt)))

(use-package subword
  :straight nil
  :hook
  (go-mode . subword-mode))

(provide 'config-lang/go)
