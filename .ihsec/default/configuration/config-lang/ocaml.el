;;; -*- lexical-binding: t -*-

(use-package tuareg
  :mode ("\\.ocamlinit\\'")

  :hook
  ((tuareg-mode . paredit-mode)))


(use-package merlin
  :after (:any tuareg caml)

  :config
  (progn
	(add-to-list 'company-backends 'merlin-company-backend)

	(use-package flycheck-ocaml
	  :after (flycheck)

	  :config
	  (progn
		(setq merlin-error-after-save nil)
		(flycheck-ocaml-setup))))

  :hook
  ((merlin-mode . company-mode)
   ((tuareg-mode caml-mode) . merlin-mode))

  :bind
  (:map merlin-mode-map
		([remap xref-find-definitions] . merlin-locate)
		([remap xref-pop-marker-stack] . merlin-pop-stack)))


(use-package merlin-eldoc
  :after (merlin)
  :config
  (merlin-eldoc-setup))


(use-package utop
  :config
  (setq utop-command "opam config exec -- utop -emacs")

  :hook
  ((tuareg-mode . utop-minor-mode)
   (utop-minor-mode . company-mode)))


(provide 'config-lang/ocaml)
