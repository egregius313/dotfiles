;; Bindings for EXWM



(defvar emacsos/bindings-class-simulation-keys nil
  "Bindings to be used for EXWM local bindings based on class name.")


(defmacro emacsos/binding-define-application (application &rest simulation-keys)
  (let ((name (cond
			   ((stringp application) application)
			   ((keywordp application) (substring (symbol-name application) 1))
			   ((symbolp application) (symbol-name application)))))
	`(add-to-list 'emacsos/bindings-class-simulation-keys
				  '(,name . ,simulation-keys))))


(emacsos/binding-define-application
 st-256color
 ([C-a] ?\C-a)
 ([C-b] ?\C-b)
 ([C-c C-c] ?\C-c)
 ([C-k] ?\C-k))


(defun emacsos/bindings-setup-hook ()
  "Setup the correct simulation keys"
  (let ((simulation-keys (assoc-default exwm-class-name emacsos/bindings-class-simulation-keys)))
	(when (and exwm-class-name
			 simulation-keys)
	  (exwm-input-set-local-simulation-keys simulation-keys))))

