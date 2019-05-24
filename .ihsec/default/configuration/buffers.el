(use-package transpose-frame
  :after hydra
  
  :config
  ;; Window management
  (defhydra windows-hydra ()
	"
^Window Management^      ^Flip^               ^Rotate^              ^Sizing^
^^^^^^^^^^^^^^^^^^^---------------------------------------------------------------------------------
_k_: Kill window         _v_: Vertically      _r_: Clockwise        _<left>_:  Shrink horizontally
_o_: ace-window          _h_: Horizontally    _R_: Anticlockwise    _<right>_: Grow horizontally
_|_: split-window-right                                             _<down>_:  Shrink vertically
_-_: split-window-below                                             _<up>_:    Grow vertically
"
	("k" (delete-window) :color blue)
    ("v" (flip-frame))
    ("h" (flop-frame))
    ("r" (rotate-frame-clockwise))
    ("R" (rotate-frame-anticlockwise))
    ("<left>" (call-interactively #'shrink-window-horizontally))
    ("<right>" (call-interactively #'enlarge-window-horizontally))
    ("<down>" (call-interactively #'shrink-window))
    ("<up>" (call-interactively #'enlarge-window))
	("o" (call-interactively #'ace-window) "Select window" :color blue)
	("|" (split-window-right))
	("-" (split-window-below))
    ("q" nil "Quit")))

