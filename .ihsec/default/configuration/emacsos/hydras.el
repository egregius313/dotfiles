(defhydra emacsos/customize-hydra ()
  "Customization"  
  ("a" (call-interactively #'customize-apropos) "apropos")
  ("f" (call-interactively #'customize-face) "face")
  ("v" (call-interactively #'customize-variable) "variable"))
