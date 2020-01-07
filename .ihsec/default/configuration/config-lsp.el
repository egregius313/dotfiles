;;; -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))

(use-package lsp-mode
  :straight (lsp-mode :type git :host github :repo "emacs-lsp/lsp-mode"
                      :branch "master")
  :commands lsp)

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode)

(use-package company-lsp
  :after lsp-mode
  :commands company-lsp)

(use-package helm-lsp
  :after lsp-mode
  :commands helm-lsp-workspace-symbol)

(use-package lsp-treemacs
  :after lsp-mode
  :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode
  :after lsp-mode)

(provide 'config-lsp)
