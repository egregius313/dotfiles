;;; -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))
(require 'bind-key)


(use-package haskell-mode
  :custom
  (haskell-tags-on-save t)
  (haskell-process-type 'stack-ghci)

  :bind
  (:map haskell-mode-map
		("C-`" . haskell-interactive-bring)
		("M-." . haskell-mode-jump-to-def-or-tag)))


;;;; Treat the components of a camel case identifier as separate words
(use-package subword-mode
  :straight nil
  :hook
  (haskell-mode . subword-mode))


(provide 'config-lang/haskell)
