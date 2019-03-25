(use-package rust-mode
  :straight t

  :config
  (add-hook 'rust-mode-hook
			(lambda ()
			  (local-set-key (kbd "C-c <tab>") #'rust-format-buffer))))


(use-package cargo
  :straight t

  :hook
  ((rust-mode . cargo-minor-mode)))


(use-package racer
  :straight t

  :config
  (setq racer-cmd "~/.cargo/bin/racer")
  (setq racer-rust-src-path "~/source/rust/src/")
  
  :hook
  ((rust-mode . racer-mode)
   (racer-mode . eldoc-mode)
   (racer-mode . company-mode)))


(use-package flycheck-rust
  :straight t

  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))



