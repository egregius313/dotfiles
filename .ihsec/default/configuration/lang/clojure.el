;; -*- lexical-binding: t -*-

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)


(use-package clojure-mode
  :requires (paredit)

  :hook
  ((clojure-mode . paredit-mode)))


(use-package cider
  :requires (company)

  :hook
  ((cider-mode . company-mode)
   (cider-repl-mode . company-mode)))
