;;; Use Stack Exchange from Emacs
(use-package sx
  :straight t

  :config
  (define-prefix-command 'egregius313/sx-map)
  
  :bind
  (("s-x" . egregius313/sx-map)
   :map egregius313/sx-map
   ("q" . sx-tab-all-questions)
   ("i" . sx-inbox)
   ("o" . sx-open-link)
   ("u" . sx-tab-unanswered-my-tags)
   ("a" . sx-ask)
   ("s" . sx-search)))
