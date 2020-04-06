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


(defmacro load-configuration (configuration-name)
  (let* ((name (symbol-name configuration-name))
         (config-name (concat "config-" name))
         (config (if (string-prefix-p "lang/" name)
                     name
                   config-name)))
    `(require
      ',(intern config-name)
      ,(expand-file-name config (expand-file-name "configuration" user-emacs-directory)))))


(load-configuration display/sidebars)


;;; Startup
(block startup
  (use-package emacs
    :straight nil
    :custom
    ;; Technically from startup.el, but startup.el doesn't provide a feature.
    (inhibit-startup-message t)
    (ring-bell-function nil)))


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

(use-package zerodark-theme
  :config
  (load-theme 'zerodark))

;;;; Superfluous Sidebars
;; Unnecessary side/menu/tool bars get in the way of text. Let's fix
;; that.



;;;; Icons
(use-package all-the-icons
  :config
  (use-package all-the-icons-dired))

;;;; Misc-
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
  :commands (fancy-battery-mode)
  :defer t
  :hook
  (doom-modeline . fancy-battery-mode))


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
;; (set-frame-font "Fira Code 8")

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; (add-to-list 'load-path (expand-file-name "configuration" user-emacs-directory))

(setf egregius313/user-emacs-configuration-directory (expand-file-name "configuration" user-emacs-directory))
(add-to-list 'load-path egregius313/user-emacs-configuration-directory)
(add-to-list 'load-path (expand-file-name "lang" egregius313/user-emacs-configuration-directory))

(require 'config-backups)


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
  :defer 5

  :config
  (put 'upcase-region 'disabled nil)
  (put 'downcase-region 'disabled nil)

  :bind
  (:map selected-keymap
        ("u" . upcase-region)
        ("l" . downcase-region)))


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

;;;; Quoted Insert
(define-key global-map (kbd "C-S-q") #'quoted-insert)

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


;;;; TODOs

(use-package hl-todo
  :hook
  (prog-mode . hl-todo-mode))

;;; Navigation
(use-package buffer-expose
  :commands (buffer-expose buffer-expose-stars)
  :bind
  ("<s-tab>" . my/buffer-expose)
  ("s-#" . buffer-expose)
  ("s-*" . buffer-expose-stars)

  :config
  (defun my/buffer-expose (&optional show-stars)
    (interactive "p")
    (if show-stars
        (buffer-expose)
      (buffer-expose-no-stars))))

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
(use-package page-break-lines
  :hook
  (emacs-lisp-mode . page-break-lines-mode))


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
  "list of configuration files to load.")

(add-hook 'after-init-hook (lambda ()
                             (dolist (conf emacsos/load-configuration-list)
                               (load conf))))


(defmacro load-configuration* (conf &optional after-init)
  "load all configurations"
  ;;  (interactive (intern (read-string "configuration: ")))
  (let ((filename (concat user-emacs-directory
                          "configuration/"
                          (symbol-name conf))))
    (if after-init
        `(add-to-list 'emacsos/load-configuration-list ,filename)
      `(load ,filename))))


(defun emacsos/keyword-to-string (kw)
  "convert a keyword symbol to a string"
  (declare (pure t))
  (substring (symbol-name kw) 1))


(defmacro load-configurations (&rest confs)
  "load all configurations"
  (cons
   'progn
   (let ((prefix ""))
     (cl-loop
      for conf in confs
      if (keywordp conf)
      do (setq prefix (concat (emacsos/keyword-to-string conf) "/"))
      else collect `(load-configuration* ,(intern (concat prefix (symbol-name conf))))))))


(load-configurations
 audio
 buffers
 ;; dired
 markdown
 misc-config
 navigation
 ;; org
 ;; search-config
 web
 :applications
 stack-exchange
 ;; :display
 ;; modeline
 ;; :lang
 ;; python
 )


(defun emacsos/has-dependency-p (dependency &rest dependencies)
  (and (executable-find dependency)
     (cl-loop for dependency in dependencies
              always (executable-find dependency))))


(defmacro when-system-dependency (dependencies &rest body)
  "execute body when all dependencies from the system are met"
  (let ((condition
         (if (listp dependencies)
             `(and ,@(mapcar (lambda (dependency)
                             `(executable-find ,dependency))
                           dependencies))
           `(executable-find ,dependencies))))
    `(when ,condition
       ,@body)))



