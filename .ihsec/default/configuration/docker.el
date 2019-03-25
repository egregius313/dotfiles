;; -*- lexical-binding: t -*-

(eval-when-compile
  (require 'use-package))


(use-package docker
  :straight t)


(use-package docker-compose-mode
  :straight t)


(use-package docker-tramp
  :straight t)

(use-package dockerfile-mode
  :straight t)
