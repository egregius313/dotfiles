(eval-when-compile
  (require 'use-package))

(use-package avy
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
  :bind
  (("s-w" . ace-window)
   :map ctl-x-map
   ("S-O" . ace-window)))


(use-package lispy
  :hook
  ((emacs-lisp-mode clojure-mode lisp-mode) . lispy-mode))


(use-package windmove
  :bind
  (("s-h" . windmove-left)
   ("s-j" . windmove-down)
   ("s-k" . windmove-up)
   ("s-l" . windmove-right)))


(defhydra emacsos/ctl-x-o (:pre (other-window 1) :timeout 1.0 :hint nil)
  ("o" (other-window 1) "C-x o" :color red)
  ("b" (call-interactively (key-binding (kbd "C-x b"))) "C-x b" :color blue)
  ("f" (call-interactively (key-binding (kbd "C-x C-f"))) "C-x C-f" :color blue)
  ("0" (call-interactively (key-binding (kbd "C-x 0"))) "C-x 0" :color red)
  ("1" (call-interactively (key-binding (kbd "C-x 1"))) "C-x 1" :color red)
  ("C-g" nil "quit"))

(define-key ctl-x-map "o" #'emacsos/ctl-x-o/body)

	

