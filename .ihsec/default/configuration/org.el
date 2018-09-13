(use-package org
  :ensure t

  :config
  (setq org-ellipsis " ")
  (add-to-list 'org-structure-template-alist
			   '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ditaa . t))))


(use-package org-bullets
  :ensure t

  :hook
  (org-mode . org-bullets-mode))




