;;; Emacs Lisp implementation of the Zsh `z' plugin. Allows you to
;;; easily find a directory by a piece of it's name
(use-package eshell-z
  :config
  (require 'eshell-z)

  (defun find-file-z (dir)
	"Change directory to DIR."
	(interactive
	 (list (let ((paths
				  (sort (progn
						  (eshell-z--ensure-hash-table)
						  (eshell-z--hash-table-values eshell-z-freq-dir-hash-table))
						(lambda (elt1 elt2)
						  (> (eshell-z--frecent elt1)
							 (eshell-z--frecent elt2)))))
				 (ivy-sort-functions-alist nil))
			 (completing-read "pattern " paths nil t))))
	(find-file dir))

  :bind
  (:map
   counsel-find-file-map
   ("C-z" . find-file-z)))





