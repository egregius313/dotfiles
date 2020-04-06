;;; Superfluous Sidebars -- Remove unnecessary side/menu/tool bars -*- lexical-binding: t -*-
;; Unnecessary side/menu/tool bars get in the way of text. Let's fix
;; that.

(use-package scroll-bar
  :straight nil
  :custom
  (scroll-bar-mode nil))

(use-package tool-bar
  :straight nil
  :custom
  (tool-bar-mode nil))

(use-package menu-bar
  :straight nil
  :custom
  (menu-bar-mode nil))

(provide 'config-display/sidebars)
