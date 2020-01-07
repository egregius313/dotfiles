;;; -*- lexical-binding: t -*-

;;; Revert buffers
(use-package autorevert
  :straight nil
  :diminish auto-revert-mode)

;;; Cleanup autosaves
(use-package files
  :straight nil
  :custom
  (backup-by-copying t "don't clobber symlinks")
  (backup-directory-alist '(("." . "~/.saves/")) "don't litter my fs tree")
  (delete-old-versions t)
  (kept-new-versions 6)
  (kept-old-versions 2)
  (version-control t "use versioned backups"))

(provide 'config-backups)
