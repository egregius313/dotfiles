(eval-when-compile
  (require 'use-package))
(require 'bind-key)


(use-package exwm
  :straight t
  
  :config
  (require 'exwm-config)
  (require 'exwm-randr)
  (require 'exwm-systemtray)
  
  ;; fringe size
  (fringe-mode 3)

  (server-start)

  ;; Uncomment if you want ido to work
  ;; (exwm-config-ido)

  (exwm-input-set-key (kbd "s-r") #'exwm-reset)
  (exwm-input-set-key (kbd "s-k") #'exwm-workspace-delete)
  (exwm-input-set-key (kbd "s-w") #'exwm-workspace-swap)

  (dotimes (i 10)
    (exwm-input-set-key (kbd (format "s-%d" i))
						`(lambda ()
						   (interactive)
						   (exwm-workspace-switch-create ,i))))

  (exwm-input-set-key (kbd "s-&")
					  (lambda (command)
						(interactive (list (read-shell-command "$ ")))
						(start-process-shell-command command nil command)))

  (load-configuration emacsos/screen)
  (exwm-input-set-key (kbd "<XF86MonBrightnessDown>") #'emacsos/screen-brightness-down)
  (exwm-input-set-key (kbd "<XF86MonBrightnessUp>") #'emacsos/screen-brightness-up)

  ;; simulation keys are keys that exwm will send to the exwm buffer upon inputting a key combination
  (exwm-input-set-simulation-keys
   '(
     ([?1] . ?1)
     ([?2] . ?2)
     ([?3] . ?3)
     ([?4] . ?4)
     ([?5] . ?5)
     ([?6] . ?6)
     ([?7] . ?7)
     ([?8] . ?8)
     ([?9] . ?9)
     ([?0] . ?0)
     ;; movement
     ([?\C-b] . left)
     ([?\M-b] . C-left)
     ([?\C-f] . right)
     ([?\M-f] . C-right)
     ([?\C-p] . up)
     ([?\C-n] . down)
     ([?\C-a] . home)
     ([?\C-e] . end)
     ([?\M-v] . prior)
     ([?\C-v] . next)
     ([?\C-d] . delete)
     ([?\C-k] . (S-end delete))
     ;; cut/paste
     ([?\C-w] . ?\C-x)
     ([?\M-w] . ?\C-c)
     ([?\C-y] . ?\C-v)
     ;; search
     ([?\C-s] . ?\C-f)
     
     ([?\s-e] . evil-mode)))

  (dolist (k '(XF86AudioLowerVolume
			   XF86AudioRaiseVolume
			   XF86PowerOff
			   XF86AudioMute
			   XF86AudioPlay
			   XF86AudioStop
			   XF86AudioPrev
			   XF86AudioNext
			   XF86ScreenSaver
			   XF68Back
			   XF86Forward
			   Scroll_Lock
			   print))
    (cl-pushnew k exwm-input-prefix-keys))
  
  (defun egregius313/caps-menu nil
    "Reset the caps lock key to be <menu>"
    (interactive)
    (shell-command "setxkbmap -option caps:menu"))

  (defun egregius313/screen-change ()
    (start-process-shell-command
     "xrandr" nil "xrandr --output DP-1 --left-of eDP-1 --auto"))

  (defun exwm-async-run (name)
    (interactive
     (list
      (read-string "program name: ")))
    (start-process name nil name))

  (exwm-enable)
  (exwm-randr-enable)
  (exwm-init)
  
  ;; An easy way to make key bindings work only in line mode
  (push ?\C-q exwm-input-prefix-keys)

  :bind
  (;; ("s-l" . egregius313/lock-screen)
   ("<XF86ScreenSaver>" . egregius313/lock-screen)
   :map exwm-mode-map
   ("C-q" . exwm-input-send-next-key))
  
  :custom
  (exwm-workspace-number 1)
  (exwm-randr-workspace-output-plist '(0 "DP-1"))
  
  :hook
  (exwm-init . egregius313/caps-menu)
  (exwm-init . exwm-systemtray-enable)
  (exwm-randr-screen-change . egregius313/screen-change))


(use-package dmenu
  :straight t
  :bind
  ("s-SPC" . 'dmenu))


(defun daedreth/launch-browser ()
  (interactive)
  (exwm-async-run "qutebrowser"))


(defun daedreth/shutdown ()
  (interactive)
  (start-process "halt" nil "sudo" "halt"))


;; (global-set-key (kbd "<s-tab>") 'daedreth/launch-browser)
;; (global-set-key (kbd "<XF86PowerOff>") 'daedreth/shutdown)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")

 
(use-package symon
  :straight t

  :hook
  (exwm-init . symon-mode))
