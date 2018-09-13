;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


(load-file "~/.emacs.d/configuration/package-config.el")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
	("57f95012730e3a03ebddb7f2925861ade87f53d5bbb255398357731a7b1ac0e0" "c9e02bc73b027c25da6d5d3eee642f7892bb409a32acecd2ae8c7b5df52c068f" "c3d4af771cbe0501d5a865656802788a9a0ff9cf10a7df704ec8b8ef69017c68" "ff79b206ad804c41a37b7b782aca44201edfa8141268a6cdf60b1c0916343bd4" "732b807b0543855541743429c9979ebfb363e27ec91e82f463c91e68c772f6e3" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" default)))
 '(hl-sexp-background-color "#1c1f26")
 '(neo-theme (quote icons))
 '(package-archives
   (quote
	(("gnu" . "http://elpa.gnu.org/packages/")
	 ("melpa-stable" . "http://stable.melpa.org/packages/")
	 ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
	(tagedit-mode jekyll-modes inf-ruby tagedit fuel minesweeper browse-kill-ring fzf lispy lfe-mode ledger-mode restclient counsel-spotify sass-mode isortify company-jedi jedi subword-mode multiple-cursors dockerfile-mode docker-compose-mode docker flycheck-kotlin zone-nyan zerodark-theme yasnippet-snippets yaml-mode xah-css-mode which-key web-mode w3m utop use-package-chords tuareg treemacs toml-mode symon super-save sudoku sudo-edit spaceline-all-the-icons smartparens slime-company restart-emacs ranger rainbow-delimiters racer quelpa-use-package pydoc py-autopep8 projectile pretty-mode powershell plan9-theme pipenv perl6-mode paredit org-chef org-bullets nyan-mode neotree monokai-theme modern-cpp-font-lock mode-icons material-theme lsp-mode linum-relative kotlin-mode json-mode jinja2-mode hy-mode hlinum highlight-defined helm-swoop haskell-mode gradle-mode go-mode fsharp-mode forth-mode flycheck-rust flycheck-ocaml flx fancy-battery exwm expand-region evil-surround evil-nerd-commenter eshell-z emms emmet-mode elpy electric-case ein editorconfig dmenu dired-ranger diminish dashboard csharp-mode company-web company-erlang coffee-mode cider cedit cargo blacken beacon atom-one-dark-theme anzu all-the-icons-dired alchemist aggressive-indent aggressive-fill-paragraph)))
 '(vc-follow-symlinks nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(setq-default tab-width 4)



(use-package paredit
  :ensure t

  :diminish paredit-mode
  
  :hook
  ((emacs-lisp-mode) . paredit-mode))


(use-package electric-case
  :ensure t

  :hook 
  ((java-mode . electric-case-java-init)))

(use-package editorconfig
  :ensure t

  :diminish editorconfig-mode
  
  :config
  (editorconfig-mode 1)

  :hook
  ((editorconfig-conf-mode . yas-minor-mode)))


(use-package highlight-defined
  :ensure t

  :config
  (highlight-defined-mode 1))


(use-package evil-nerd-commenter
  :ensure t

  :config
  (evilnc-default-hotkeys)

  :chords
  ((";p" . evilnc-comment-or-uncomment-paragraphs)))


(load-file "~/.emacs.d/configuration/autocomplete-config.el")
(load-file "~/.emacs.d/configuration/search-config.el")
(load-file "~/.emacs.d/configuration/navigation.el")
(load-file "~/.emacs.d/configuration/misc-config.el")

(when (and (executable-find "ocaml") (executable-find "opam"))
  (load-file "~/.emacs.d/configuration/ocaml.el"))

(when (executable-find "sbcl")
  (load-file "~/.emacs.d/configuration/common-lisp.el"))

(load-file "~/.emacs.d/configuration/project-vc-config.el")

(load-file "~/.emacs.d/configuration/elixir.el")
(load-file "~/.emacs.d/configuration/markdown.el")
(load-file "~/.emacs.d/configuration/python-config.el")
(load-file "~/.emacs.d/configuration/web.el")


(when (equal window-system 'x)
  (load-file "~/.emacs.d/configuration/window-manager.el"))


(use-package key-chord
  :ensure t

  :config
  (setq key-chord-two-keys-delay 0.2))


;;; Only add these short cuts to editing mode
;; (key-chord-define-global "xb" (key-binding (kbd "C-x b")))
;; (key-chord-define-global "xc" (key-binding (kbd "C-x C-c")))
;; (key-chord-define-global "xf" (key-binding (kbd "C-x C-f")))
;; (key-chord-define-global "xk" (key-binding (kbd "C-x k")))
;; (key-chord-define-global "xs" (key-binding (kbd "C-x C-s"))))


(setq inhibit-startup-message t)
(setq ring-bell-function nil)

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


(load-file "~/.emacs.d/configuration/display-config.el")
(load-file "~/.emacs.d/configuration/org.el")
(load-file "~/.emacs.d/configuration/docker.el")


(use-package projectile
  :ensure t

  :init
  (projectile-mode 1))


(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  ;; (setq dashboard-startup-banner "~/.emacs.d/img/lake.jpg")
  (setq dashboard-startup-banner
		;; "~/.ihsec/uncledave/img/dashLogo.png"
		;; "~/.emacs.d/img/lake.png"
		"~/.emacs.d/img/gods_lament.png"
		)
  (setq dashboard-items '((recents . 5)
						  (projects . 5)))
  (setq dashboard-banner-logo-title ""))


