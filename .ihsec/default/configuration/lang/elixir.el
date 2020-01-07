;;; -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(use-package alchemist
  :config
  (setq alchemist-mix-command (executable-find "mix"))
  ;; (setq alchemist-iex-program-name (format "%s -S mix" (executable-find "iex")))
  (setq alchemist-compile-command (executable-find "elixirc"))
  
  :hook
  ((alchemist-iex-mode . company-mode)
   (elixir-mode . alchemist-mode)))


(provide 'config-lang/elixir)
