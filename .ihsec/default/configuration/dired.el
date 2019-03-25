(use-package dired
  :custom
  (dired-dwim-target t)
  
  :init
  (require 'dired)
  
  (defun dired-back-to-top ()
	"Goto the beginning of the directory listing"
	(interactive)
	(beginning-of-buffer)
	(if (equal dired-details-state 'hidden)
		(dired-next-line 3)
	  (dired-next-line 4)))

  (defun dired-down-to-bottom ()
	"Goto the last listing entry"
	(interactive)
	(end-of-buffer)
	(dired-previous-line 1))
  
  (use-package dired-details
	:straight t

	:custom
	(dired-details-hidden-string "")
	
	:config
	(dired-details-install))

  :bind
  (:map dired-mode-map
		([remap beginning-of-buffer] . dired-back-to-top)
		([remap end-of-buffer] . dired-down-to-bottom)))
