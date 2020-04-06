(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(require 'diminish)

(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

(use-package company
  :defer t
  :diminish company-mode

  :custom
  (company-idle-delay 0)
  (company-minimum-prefix-length 3)
  
  :config
  ;; (dolist (backend '(company-eclim company-semantic))
  ;; 	(delq backend company-backends))
  (setq-default company-dabbrev-other-buffers 'all
				company-tooltip-align-annotations t)
  
  :bind
  (("M-C-/" . company-complete)
   :map
   company-mode-map
   ("M-/" . company-complete)
   :map
   company-active-map
   ("M-p" . nil)
   ("M-n" . nil)
   ("C-p" . company-select-previous)
   ("C-n" . company-select-next)
   ("C-d" . company-show-doc-buffer)
   ("M-." . company-show-location)
   ("M-/" . company-other-backend))

  :hook
  (after-init-hook . global-company-mode)
  (prog-mode . company-mode))


(use-package company-quickhelp
  :after company

  :hook
  (after-init-hook . company-quickhelp-mode))


;; Suspend page-break-lines-mode while company menu is active
;; (see https://github.com/company-mode/company-mode/issues/416)
(defvar-local sanityinc/page-break-lines-on-p nil)

(use-package page-break-lines
  :after company

  :commands (page-break-lines-mode)
  
  :config
  (defun sanityinc/page-break-lines-disable (&rest ignore)
	(when (setq sanityinc/page-break-lines-on-p (bound-and-true-p page-break-lines-mode))
	  (page-break-lines-mode -1)))

  (defun sanityinc/page-break-lines-maybe-reenable (&rest ignore)
	(when sanityinc/page-break-lines-on-p
	  (page-break-lines-mode 1)))

  (add-hook 'company-completion-started-hook 'sanityinc/page-break-lines-disable)
  (add-hook 'company-after-completion-hook 'sanityinc/page-break-lines-maybe-reenable))


(use-package yasnippet
  :defer t
  :diminish yas-minor-mode

  :commands (yas-expand yas-reload-all)
  
  :config
  (require 'company)
  (push (expand-file-name "snippets" user-emacs-directory) yas-snippet-dirs)
  
  :bind
  (("C-c y" . company-yasnippet)
   :map
   company-active-map
   ("C-<tab>" . yas-expand))

  :hook
  ((prog-mode . yas-minor-mode)
   (org-mode . yas-minor-mode)
   (eshell-mode . yas-minor-mode)))


(use-package yasnippet-snippets
  :after yasnippet
  :config
  (yas-reload-all))


(provide 'config-autocomplete)
