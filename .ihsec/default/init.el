;; -*- lexical-binding: t; indent-tabs-mode: nil -*-

;;; Macros organization
(eval-when-compile
  (require 'cl-lib)
  (unless (fboundp 'block)
    (defalias 'block 'cl-block)))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;;; Package management
;;;; straight.el setup
;; I use straight so I can build all my packages from source and not
;; need to worry about package.el
(defvar bootstrap-version)

(eval-and-compile
  (defvar bootstrap-file 
    (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory)
    "File to bootstrap the package manager"))

(eval-when-compile
  (let ((bootstrap-version 5))
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
          (url-retrieve-synchronously
           "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
           'silent 'inhibit-cookies)
        (goto-char (point-max))
        (eval-print-last-sexp)))))

(load bootstrap-file nil 'nomessage)
(require 'straight)

;;;; use-package
(eval-when-compile
  (straight-use-package 'use-package)
  (require 'use-package))
(eval-and-compile
  (use-package bind-key
    :straight t)
  (setq straight-use-package-by-default t)
  (setq-default use-package-enable-imenu-support t))

;; (use-package quelpa-use-package)


;;; Startup
(block startup
  (setq inhibit-startup-message t)
  (setq ring-bell-function nil))


;;;; Dashboard
;; Feature a nice dashboard instead of the usual startup message.
(use-package dashboard
  :custom
  (dashboard-items '((recents . 5)
                     (projects . 5)
                     (bookmarks . 5)))
  (dashboard-startup-banner
   (expand-file-name "img/gods_lament.png" user-emacs-directory))
  (dashboard-banner-logo-title "")
  
  :config
  (dashboard-setup-startup-hook))

;;; Appearance
;;;; Themes
(use-package monokai-theme
  :custom
  (custom-enabled-themes '(monokai))

  :config
  (add-to-list
   'custom-safe-themes
   '("2925ed246fb757da0e8784ecf03b9523bccd8b7996464e587b081037e0e98001" default))
  (load-theme 'monokai))

(use-package solarized-theme)
(use-package zerodark-theme)

;;;; Superfluous Sidebars
;; Unnecessary side/menu/tool bars get in the way of text. Let's fix
;; that.

(block superfluous-sidebars
  (use-package scroll-bar
    :straight nil
    :custom
    (scroll-bar-mode nil))

  (use-package tool-bar
    :straight nil
    :custom
    (tool-bar-mode nil))

  (use-package menu-bar
    :straight nil
    :custom
    (menu-bar-mode nil)))

;;;; Icons
(use-package all-the-icons
  :config
  (use-package all-the-icons-dired))

;;;; Misc
(use-package pretty-mode
  :if window-system
  :config
  (global-pretty-mode t))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;; Modeline
;; Used by use-package for the :diminish keyword to work
(use-package diminish)

;;;; Doom modeline
(use-package doom-modeline
  :commands (doom-modeline-mode)

  :custom
  (doom-modeline-buffer-file-name-style 'buffer-name)
  (doom-modeline-major-mode-color-icon t)

  :config
  ;; (doom-modeline-mode 1)
  (add-hook 'after-init-hook #'doom-modeline-mode))

;;;; Time
(use-package time
  :custom
  (display-time-24hr-format t)
  (display-time-format "%H:%M - %B %d %Y")
  (display-time-mode t))

;;;; Line and column numbers

(use-package simple
  :straight nil
  :custom
  (line-number-mode t)
  (column-number-mode t))


;;;; Battery
;; Information about the system's battery
(use-package fancy-battery
  :after doom-modeline
  :defer t
  :hook
  (doom-modeline))


;;;; Nyan Cat
(use-package nyan-mode
  :commands (nyan-mode)

  :custom
  (nyan-animate-nyancat t)
  (nyan-wavy-trail nil)

  :config
  (add-hook 'doom-modeline-mode-hook 'nyan-mode))

(when (and (fboundp 'doom-modeline-mode)
         (fboundp 'nyan-mode))
  (doom-modeline-mode 1)
  (nyan-mode 1))


;;;; Font
(set-frame-font "Fira Code 8")


;;; Backups and synchronization
(use-package autorevert
  :straight nil
  :diminish auto-revert-mode)

;;;; Cleanup autosaves
(use-package files
  :straight nil
  :custom
  (backup-by-copying t "don't clobber symlinks")
  (backup-directory-alist '(("." . "~/.saves/")) "don't litter my fs tree")
  (delete-old-versions t)
  (kept-new-versions 6)
  (kept-old-versions 2)
  (version-control t "use versioned backups"))


;;; Keyboard configuration
;;;; Chords
(eval-and-compile
  (use-package key-chord
    :custom
    (key-chord-two-keys-delay 0.2)

    :bind
    (([key-chord ?x ?o] . other-window)
     ([key-chord ?x ?b] . ido-switch-buffer)
     :map minibuffer-local-map
     ([key-chord ?g ?g] . minibuffer-keyboard-quit))

    :config
    (key-chord-mode 1))
  (use-package use-package-chords))


;;;; Multiple cursors

(use-package phi-search
  :defer 5)

(use-package selected
  :defer 5)


(use-package multiple-cursors
  :after (phi-search selected)
  :defer 5

  ;; - Sometimes you end up with cursors outside of your view. You can scroll
  ;;   the screen to center on each cursor with `C-v` and `M-v`.
  ;;
  ;; - If you get out of multiple-cursors-mode and yank - it will yank only
  ;;   from the kill-ring of main cursor. To yank from the kill-rings of every
  ;;   cursor use yank-rectangle, normally found at C-x r y.

  :bind
  (("C-S-c C-S-c" . mc/edit-lines)
   ("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-c C-<" . mc/mark-all-like-this)

   ("<C-m> ^"     . mc/edit-beginnings-of-lines)
   ("<C-m> `"     . mc/edit-beginnings-of-lines)
   ("<C-m> $"     . mc/edit-ends-of-lines)
   ("<C-m> '"     . mc/edit-ends-of-lines)
   ("<C-m> R"     . mc/reverse-regions)
   ("<C-m> S"     . mc/sort-regions)
   ("<C-m> W"     . mc/mark-all-words-like-this)
   ("<C-m> Y"     . mc/mark-all-symbols-like-this)
   ("<C-m> a"     . mc/mark-all-like-this-dwim)
   ("<C-m> c"     . mc/mark-all-dwim)
   ("<C-m> l"     . mc/insert-letters)
   ("<C-m> n"     . mc/insert-numbers)
   ("<C-m> r"     . mc/mark-all-in-region)
   ("<C-m> s"     . set-rectangular-region-anchor)
   ("<C-m> %"     . mc/mark-all-in-region-regexp)
   ("<C-m> t"     . mc/mark-sgml-tag-pair)
   ("<C-m> w"     . mc/mark-next-like-this-word)
   ("<C-m> x"     . mc/mark-more-like-this-extended)
   ("<C-m> y"     . mc/mark-next-like-this-symbol)
   ("<C-m> C-x"   . reactivate-mark)
   ("<C-m> C-SPC" . mc/mark-pop)
   ("<C-m> ("     . mc/mark-all-symbols-like-this-in-defun)
   ("<C-m> C-("   . mc/mark-all-words-like-this-in-defun)
   ("<C-m> M-("   . mc/mark-all-like-this-in-defun)
   ("<C-m> ["     . mc/vertical-align-with-space)
   ("<C-m> {"     . mc/vertical-align)

   ("S-<down-mouse-1>")
   ("S-<mouse-1>" . mc/add-cursor-on-click))

  :config
  (require 'selected)

  :bind (:map selected-keymap
              ("c"   . mc/edit-lines)
              ("."   . mc/mark-next-like-this)
              ("<"   . mc/unmark-next-like-this)
              ("C->" . mc/skip-to-next-like-this)
              (","   . mc/mark-previous-like-this)
              (">"   . mc/unmark-previous-like-this)
              ("C-<" . mc/skip-to-previous-like-this)
              ("y"   . mc/mark-next-symbol-like-this)
              ("Y"   . mc/mark-previous-symbol-like-this)
              ("w"   . mc/mark-next-word-like-this)
              ("W"   . mc/mark-previous-word-like-this))

  :preface
  (defun reactivate-mark ()
    (interactive)
    (activate-mark)))


(use-package mc-extras
  :after multiple-cursors
  :bind (("<C-m> M-C-f" . mc/mark-next-sexps)
         ("<C-m> M-C-b" . mc/mark-previous-sexps)
         ("<C-m> <"     . mc/mark-all-above)
         ("<C-m> >"     . mc/mark-all-below)
         ("<C-m> C-d"   . mc/remove-current-cursor)
         ("<C-m> C-k"   . mc/remove-cursors-at-eol)
         ("<C-m> M-d"   . mc/remove-duplicated-cursors)
         ("<C-m> |"     . mc/move-to-column)
         ("<C-m> ~"     . mc/compare-chars)))

;; (use-package mc-freeze
;;   :after multiple-cursors
;;   :bind ("<C-m> f" . mc/freeze-fake-cursors-dwim))


;; (use-package mc-rect
;;   :after multiple-cursors
;;   :bind ("<C-m> ]" . mc/rect-rectangle-to-multiple-cursors))


;;; Text editing
(setq-default tab-width 4)

(use-package unfill
  :bind
  ([remap fill-paragraph] . unfill-toggle))

(use-package evil-nerd-commenter
  :defer t

  :commands (evilnc-default-hotkeys)

  :config
  (evilnc-default-hotkeys)

  :chords
  ((";p" . evilnc-comment-or-uncomment-paragraphs)))

(use-package string-inflection
  :bind
  (("C-c C-u" . string-inflection-all-cycle)
   :map python-mode-map
   ("C-c C-u" . string-inflection-python-style-cycle)
   :map java-mode-map
   ("C-c C-u" . string-inflection-java-style-cycle)
   :map ruby-mode-map
   ("C-c C-u" . string-inflection-ruby-style-cycle)))

;;;; Prefer UTF-8 Encoding
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;;; Parentheses
(use-package paren
  :straight nil
  :custom
  (show-paren-delay 0)
  (show-paren-mode t))

(use-package rainbow-delimiters
  :defer t
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package paredit
  :diminish paredit-mode

  :hook
  ((emacs-lisp-mode) . paredit-mode))


;;;; Line numbers
(use-package display-line-numbers
  :straight nil
  :custom
  (display-line-numbers-type 'relative "Use relative line numbers")

  :hook
  (prog-mode . display-line-numbers-mode))


;;; Navigation

;;; Projects
;;;; Projectile
(use-package projectile
  :defer t
  :bind
  (("s-p" . projectile-command-map)
   :map
   ctl-x-4-map
   ("s-p D" . projectile-dired-other-window)
   ("s-p f" . projectile-find-file-other-window))

  :config
  (projectile-mode 1))


;;;; Editorconfig
(use-package editorconfig
  :straight t
  :defer t
  :commands (editorconfig-mode)
  :diminish editorconfig-mode

  :config
  (editorconfig-mode 1))

;;; Emacs Lisp

;;;; Macroexpansion
(use-package macrostep
  :bind
  ("s-M" . macrostep-mode))


;; (use-package ido
;;   :straight nil
;;   :commands ido-mode
;;   :config
;;   (ido-mode 1)
;;   ;; Fancy M-x
;;   (use-package smex
;;     :after ido
;;     :bind
;;     ("M-x" . smex)))



(use-package hl-line
  :if window-system
  :hook
  (prog-mode . hl-line-mode))


(use-package compile
  :straight nil
  :bind
  ("s-c" . compile))


(defvar emacsos/load-path (expand-file-name "lisp" user-emacs-directory))


(defvar emacsos/load-configuration-list
  nil
  "List of configuration files to load.")

(add-hook 'after-init-hook (lambda ()
                             (dolist (conf emacsos/load-configuration-list)
                               (load conf))))


(defmacro load-configuration (conf &optional after-init)
  "Load all configurations"
  ;;  (interactive (intern (read-string "configuration: ")))
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
 markdown
 misc-config
 navigation
 org
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





;;; Only add these short cuts to editing mode
;; (key-chord-define-global "xb" (key-binding (kbd "C-x b")))
;; (key-chord-define-global "xc" (key-binding (kbd "C-x C-c")))
;; (key-chord-define-global "xf" (key-binding (kbd "C-x C-f")))
;; (key-chord-define-global "xk" (key-binding (kbd "C-x k")))
;; (key-chord-define-global "xs" (key-binding (kbd "C-x C-s"))))


(use-package docker
  :when (executable-find "docker")
  :defer t
  :config
  (use-package docker-compose-mode
    :after docker)

  (use-package docker-tramp
    :after docker)

  (use-package dockerfile-mode
    :after docker))


(block version-control
  (use-package magit
    :bind
    ("C-x g" . magit-status))

  (use-package forge
    :after magit)

  (use-package gist
    :defer t))


(use-package treemacs
  :defer t
  :bind
  ("C-c t" . treemacs))


;; (use-package restart-emacs
;;   :ensure t
;;   :defer t

;;   :custom
;;   (restart-emacs-restore-frames t))


(use-package evil
  :defer t

  :bind
  (("s-e" . evil-mode)
   :map evil-insert-state-map
   ("s-e" . evil-mode)
   :map evil-normal-state-map
   ("s-e" . evil-mode)))


(block indentation
  (defun indent-buffer ()
    "Indent current buffer according to major mode"
    (interactive)
    (indent-region (point-min) (point-max)))

  (use-package indent
    :straight nil
    :bind
    ("C-c <tab>" . indent-buffer)))


(use-package highlight-defined
  :defer t

  :config
  (highlight-defined-mode 1))


(use-package browse-url
  :custom
  (browse-url-browser-function 'browse-url-generic)
  (browse-url-generic-program "firefox"))


;; (use-package neotree
;;   :ensure t
;;   :defer t

;;   :config
;;   (neotree-hidden-file-toggle)

;;   :bind
;;   (:map
;;    neotree-mode-map
;;    ("h" . 'neotree-hidden-file-toggle)
;;    ("m" . neotree-rename-node)))


(use-package counsel
  :bind
  ("C-c k" . counsel-ag)
  ("s-x" . counsel-M-x)
  ("s-I" . counsel-imenu))


(use-package swiper
  :defer t
  :custom
  (ivy-use-virtual-buffers t)
  (enable-recursive-minibuffers t)

  :bind
  (("s-s" . swiper)
   :map
   swiper-map
   ("C-j" . swiper-avy)
   ("M-c" . swiper-mc)
   ("M-r" . swiper-query-replace)))


(add-to-list 'load-path "~/.emacs.d/lisp/")


(use-package anzu
  :diminish anzu-mode

  :custom
  (anzu-cons-mode-line-p nil)

  :bind
  (([remap query-replace] . anzu-query-replace)
   ([remap query-replace-regexp] . anzu-query-replace-regexp))

  :config
  (global-anzu-mode 1))


(use-package dmenu
  :straight t
  :defer t
  :bind
  ("<XF86LaunchB>" . dmenu))


(use-package evil-surround
  :defer t

  ;; :bind

  ;; (("s-s c" . evil-surround-change)
  ;;  ("s-s d" . evil-surround-delete))

  )



(use-package subword-mode
  :straight nil
  :hook
  ((java-mode csharp-mode haskell-mode) . subword-mode))


(when window-system
  (define-key input-decode-map [?\C-i] [C-i])
  (define-key input-decode-map [?\C-m] [C-m]))


;; (use-package imenu
;;   :bind
;;   (("s-I" . imenu)))


(use-package ranger
  :defer t)


(use-package hydra
  :bind
  ([menu] . caps-hydra/body)

  :config
  (load-configuration emacsos/hydras)

  (require 'emacsos/screen-hydra)

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
    ("I" (call-interactively #'set-input-method))
    ("l" (line-numbers-hydra/body) "display-line-numbers")
    ("s" (system-hydra/body) "System")
    ("S" (emacsos/screen-hydra/body) "screen")
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
    ("l" (emacsos/screen-lock) "Lock screen")
    ("m" (call-interactively #'man) "man")
    ("n" (network-hydra/body) "Network")
    ("s" (progn
           (emacsos/screen-lock)
           (suspend-system)) "Suspend"))

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
  :defer t)

(eval-after-load 'exwm
  (defhydra emacsos/window-display-hydra (:color blue :base-map (make-sparse-keymap))
    "Display changes"
    ("1" (progn
           (setq exwm-randr-workspace-monitor-plist
                 '(0 "HDMI1" 1 "eDP1" 2 "HDMI1"))
           (shell-command "xrandr --output HDMI1 --left-of eDP1 --auto")
           (exwm-randr--init)
           (exwm-randr-refresh)))
    ("2" (progn
           (setq exwm-randr-workspace-monitor-plist nil)
           (exwm-randr-refresh)))))


(eval-after-load 'windmove
  (defhydra windows-hydra (:hint nil)
    "
^Window Management^    ^Flip^                  ^Rotate^            ^Grow/Shrink^                  ^Movement^
---------------------------------------------------------------------------------------------------------------
_d_: Kill window       _V_: Flip vertically    _r_: Clockwise      _<left>_: Shrink horizontally  _h_: left
_o_: Ace window        _H_: Flip horizontally  _R_: Anticlockwise  _<right>_: Grow horizontally   _j_: down
_|_: Vertical split                                            _<down>_: Shrink vertically    _k_: up
_-_: Horizontal split                                          _<up>_: Grow vertically        _l_: right
_D_: Manage displays
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
    ("q" nil)
    ("D" (emacsos/window-display-hydra/body) :color blue)))


(use-package sudo-edit
  :defer t)

(server-start)


(use-package window
  :straight nil

  :config
  (eval-after-load 'exwm
    (dolist (k '(s-left
                 s-right
                 s-XF86MonBrightnessDown
                 s-XF86MonBrightnessUp))
      (cl-pushnew k exwm-input-prefix-keys)))

  :bind
  (([s-left] . previous-buffer)
   ([s-XF86MonBrightnessDown] . previous-buffer)
   ([s-right] . next-buffer)
   ([s-XF86MonBrightnessUp] . next-buffer)))


;;; EmacsOS
;; Emacs is a great operating system

(use-package emacsos/screen
  :after exwm
  :straight nil
  :load-path emacsos/load-path

  :config
  (emacsos/screen-enable-idle-lock))




;;; init.el-specific configuration
(block dotemacs
  (use-package outshine
    :straight t

    :hook
    (emacs-lisp-mode . outshine-mode))

  (use-package bookmark
    :straight nil
    :defer t
    :config
    (unless (bookmark-get-bookmark "." t)
      (save-excursion
        (find-file user-init-file)
        (goto-char 1)
        (bookmark-set ".")))))


;;; Bookmarks

(use-package bookmark
  :straight nil)

(use-package bookmark+
  :after bookmark
  :straight t)


;;; elfeed

(use-package elfeed)
(use-package elfeed-org
  :after (org elfeed)

  :custom
  (egregius313/feeds-directory (expand-file-name "~/Projects/feeds/"))
  (rmh-elfeed-org-files (directory-files egregius313/feeds-directory t ".org$"))

  :config
  (elfeed-org))


;;; Misc

(block documentation
  (use-package eldoc
    :straight nil
    :diminish eldoc-mode))


(use-package calc
  :straight nil

  :bind
  ("<XF86Calculator>" . calc))


(put 'narrow-to-region 'disabled nil)


;; (eval-after-load 'exwm
;;   (cl-pushnew 'XF86HomePage exwm-input-prefix-keys))
(global-set-key (kbd "<XF86HomePage>")
                (lambda ()
                  (interactive)
                  (switch-to-buffer dashboard-buffer-name)))



(use-package ido-vertical-mode
  :after ido
  :straight t

  :hook
  (projectile-mode ido-mode))


(use-package smex
  :after ido
  :straight t

  :bind
  ("M-x" . smex))


(block ruby
  (use-package ruby-refactor
    :after ruby-mode
    :straight t))


(use-package enum
  :straight (enum :type git
                  :host gitlab
                  :repo "emacsos/enum.el"))


(use-package md4rd
  :straight t)


(use-package find-func
  :straight nil

  :custom
  (find-function-C-source-directory (expand-file-name "~/gitdownloads/emacs/src")))


(use-package buffer-expose
  :bind
  ("<s-tab>" . my/buffer-expose)
  ("s-#" . buffer-expose)
  ("s-*" . buffer-expose-stars)

  :config
  (defun my/buffer-expose (&optional show-stars)
    (interactive "P")
    (if show-stars
        (buffer-expose)
      (buffer-expose-no-stars))))


(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "emacs-libvterm" user-emacs-directory))

(use-package application-complete
  :after exwm
  :straight nil

  :bind
  ("<XF86LaunchA>" . application-complete))


(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

(use-package vterm
  :straight nil
  :commands (vterm))

(add-to-list 'load-path (expand-file-name "modules/PG" user-emacs-directory))
(use-package proof-general
  :straight nil
  
  :custom
  (coq-compile-before-require t)

  :config
  (add-hook 'coq-mode
            (lambda ()
              (setf prettify-symbols-alist
                    '(("nat" . 8469)
                      ("bool" . #x1D539)
                      ("forall" . 8704)
                      ("fun" . 955)
                      ("exists" . 8707)
                      ("=>" . 8658)
                      ("->" . 8594))))))


(load-configuration window-manager)
(when (and window-system (equal window-system 'x))
  ;; (shell-command "rm -rf /home/egregius313/.emacs.d/elpa/exwm-*")
  
  (exwm-init))


(use-package org-ref
  :straight t
  
  :custom
  (reftex-default-bibliography '("~/org/bibliography/references.bib"))
  (org-ref-bibliography-notes "~/org/bibliography/notes.org")
  (org-ref-default-bibliography '("~/rg/bibliography/references.bib"))
  (org-ref-pdf-directory "~/rg/bibliography/bibtex-pdfs/"))
