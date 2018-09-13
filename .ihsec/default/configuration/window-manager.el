(use-package exwm
  :ensure t
  :config
  
  ;; necessary to configure exwm manually
  (require 'exwm-config)

  ;; fringe size, most people prefer 1 
  (fringe-mode 3)
  
  ;; emacs as a daemon, use "emacsclient <filename>" to seamlessly edit files from the terminal directly in the exwm instance
  (server-start)
  
  ;; this fixes issues with ido mode, if you use helm, get rid of it
  (exwm-config-ido)
  
  ;; a number between 1 and 9, exwm creates workspaces dynamically so I like starting out with 1
  (setq exwm-workspace-number 1)
  
  ;; this is a way to declare truly global/always working keybindings
  ;; this is a nifty way to go back from char mode to line mode without using the mouse
  (exwm-input-set-key (kbd "s-r") #'exwm-reset)
  (exwm-input-set-key (kbd "s-k") #'exwm-workspace-delete)
  (exwm-input-set-key (kbd "s-w") #'exwm-workspace-swap)
  
  ;; the next loop will bind s-<number> to switch to the corresponding workspace
  (dotimes (i 10)
	(exwm-input-set-key (kbd (format "s-%d" i))
						`(lambda ()
						   (interactive)
						   (exwm-workspace-switch-create ,i))))
  
  ;; the simplest launcher, I keep it in only if dmenu eventually stopped working or something
  (exwm-input-set-key (kbd "s-&")
					  (lambda (command)
						(interactive (list (read-shell-command "$ ")))
						(start-process-shell-command command nil command)))

  ;; brightness keys
  ;; From github repo haikarainen/light
  (exwm-input-set-key (kbd "<XF86MonBrightnessDown>")
					  (lambda ()
						(interactive)
						(shell-command "light -U 5; light")))
  (exwm-input-set-key (kbd "<XF86MonBrightnessUp>")
					  (lambda ()
						(interactive)
						(shell-command "light -A 5; light")))
  
  ;; an easy way to make keybindings work *only* in line mode
  (push ?\C-q exwm-input-prefix-keys)
  (define-key exwm-mode-map [?\C-q] #'exwm-input-send-next-key)
  
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
  
  ;; this little bit will make sure that XF86 keys work in exwm buffers as well
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

  (require 'exwm-randr)

  ;; DP-1 being the name of the new monitor
  (setq exwm-randr-workspace-output-plist '(0 "DP-1"))

  ;; eDP-1 being the name of the original (laptop) monitor
  (add-hook 'exwm-randr-screen-change-hook
			(lambda ()
			  (start-process-shell-command
			   "xrandr" nil "xrandr --output DP-1 --left-of eDP-1 --auto")))

  
  ;; this just enables exwm, it started automatically once everything is ready
  (exwm-enable)
  (exwm-randr-enable))

(use-package dmenu
  :ensure t
  :bind
  ("s-SPC" . 'dmenu))


(defun exwm-async-run (name)
  (interactive)
  (start-process name nil name))

(defun daedreth/launch-discord ()
  (interactive)
  (exwm-async-run "discord"))

(defun daedreth/launch-browser ()
  (interactive)
  (exwm-async-run "qutebrowser"))

(defun daedreth/lock-screen ()
  (interactive)
  (exwm-async-run "slock"))

(defun daedreth/shutdown ()
  (interactive)
  (start-process "halt" nil "sudo" "halt"))


(global-set-key (kbd "s-d") 'daedreth/launch-discord)
(global-set-key (kbd "<s-tab>") 'daedreth/launch-browser)
(global-set-key (kbd "<XF86ScreenSaver>") 'daedreth/lock-screen)
(global-set-key (kbd "<XF86PowerOff>") 'daedreth/shutdown)

(defconst volumeModifier "4")


(defun audio/mute ()
  (interactive)
  (start-process "audio-mute" nil "pulsemixer" "--toggle-mute"))

(defun audio/raise-volume ()
  (interactive)
  (start-process "raise-volume" nil "pulsemixer" "--change-volume" (concat "+" volumeModifier)))

(defun audio/lower-volume ()
  (interactive)
  (start-process "lower-volume" nil "pulsemixer" "--change-volume" (concat "-" volumeModifier)))


(global-set-key (kbd "<XF86AudioMute>") 'audio/mute)
(global-set-key (kbd "<XF86AudioRaiseVolume>") 'audio/raise-volume)
(global-set-key (kbd "<XF86AudioLowerVolume>") 'audio/lower-volume)


(setq browse-url-browser-function 'browse-url-generic
	  browse-url-generic-program "firefox")
