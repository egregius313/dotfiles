(package-initialize)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enable-themes (quote (material)) t)
 '(custom-enabled-themes (quote (material)))
 '(custom-safe-themes
   (quote
	("a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" default)))
 '(package-archives
   (quote
	(("gnu" . "http://elpa.gnu.org/packages/")
	 ("melpa-stable" . "http://stable.melpa.org/packages/")
	 ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
	(company-web helm-swoop markdown-mode aggressive-indent xah-css-mode web-mode json-mode emmet-mode use-package-chords counsel flx ein py-autopep8 elpy utop flycheck-ocaml merlin tuareg super-save company which-key treemacs hlinum powerline material-theme diminish magit electric-case hs-minor-mode paredit rainbow-delimiters yasnippet-snippets yasnippet use-package)))
 '(vc-follow-symlinks nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(setq-default tab-width 4)

(load-file "~/.emacs.d/configuration/package-config.el")


(use-package paredit
  :ensure t

  :diminish paredit-mode
  
  :hook
  ((emacs-lisp-mode) . paredit-mode))


(use-package electric-case
  :ensure t

  :hook
  ((java-mode . electric-case-java-init)))


(load-file "~/.emacs.d/configuration/display-config.el")
(load-file "~/.emacs.d/configuration/autocomplete-config.el")
(load-file "~/.emacs.d/configuration/search-config.el")
(load-file "~/.emacs.d/configuration/misc-config.el")

(when (and (executable-find "ocaml")
		   (executable-find "opam"))
  (load-file "~/.emacs.d/configuration/ocaml.el"))

(load-file "~/.emacs.d/configuration/project-vc-config.el")
(load-file "~/.emacs.d/configuration/python-config.el")
(load-file "~/.emacs.d/configuration/web.el")
(load-file "~/.emacs.d/configuration/markdown.el")
