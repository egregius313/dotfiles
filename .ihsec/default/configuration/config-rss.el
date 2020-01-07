;;; -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))

(use-package elfeed)
(use-package elfeed-org
  :after (org elfeed)

  :custom
  (egregius313/feeds-directory (expand-file-name "~/Projects/feeds/"))
  (rmh-elfeed-org-files (directory-files egregius313/feeds-directory t ".org$"))

  :config
  (elfeed-org))

(provide 'config-rss)
