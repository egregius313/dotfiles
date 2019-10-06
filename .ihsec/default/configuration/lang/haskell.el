(use-package haskell-mode
  :custom
  (haskell-tags-on-save t)
  (haskell-process-type 'stack-ghci)

  :bind
  (:map haskell-mode-map
   ("C-`" . haskell-interactive-bring)
   ("M-." . haskell-mode-jump-to-def-or-tag)))




