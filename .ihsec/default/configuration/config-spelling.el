;;; -*- lexical-binding: t -*-

(require 'ispell)

(use-package flyspell
  :straight nil
  :when (executable-find ispell-program-name)
  
  :hook
  (prog-mode . flyspell-prog-mode)
  ((text-mode org-mode) . flyspell-mode))

(provide 'config-spelling)
