(use-package avy
  :ensure t

  :config
  (avy-setup-default)

  :bind
  (("C-:" . avy-goto-char)
   ("C-'" . avy-goto-char-2)
   ("M-g f" . avy-goto-line)
   ("M-g w" . avy-goto-word-1)
   ("M-g e" . avy-goto-word-0))

  :chords
  (("gc" . avy-goto-char)
   ("gw" . avy-goto-word-1)))


(use-package ace-window
  :ensure t

  :bind
  (("s-w" . ace-window)
   :map ctl-x-map
   ("S-O" . ace-window)))


(use-package lispy
  :ensure t

  :hook
  ((emacs-lisp-mode clojure-mode lisp-mode) . lispy-mode))


