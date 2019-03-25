(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)


(defvar bootstrap-version)
(let ((bootstrap-file
	   (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
	  (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
	(with-current-buffer
		(url-retrieve-synchronously
		 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
		 'silent 'inhibit-cookies)
	  (goto-char (point-max))
	  (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(require 'cl-lib)
(straight-use-package 'use-package)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (require 'package)
(package-initialize)

;; (unless (package-installed-p 'use-package)
;;  (package-install 'use-package))

;; (package-refresh-contents)


;; Used by use-package for the :diminish keyword to work
(use-package diminish
  :straight t)


(use-package eldoc
  :diminish eldoc-mode)

(use-package autorevert
  :diminish auto-revert-mode)


(use-package simple
  :custom
  (line-number-mode t)
  (column-number-mode t)
  (scroll-bar-mode nil))


(use-package scroll-bar
  :custom
  (scroll-bar-mode nil))


(use-package time
  :custom
  (display-time-24hr-format t)
  (display-time-format "%H:%M - %B %d %Y")
  (display-time-mode t))


(use-package paren
  :custom
  (show-paren-delay 0)
  (show-paren-mode t))


(use-package display-line-numbers
  :custom
  (display-line-numbers-type 'relative "Use relative line numbers")

  :hook
  (prog-mode . display-line-numbers-mode))


(use-package ido
  :config
  (ido-mode 1)

  ;; Fancy M-x
  (use-package smex
	:straight t
	:after ido

	:bind
	("M-x" . smex)))


(use-package key-chord
  :straight t

  :custom
  (key-chord-two-keys-delay 0.2))


(use-package use-package-chords
  :straight t

  :config
  (key-chord-mode 1))


(use-package quelpa-use-package
  :straight t)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(setq-default tab-width 4)


;; Clean up backup files
(setq
 backup-by-copying t					; don't clobber symlinks
 backup-directory-alist '(("." . "~/.saves/")) ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups


(global-set-key [s-c] #'compile)


(use-package paredit
  :straight t

  :diminish paredit-mode

  :hook
  ((emacs-lisp-mode) . paredit-mode))


;; (use-package electric-case
;;   :straight t
;;   :hook
;;   ((java-mode . electric-case-java-init)))


(use-package editorconfig
  :straight t

  :diminish editorconfig-mode

  :config
  (editorconfig-mode 1)

  :hook
  ((editorconfig-conf-mode . yas-minor-mode)))


(use-package highlight-defined
  :straight t

  :config
  (highlight-defined-mode 1))


(use-package evil-nerd-commenter
  :straight t

  :config
  (evilnc-default-hotkeys)

  :chords
  ((";p" . evilnc-comment-or-uncomment-paragraphs)))


(defvar emacsos/load-configuration-list
  nil
  "List of configuration files to load.")

(add-hook 'after-init-hook (lambda ()
							 (dolist (conf emacsos/load-configuration-list)
							   (load conf))))


(defmacro load-configuration (conf &optional after-init)
  "Load all configurations"
  (let ((filename (concat user-emacs-directory
						  "configuration/"
						  (symbol-name conf))))
	(if after-init
		`(add-to-list 'emacsos/load-configuration-list ,filename)
	  `(load ,filename))))


(defun emacsos/keyword-to-string (kw)
  "Convert a keyword symbol to a string"
  (substring (symbol-name kw) 1))


(defmacro load-configurations (&rest confs)
  "Load all configurations"
  (cons
   'progn
   (let ((prefix ""))
	 (cl-loop
	  for conf in confs
	  if (keywordp conf)
	  do (setq prefix (concat (emacsos/keyword-to-string conf) "/"))
	  else collect `(load-configuration ,(intern (concat prefix (symbol-name conf))))))))


(load-configurations
 audio
 autocomplete-config
 buffers
 dired
 display-config
 markdown
 misc-config
 navigation
 org
 project-vc-config
 ;; search-config
 web
 :applications
 stack-exchange
 :display
 modeline
 :lang
 python)


(defmacro when-system-dependency (dependencies &rest body)
  "Execute body when all dependencies from the system are met"
  (let ((condition
		 (if (listp dependencies)
			 `(and ,@(mapcar (lambda (dependency)
							 `(executable-find ,dependency))
						   dependencies))
		   `(executable-find ,dependencies))))
	`(when ,condition
	   ,@body)))

(when-system-dependency
 ("ocaml" "opam") (load-configuration lang/ocaml :after-init))

;; (when-system-dependency
;;  "sbcl" (load-configuration "common-lisp"))

(when-system-dependency
 "mix"
 (load-configuration lang/elixir :after-init))


(when (equal window-system 'x)
  (load-configuration window-manager)
  (exwm-init))


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



(when-system-dependency
 "docker"
 (load-configuration docker :after-init))


(use-package projectile
  :straight t

  :init
  (projectile-mode 1))


(use-package dashboard
  :straight t

  :custom
  (dashboard-items '((recents . 5)
					 (projects . 5)))
  (dashboard-startup-banner (concat user-emacs-directory "img/gods_lament.png"))
  (dashboard-banner-logo-title "")

  :config
  (dashboard-setup-startup-hook))


(use-package restart-emacs
  :straight t
  :custom
  (restart-emacs-restore-frames t))


(use-package evil
  :straight t

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
  :straight t

  :config
  (highlight-defined-mode 1))


(use-package browse-url
  :custom
  (browse-url-browser-function 'browse-url-generic)
  (browse-url-generic-program "firefox"))


(use-package all-the-icons
  :straight t

  :config
  (use-package all-the-icons-dired
	:straight t))


(use-package neotree
  :straight t

  :config
  (neotree-hidden-file-toggle)

  :bind
  (:map
   neotree-mode-map
   ("h" . 'neotree-hidden-file-toggle)
   ("m" . neotree-rename-node)))


(use-package fancy-battery
  :straight t

  :config
  (fancy-battery-mode 1))


(use-package multiple-cursors
  :straight t

  :bind
  (("C-S-c C-S-c" . mc/edit-lines)
   ("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-c C-<" . mc/mark-all-like-this)))



(add-to-list 'load-path "~/.emacs.d/lisp/")


(global-set-key (kbd "<XF86Calculator>") 'calc)

(global-set-key (kbd "<XF86LaunchB>") 'dmenu)


(use-package evil-surround
  :straight t

  :bind
  (("s-s c" . evil-surround-change)
   ("s-s d" . evil-surround-delete)))



(use-package subword-mode
  :hook
  ((java-mode csharp-mode haskell-mode) . subword-mode))



(global-set-key (kbd "s-n") 'make-frame-command)


(when window-system
  (define-key input-decode-map [?\C-i] "\C-i")
  (define-key input-decode-map [?\C-m] "\C-m"))



(use-package imenu
  :ensure t

  :bind
  (("s-I" . imenu)))


(use-package ranger
  :straight t)


(use-package macrostep
  :straight t

  :bind
  ("s-M" . macrostep-mode))


(defun screen-shot ()
  (interactive)
  (shell-command "scrot ~/Pictures/" nil))


(use-package hydra
  :straight t

  :bind
  ([menu] . caps-hydra/body)

  :config
  (defhydra caps-hydra (:exit t :hint nil)
	"
Main menu
-------------------------------------------------
_e_: flycheck list   _l_: line numbers       _w_: window Management
_f_: ranger          _s_: system functions   _W_: clean whitespace
_g_: goto hydra      _t_: open terminal      _x_: M-x
"
	("e" (flycheck-list-errors) "flycheck list")
	("f" (call-interactively #'ranger) "ranger")
	("g" (goto-hydra/body) "goto")
	("l" (line-numbers-hydra/body) "display-line-numbers")
	("s" (system-hydra/body) "System")
	("t" (ansi-term shell-file-name) "terminal")
	("w" (windows-hydra/body) "windows")
	("W" (whitespace-cleanup) "clean whitespace")
	("x" (call-interactively (key-binding (kbd "M-x"))) "M-x")
	("P" (list-processes))
	("<menu>" nil "toggle caps menu"))

  (defhydra goto-hydra (:color blue :exit t)
	"Goto common things"
	("c" (find-file custom-file) "custom file")
	("C" (counsel-find-file (expand-file-name "configuration" user-emacs-directory)) "find a configuration file")
	("i" (find-file user-init-file) "init file")
	("s" (switch-to-buffer "*scratch*"))
	("r" (find-file "/home/egregius313/Projects/recipes/recipes.org")))

  (defun suspend-system ()
	(interactive)
	(start-process "suspend" nil "systemctl" "suspend"))
  
  (defhydra system-hydra (:exit t)
	"System operations"
	("l" (emacos/lock-screen) "Lock screen")
	("m" (call-interactively #'man) "man")
	("n" (network-hydra/body) "Network")
	("s" (progn
		   (emacsos/screen-lock)
		   (suspend-system)) "Suspend"))

  (defhydra network-hydra (:exit t)
	("i" (ifconfig) "ifconfig")
	("p" (call-interactively #'ping) "ping")
	("P" (ping "8.8.8.8") "ping 8.8.8.8"))

  (defhydra line-numbers-hydra (:exit t)
	"Hydra for display-line-numbers"
	("r" (progn
		   (case display-line-numbers-type
			 ('absolute (setq display-line-numbers-type 'relative))
			 ('relative (setq display-line-numbers-type 'absolute)))
		   (display-line-numbers--turn-on))
	 "toggle relative")
	("l" (call-interactively #'display-line-numbers-mode) "toggle line numbers")))


(use-package transpose-frame
  :straight t)


(defhydra windows-hydra (:hint nil)
  "
^Window Management^    ^Flip^                  ^Rotate^            ^Grow/Shrink^                  ^Movement^
---------------------------------------------------------------------------------------------------------------
_d_: Kill window       _V_: Flip vertically    _r_: Clockwise      _<left>_: Shrink horizontally  _h_: left
_o_: Ace window        _H_: Flip horizontally  _R_: Anticlockwise  _<right>_: Grow horizontally   _j_: down
_|_: Vertical split                                            _<down>_: Shrink vertically    _k_: up
_-_: Horizontal split                                          _<up>_: Grow vertically        _l_: right
"
  ("d" (delete-window) :color blue)
  ("V" (flip-frame))
  ("H" (flop-frame))
  ("r" (rotate-frame-clockwise))
  ("R" (rotate-frame-anticlockwise))
  ("<left>" (call-interactively #'shrink-window-horizontally))
  ("<right>" (call-interactively #'enlarge-window-horizontally))
  ("<down>" (call-interactively #'shrink-window))
  ("<up>" (call-interactively #'enlarge-window))
  ("h" (windmove-left))
  ("j" (windmove-down))
  ("k" (windmove-up))
  ("l" (windmove-right))
  ("o" (call-interactively #'ace-window) :color blue)
  ("|" (split-window-right))
  ("-" (split-window-below))
  ("q" nil))


(use-package sudo-edit
  :straight t)
