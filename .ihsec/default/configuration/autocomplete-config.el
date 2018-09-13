(use-package company
  :ensure t
  :defer 10

  :diminish company-mode

  :config
  (progn
	(setq company-idle-delay 0)
	(setq company-minimum-prefix-length 3))

  :bind
  (:map
   company-active-map
   ("M-p" . nil)
   ("M-n" . nil)
   ("C-p" . company-select-previous)
   ("C-n" . company-select-next)
   ("C-d" . company-show-doc-buffer)
   ("M-." . company-show-location))

  :hook
  (prog-mode . company-mode))


(use-package yasnippet
  :ensure t

  :diminish yas-minor-mode

  :config
  (progn
	(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
	(require 'company))

  :bind
  (("C-c y" . company-yasnippet)
   :map
   company-active-map
   ("C-<tab>" . yas-expand))

  :hook
  ((prog-mode . yas-minor-mode)
   (org-mode . yas-minor-mode)))


(use-package yasnippet-snippets
  :ensure t

  :config
  (yas-reload-all))
