(require 'org)

(defun dotemacs-goto-configuration (configuration)
  "Open the configuration associated with `configuation'."
  (expand-file-name
   (concat "config-" configuration ".el")
   (expand-file-name "configuration" user-emacs-directory)))


(add-to-list 'org-link-abbrev-alist
			 '(("dotemacs" . "%(dotemacs-goto-configuration)")))
