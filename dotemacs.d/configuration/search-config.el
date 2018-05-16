(use-package flx
  :ensure t)


(use-package ivy
  :ensure t
  :diminish ivy-mode

  :after (flx)

  :config
  ;;; (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))

  )


(use-package counsel
  :ensure t)


(use-package swiper
  :ensure t

  :requires (counsel ivy)
  
  :config
  (progn
	(ivy-mode 1)
	(setq ivy-use-virtual-buffers t)
	(setq enable-recursive-minibuffers t))

  :bind
  (("C-s" . swiper)
   ("C-x C-f" . counsel-find-file)
   ("M-x" . counsel-M-x)
   ("C-c C-r" . ivy-resume)
   ("C-c g" . counsel-git)
   ("C-c j" . counsel-git-grep)
   ("C-c k" . counsel-ag)
   ;; ("C-x l" . counsel-locate)
   ;; ("C-S-o" . counsel-rhythm)
   :map
   minibuffer-local-map
   ("C-r" . counsel-minibuffer-history)))

