(defcustom emacsos/kb-variant nil
  "Variant for setxkbmap.")


(defun emacsos/kb--xmodmap-get-info ()
  "Run xmodmap and get the informatin for modifying the keyboard."
  nil)


(defun emacsos/kb-update ()
  "Update configuration of the keyboard."

  (when emacsos/kb-variant
	(start-process "set keyboard" nil "setxkbmap" "-variant" emacsos/kb-variant)))


(provide 'emacsos/kb)
