(use-package rust-mode
  :config
  (add-hook 'rust-mode-hook
			(lambda ()
			  (local-set-key (kbd "C-c <tab>") #'rust-format-buffer))))


(use-package cargo
  :hook
  ((rust-mode . cargo-minor-mode)))


(use-package racer
  :config
  (setq racer-cmd "~/.cargo/bin/racer")
  (setq racer-rust-src-path "~/source/rust/src/")
  
  :hook
  ((rust-mode . racer-mode)
   (racer-mode . eldoc-mode)
   (racer-mode . company-mode)))


(use-package flycheck-rust
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))



