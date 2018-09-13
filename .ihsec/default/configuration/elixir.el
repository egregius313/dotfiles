(use-package alchemist
  :ensure t
  
  :config
  (setq alchemist-mix-command (executable-find "mix"))
  ;; (setq alchemist-iex-program-name (format "%s -S mix" (executable-find "iex")))
  (setq alchemist-compile-command (executable-find "elixirc"))
  
  :hook
  ((alchemist-iex-mode . company-mode)
   (elixir-mode . alchemist-mode)))



