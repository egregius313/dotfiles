(require 'package)

(package-initialize)
(custom-set-variables
 '(package-archives
   (quote
	(("gnu" . "http://elpa.gnu.org/packages/")
	 ("melpa-stable" . "http://stable.melpa.org/packages/")
	 ("melpa" . "http://melpa.org/packages/")))))  
(package-refresh-contents)


(unless (package-installed-p 'use-package)
  (package-install 'use-package))


;; Used by use-package for the :diminish keyword to work
(use-package diminish
  :ensure t)


(use-package use-package-chords
  :ensure t

  :config
  (key-chord-mode 1))

