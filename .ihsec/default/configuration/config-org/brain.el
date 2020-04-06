;;; -*- lexical-binding: t -*-

(use-package org-brain
  :after org
  :straight t

  :commands (org-brain-visualize org-brain-goto)

  :config
  (add-to-list 'org-contacts-files "~/org/brain/" t))

(provide 'config-org/brain)
