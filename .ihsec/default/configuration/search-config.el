(use-package flx)


(use-package ivy
  :diminish ivy-mode

  :after (flx)

  :config
  (progn
	(defun my/strict-completion ()
	  (interactive)
	  (setq-local ivy-re-builders-alist '((t . ivy--regex-plus))))
;;	(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
	)

  :hook
  ((package-menu-mode . my/strict-completion)))


(use-package counsel
  :bind
  (("C-c k" . counsel-ag)
   ("s-I" . counsel-imenu)))


(use-package swiper
  :requires (counsel ivy)

  :custom
  (ivy-use-virtual-buffers t)
  (enable-recursive-minibuffers t)

  :config
  (ivy-mode 1)

  :bind
  (("C-s" . swiper)
   ("C-r" . swiper)
   ("C-x C-f" . counsel-find-file)

   ("M-x" . counsel-M-x)
   ("C-c C-r" . ivy-resume)
   ("C-c g" . counsel-git)
   ("C-c j" . counsel-git-grep)
   ("C-c k" . counsel-ag)
   ;; ("C-x l" . counsel-locate)
   ;; ("C-S-o" . counsel-rhythm)
   ;; :map
   ;; minibuffer-local-map
   ;; ("C-r" . counsel-minibuffer-history)

   :map
   swiper-map
   ("C-j" . swiper-avy)
   ("C-s" . next-line)
   ("C-r" . previous-line)
   ("M-c" . swiper-mc)
   ("M-r" . swiper-query-replace)))


(use-package ivy-explorer
  :after objed

  :diminish ivy-explorer
  
  :config
  (ivy-explorer-mode 1))

