(require 'subr-x)
(straight-use-package 'git)

(defun org-git-version ()
  "The Git version of org-mode.
Inserted by installing org-mode or when a release is made."
  (require 'git)
  (let ((git-repo (expand-file-name
				   "straight/repos/org/" user-emacs-directory)))
	(string-trim
	 (git-run "describe"
			  "--match=release\*"
			  "--abbrev=6"
			  "HEAD"))))

(defun org-release ()
  "The release version of org-mode.
Inserted by installing org-mode or when a release is made."
  (require 'git)
  (let ((git-repo (expand-file-name
				   "straight/repos/org/" user-emacs-directory)))
	(string-trim
	 (string-remove-prefix
	  "release_"
	  (git-run "describe"
			   "--match=release\*"
			   "--abbrev=0"
			   "HEAD")))))

(provide 'org-version)

;; (straight-use-package 'org) ; or org-plus-contrib if desired

(use-package org-plus-contrib
  :mode ("\\.org\\'" . org-mode)
  
  :custom
  (org-ellipsis " ")
  (org-use-speed-commands t)
  
  :config
  (add-to-list 'org-structure-template-alist
			   '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist
			   '("abs" . "abstract"))

  ;; (org-babel-do-load-languages
  ;;  'org-babel-load-languages
  ;;  '((ditaa . t)))

  (require 'org-tempo))


(use-package org-id
  :straight nil

  :bind
  (:map
   org-mode-map
   ("s-i" . org-id-get-create)))


(use-package org-agenda
  :after org
  :straight nil

  :config
  (add-to-list 'org-agenda-files "~/org/agendas"))


(use-package org-bullets
  :after org
  
  :hook
  (org-mode . org-bullets-mode))


(use-package org-contacts
  :straight nil)


(use-package org-brain
  :after org
  :straight t

  :commands (org-brain-visualize org-brain-goto)

  :bind
  (:map
   goto-hydra/keymap
   ("b" . (lambda ()
			(interactive)
			(switch-to-buffer "*org-brain*"))))

  :config
  (add-to-list 'org-contacts-files "~/org/brain/" t))


(use-package ispell
  :straight nil
  :after company
  :config
  (add-to-list 'company-backends 'company-ispell)
  :hook
  (org-mode . company-mode))
