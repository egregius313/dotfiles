;;; -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))

(use-package yasnippet
  :config
  (add-to-list 'yas-snippet-dirs (expand-file-name "snippets" user-emacs-directory))

  :hook
  ((prog-mode . yas-minor-mode)
   (org-mode . yas-minor-mode)
   (eshell-mode . yas-minor-mode)))

(use-package yasnippet-snippets
  :after yasnippet
  :config
  (yas-reload-all))

(provide 'config-snippets)
