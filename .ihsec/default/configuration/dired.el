;; -*- lexical-binding: t -*-

(use-package dired
  :straight nil

  :commands (dired-next-line
			 dired-previous-line
			 dired-get-marked-files)
  
  :custom
  (dired-dwim-target t)
  
  :init
  (require 'dired)
  
  (defun dired-back-to-top ()
	"Goto the beginning of the directory listing"
	(interactive)
	(goto-char (point-min))
	(dired-next-line 4))

  (defun dired-down-to-bottom ()
	"Goto the last listing entry"
	(interactive)
	(goto-char (point-max))
	(dired-previous-line 1))
  
  (defvar my/dired-extra-leader-map (make-sparse-keymap)
	"Keymap for extra functions.")

  (fset 'my/dired-extra-leader-map my/dired-extra-leader-map)
  
  (defun my/dired-extra-byte-compile ()
	(interactive)
	(let ((files (dired-get-marked-files)))
	  (dolist (file files)
		(when (file-regular-p file)
		  (byte-compile-file file)))))

  ;; :bind-keymap
  ;; (:map dired-mode-map
  ;;  ("," . my/dired-extra-leader-map))
  
  :bind
  (:map
   dired-mode-map
   ([remap beginning-of-buffer] . dired-back-to-top)
   ([remap end-of-buffer] . dired-down-to-bottom)
   ("," . my/dired-extra-leader-map)
   
   :map
   my/dired-extra-leader-map
   ("c" . my/dired-extra-byte-compile)))


(use-package dired-details
  ;; :quelpa (dired-details :fetcher wiki)
  :after dired
  :defer t
  :commands (dired-details-install)
  
  :custom
  (dired-details-hidden-string "")
  
  :config
  (dired-details-install)

  (require 'dired-details)
  
  (defun dired-back-to-top ()
	"Goto the beginning of the directory listing"
	(interactive)
	(goto-char (point-min))
	(if (equal dired-details-state 'hidden)
		(dired-next-line 3)
	  (dired-next-line 4)))
  
  :bind
  (:map
   dired-mode-map
   ("(" . dired-hide-details-mode)
   (")" . dired-hide-details-mode)))


(use-package dired-subtree
  :after dired
  
  :bind
  (:map
   dired-mode-map
   ([tab] . dired-subtree-toggle)
   ([backtab] . dired-subtree-cycle)))
