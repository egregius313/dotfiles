;;; config-docker.el --- Work with Docker -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))

(use-package docker
  :when (executable-find "docker")
  :defer t)

(use-package docker-compose-mode
  :after docker)

(use-package docker-tramp
  :after docker)

(use-package dockerfile-mode
  :after docker)

(provide 'config-docker)
