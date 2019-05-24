(defhydra emacsos/customize-hydra ()
  "Customization"  
  ("a" (call-interactively #'customize-apropos) "apropos")
  ("f" (call-interactively #'customize-face) "face")
  ("v" (call-interactively #'customize-variable) "variable"))


(load-configuration emacsos/network)

(defhydra network-hydra (:exit t)
  ("i" (ifconfig) "ifconfig")
  ("p" (call-interactively #'ping) "ping")
  ("P" (ping "8.8.8.8") "ping 8.8.8.8")
  ("<up>" (prog1 (nm/enable)
			(message "%s" "Enabled")) "enable")
  ("<down>" (prog1 (nm/disable)
			  (message "%s" "Disabled")) "disable"))
