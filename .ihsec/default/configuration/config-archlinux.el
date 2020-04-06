;;; config-archlinux.el --- Configuration for working on Arch Linux -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))

;; Support editing PKGBUILD files
(use-package pkgbuild-mode)

(provide 'config-archlinux)
