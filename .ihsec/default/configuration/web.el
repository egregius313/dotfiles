(use-package emmet-mode
  :straight t

  :config
  (progn
	(setq emmet-move-cursor-between-quotes t))

  :hook
  ((sgml-mode html-mode xml-mode web-mode) . emmet-mode))


(use-package json-mode
  :straight t
  :mode "\\.json\\'")


(use-package js2-mode
  :straight t
  :mode "\\.js\\'")


(use-package web-mode
  :straight t
  :mode "\\.html\\'"

  :config
  (setq web-mode-markup-indent-offset 2
		web-mode-css-indent-offset 2
		web-mode-code-indent-offset 2
		web-mode-indent-style 2))


(use-package company-web
  :straight t

  :after (company)
  
  :config
  (progn
	(add-to-list 'company-backends 'company-web-html)
	(add-to-list 'company-backends 'company-web-jade)
	(add-to-list 'company-backends 'company-web-slim)))


(use-package coffee-mode
  :straight t

  :mode "\\.coffee'")


(use-package tagedit
  :straight t

  :bind
  (:map
   tagedit-mode-map
   ("C-<right>". tagedit-forward-slurp-tag)
   ("C-<left>". tagedit-forward-barf-tag)
   ("M-r" . tagedit-raise-tag)
   ("M-s" . tagedit-splice-tag)
   ("M-J" . tagedit-join-tags)
   ("M-S" . tagedit-split-tag)
   ("M-?" . tagedit-convolute-tags)
   ("C-k" . tagedit-kill)
   ("s-k" . tagedit-kill-attribute))
  
  :hook
  ((sgml-mode html-mode web-mode) . tagedit-mode))


