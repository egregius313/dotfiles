;;; config-keys.el --- Configure core keybindings -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(use-package which-key
  :config
  (which-key-mode 1))

(use-package key-chord
  :custom
  (key-chord-two-keys-delay 0.2)

  :bind
  (([key-chord ?x ?o] . other-window)
   ([key-chord ?x ?b] . ido-switch-buffer)
   :map minibuffer-local-map
   ([key-chord ?g ?g] . minibuffer-keyboard-quit))

  :config
  (key-chord-mode 1))

(use-package use-package-chords)

(provide 'config-keys)
