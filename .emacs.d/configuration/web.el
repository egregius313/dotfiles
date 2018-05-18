(use-package emmet-mode
  :ensure t

  :config
  (progn
	(setq emmet-move-cursor-between-quotes t))

  :hook
  ((sgml-mode html-mode xml-mode web-mode) . emmet-mode))


(use-package json-mode
  :ensure t
  :mode "\\.json\\'")


(use-package js2-mode
  :ensure t
  :mode "\\.js\\'")


(use-package web-mode
  :ensure t
  :mode "\\.html\\'"

  :config
  (setq web-mode-markup-indent-offset 2
		web-mode-css-indent-offset 2
		web-mode-code-indent-offset 2
		web-mode-indent-style 2))


(use-package company-web
  :ensure t

  :after (company)
  
  :config
  (progn
	(add-to-list 'company-backends 'company-web-html)
	(add-to-list 'company-backends 'company-web-jade)
	(add-to-list 'company-backends 'company-web-slim)))
