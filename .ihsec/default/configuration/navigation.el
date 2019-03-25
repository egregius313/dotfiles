(use-package avy
  :straight t

  :custom
  (avy-keys-alist `((avy-goto-line . ,(number-sequence ?a ?z))))
  
  :config
  (avy-setup-default)

  (defmacro define-avy-goto-symbol (name key)
	(let ((fname (intern (concat "avy-goto-" (symbol-name name)))))
	  `(progn
		 (defun ,fname ()
		   (interactive)
		   (avy--generic-jump ,key nil))
		 (global-set-key ,(kbd (concat "M-g " key)) #',fname))))
  
  (define-avy-goto-symbol open-paren "(")
  (define-avy-goto-symbol close-paren ")")
  (define-avy-goto-symbol open-curly "{")
  (define-avy-goto-symbol close-curly "}")
  (define-avy-goto-symbol open-square "[")
  (define-avy-goto-symbol close-square "]")
  
  :bind
  (("C-:" . avy-goto-char)
   ("C-'" . avy-goto-char-2)
   ("M-g f" . avy-goto-line)
   ("M-g w" . avy-goto-word-1)
   ("M-g e" . avy-goto-word-0)

   ;; Similar to search (C-s)
   ("M-g M-s" . avy-goto-char-timer))

  :chords
  (("gc" . avy-goto-char)
   ("gw" . avy-goto-word-1)))


(use-package ace-window
  :straight t

  :bind
  (("s-w" . ace-window)
   :map ctl-x-map
   ("S-O" . ace-window)))


(use-package lispy
  :straight t

  :hook
  ((emacs-lisp-mode clojure-mode lisp-mode) . lispy-mode))


(use-package windmove
  :bind
  (("s-h" . windmove-left)
   ("s-j" . windmove-down)
   ("s-k" . windmove-up)
   ("s-l" . windmove-right)))


(eval-after-load 'hydra
  (progn
	(defhydra emacsos/ctl-x-o (:color red :hint nil)
	  ("o" (other-window 1) "C-x o")
	  ("q" nil "quit"))
	(defun other-window-and-hydra (&optional n)
	  (interactive "p")
	  (other-window (or n 1))
	  (emacsos/ctl-x-o/body))
	(define-key ctl-x-map "o" #'other-window-and-hydra)))