;; (when-system-dependency
;;  ("ocaml" "opam") (load-configuration* lang/ocaml :after-init))

;; (when-system-dependency
;;  "sbcl" (load-configuration* "common-lisp"))


;;;;; only add these short cuts to editing mode
;; (key-chord-define-global "xb" (key-binding (kbd "C-x b")))
;; (key-chord-define-global "xc" (key-binding (kbd "C-x C-c")))
;; (key-chord-define-global "xf" (key-binding (kbd "C-x C-f")))
;; (key-chord-define-global "xk" (key-binding (kbd "C-x k")))
;; (key-chord-define-global "xs" (key-binding (kbd "C-x C-s"))))



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
    "indent current buffer according to major mode"
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
  ("s-x" . counsel-m-x)
  ("s-i" . counsel-imenu))


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



(use-package dmenu
  :straight t
  :defer t
  :commands (dmenu)
  :bind
  ("<XF86LaunchB>" . dmenu))



(use-package anzu
  :diminish anzu-mode

  :custom
  (anzu-cons-mode-line-p nil)

  :bind
  (([remap query-replace] . anzu-query-replace)
   ([remap query-replace-regexp] . anzu-query-replace-regexp))

  :config
  (global-anzu-mode 1))


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
;;   (("s-i" . imenu)))


(use-package ranger
  :defer t)


