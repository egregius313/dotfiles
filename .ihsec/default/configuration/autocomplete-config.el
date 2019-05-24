(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(require 'diminish)

(use-package company
  :defer 10

  :diminish company-mode

  :config
  (progn
    (setq company-idle-delay 0)
    (setq company-minimum-prefix-length 3))

  :bind
  (:map
   company-active-map
   ("M-p" . nil)
   ("M-n" . nil)
   ("C-p" . company-select-previous)
   ("C-n" . company-select-next)
   ("C-d" . company-show-doc-buffer)
   ("M-." . company-show-location))

  :hook
  (prog-mode . company-mode))


(use-package yasnippet
  :diminish yas-minor-mode

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
  :config
  (yas-reload-all))