(use-package restart-emacs
  :ensure t

  :config
  (setq restart-emacs-restore-frames t))


(diminish 'eldoc-mode)


;; (use-package mode-icons :ensure t :config (mode-icons-mode 1))

(use-package quelpa-use-package
  :ensure t)


(use-package nyan-mode
  :ensure t

  :config
  (setq nyan-animate-nyancat t)
  (setq nyan-wavy-trail nil)
  (nyan-mode 1)

  (dolist (hook '(exwm-mode-hook eshell-mode-hook))
	(add-hook hook (lambda () (nyan-mode -1)))))


(use-package evil
  :ensure t

  :bind
  (("s-e" . evil-mode)
   :map evil-insert-state-map
   ("s-e" . evil-mode)
   :map evil-normal-state-map
   ("s-e" . evil-mode)))



(defun indent-buffer ()
  "Indent current buffer according to major mode"
  (interactive)
  (indent-region (point-min) (point-max)))


(global-set-key (kbd "C-c <tab>") #'indent-buffer)


(use-package highlight-defined
  :ensure t

  :config
  (highlight-defined-mode 1))


(setq browse-url-browser-function 'browse-url-generic
	  browse-url-generic-program "firefox")


(use-package all-the-icons
  :ensure t)


(use-package neotree
  :ensure t

  :config
  (neotree-hidden-file-toggle)
  
  :bind
  (:map
   neotree-mode-map
   ("h" . 'neotree-hidden-file-toggle)
   ("m" . neotree-rename-node)))


(use-package all-the-icons-dired
  :ensure t)


(use-package spaceline-all-the-icons
  :ensure t)


(use-package fancy-battery
  :ensure t

  :config
  (fancy-battery-mode 1))


(use-package multiple-cursors
  :ensure t

  :bind
  (("C-S-c C-S-c" . mc/edit-lines)
   ("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-c C-<" . mc/mark-all-like-this)))


(use-package org-chef
  :ensure t)



(setq org-capture-templates
	  '(("c" "Cookbook" entry (file "~/org/cookbook.org")
		 "%(org-chef-get-recipe-from-url)"
		 :empty-lines 1)))


(add-to-list 'load-path "~/.emacs.d/lisp/")



(global-set-key
 (kbd "s-l")
 (lambda ()
   (interactive)
   (shell-command
	"systemctl suspend")))
