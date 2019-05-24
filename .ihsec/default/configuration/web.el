(use-package emmet-mode
  :config
  (progn
	(setq emmet-move-cursor-between-quotes t))

  :hook
  ((sgml-mode html-mode xml-mode web-mode) . emmet-mode))


(use-package json-mode
  :mode "\\.json\\'")


(use-package js2-mode
  :mode "\\.js\\'")


(use-package nodejs-repl)


(use-package web-mode
  :mode "\\.html\\'"

  :config
  (setq web-mode-markup-indent-offset 2
		web-mode-css-indent-offset 2
		web-mode-code-indent-offset 2
		web-mode-indent-style 2))


(use-package company-web
  :after (company)
  
  :config
  (progn
	(add-to-list 'company-backends 'company-web-html)
	(add-to-list 'company-backends 'company-web-jade)
	(add-to-list 'company-backends 'company-web-slim)))


(use-package coffee-mode
  :mode "\\.coffee'")


(use-package tagedit
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