(use-package hydra
  :bind
  ([menu] . caps-hydra/body)

  :config
  (load-configuration* emacsos/hydras)

  (require 'emacsos/screen-hydra)

  (defhydra caps-hydra (:exit t :hint nil)
    "
main menu
-------------------------------------------------
_e_: flycheck list   _l_: line numbers       _w_: window management
_f_: ranger          _s_: system functions   _W_: clean whitespace
_g_: goto hydra      _t_: open terminal      _x_: m-x
"
    ("e" (flycheck-list-errors) "flycheck list")
    ("f" (call-interactively #'ranger) "ranger")
    ("g" (goto-hydra/body) "goto")
    ("i" (call-interactively #'set-input-method))
    ("l" (line-numbers-hydra/body) "display-line-numbers")
    ("S" (system-hydra/body) "system")
    ("s" (emacsos/screen-hydra/body) "screen")
    ("t" (ansi-term shell-file-name) "terminal")
    ("w" (windows-hydra/body) "windows")
    ("W" (whitespace-cleanup) "clean whitespace")
    ("C-w" (call-interactively 'whitespace-mode) "whitespace mode")
    ("x" (call-interactively (key-binding (kbd "M-x"))) "M-x")
    ("p" (list-processes))
    ("<menu>" nil "toggle caps menu"))

  (defhydra goto-hydra (:color blue :exit t)
    "goto common things"
    ("C" (find-file custom-file) "custom file")
    ("c" (counsel-find-file (expand-file-name "configuration" user-emacs-directory)) "find a configuration file")
    ("i" (find-file user-init-file) "init file")
    ("s" (switch-to-buffer "*scratch*"))
    ("r" (find-file "/home/egregius313/projects/recipes/recipes.org")))

  (defun suspend-system ()
    (interactive)
    (start-process "suspend" nil "systemctl" "suspend"))

  (defhydra system-hydra (:exit t)
    "system operations"
    ("l" (emacsos/screen-lock) "lock screen")
    ("m" (call-interactively #'man) "man")
    ("n" (network-hydra/body) "network")
    ("s" (progn
           (emacsos/screen-lock)
           (suspend-system)) "suspend"))

  (defhydra line-numbers-hydra (:exit t)
    "hydra for display-line-numbers"
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
    "display changes"
    ("1" (progn
           (setq exwm-randr-workspace-monitor-plist
                 '(0 "HDMI1" 1 "EDP1" 2 "HDMI1"))
           (shell-command "xrandr --output HDMI1 --left-of EDP1 --auto")
           (exwm-randr--init)
           (exwm-randr-refresh)))
    ("2" (progn
           (setq exwm-randr-workspace-monitor-plist nil)
           (exwm-randr-refresh)))))


(eval-after-load 'windmove
  (defhydra windows-hydra (:hint nil)
    "
^window management^    ^flip^                  ^rotate^            ^grow/shrink^                  ^movement^
---------------------------------------------------------------------------------------------------------------
_d_: kill window       _v_: flip vertically    _r_: clockwise      _<left>_: shrink horizontally  _h_: left
_o_: ace window        _h_: flip horizontally  _r_: anticlockwise  _<right>_: grow horizontally   _j_: down
_|_: vertical split                                            _<down>_: shrink vertically    _k_: up
_-_: horizontal split                                          _<up>_: grow vertically        _l_: right
_D_: manage displays
"
    ("d" (delete-window) :color blue)
    ("v" (flip-frame))
    ("h" (flop-frame))
    ("r" (rotate-frame-clockwise))
    ("r" (rotate-frame-anticlockwise))
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


;;; emacsos
;; emacs is a great operating system

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


;;; bookmarks

(use-package bookmark
  :straight nil)

;; (use-package bookmark-plus
;;   :after bookmark
;;   :straight t)

;;; misc

(block documentation
  (use-package eldoc
    :straight nil
    :diminish eldoc-mode))


(use-package calc
  :straight nil

  :bind
  ("<XF86Calculator>" . calc))


(put 'narrow-to-region 'disabled nil)


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


(use-package enum
  :straight (enum :type git
                  :host gitlab
                  :repo "emacsos/enum.el"))


(use-package find-func
  :straight nil
  :custom
  (find-function-c-source-directory (expand-file-name "~/gitdownloads/emacs/src")))



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
  :commands (vterm)
  :bind
  ("s-v" . vterm))


;; configuration for proof assistants, e.g. coq

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
                      ("bool" . #x1d539)
                      ("forall" . 8704)
                      ("fun" . 955)
                      ("exists" . 8707)
                      ("=>" . 8658)
                      ("->" . 8594))))))


(use-package coq-mode
  :straight nil
  :after proof-general

  :bind
  ("s-n" . proof-assert-next-command-interactive)

  :hook
  (coq-mode . proof-electric-terminator-enable))



(load-configuration* window-manager)
(when (and window-system (equal window-system 'x))
  ;; (shell-command "rm -rf /home/egregius313/.emacs.d/elpa/exwm-*")
  (exwm-init))

(load-configuration org)

(use-package org-ref
  :defer t
  :straight t

  :custom
  (reftex-default-bibliography '("~/org/bibliography/references.bib"))
  (org-ref-bibliography-notes "~/org/bibliography/notes.org")
  (org-ref-default-bibliography '("~/org/bibliography/references.bib"))
  (org-ref-pdf-directory "~/org/bibliography/bibtex-pdfs/"))




(load-configuration autocomplete)
(load-configuration dired)
(load-configuration display/modeline)
(load-configuration lsp)
(load-configuration spelling)
(load-configuration docker)

;; elfeed
(load-configuration rss)

(when (emacsos/has-dependency-p "ghc")
  (load-configuration lang/haskell))

(load-configuration lang/ruby)

(when (emacsos/has-dependency-p "mix")
  (load-configuration lang/elixir))

(when (emacsos/has-dependency-p "ocaml" "opam")
  (load-configuration lang/ocaml))

(when (emacsos/has-dependency-p "sbcl")
  (load-configuration lang/common-lisp))

(when (executable-find "pacman")
  (load-configuration archlinux))


(use-package xkcd
  :defer t
  :commands (xkcd xkcd-get)

  :config
  (org-add-link-type "xkcd" 'org-xkcd-open)
  (add-hook 'org-store-link-functions 'org-xkcd-store-link)
  
  (defun org-xkcd-open (num)
    (xkcd-get (string-to-number num)))

  (defun org-xkcd-store-link ()
    "Store a link to an xkcd comic."
    (when (eq major-mode 'xkcd-mode)
      (let ((num (number-to-string xkcd-cur)))
        (org-store-link
         :type "xkcd"
         :link (concat "xkcd:" num)
         :description (expand-file-name num xkcd-cache-dir)))))

  :bind
  (:map xkcd-mode-map
        ("p" . xkcd-prev)
        ("n" . xkcd-next)))


(use-package x86-lookup
  :custom
  (x86-lookup-pdf "~/Downloads/325383-sdm-vol-2abcd.pdf")
  (x86-lookup-browse-pdf-function 'x86-lookup-browse-pdf-browser))
