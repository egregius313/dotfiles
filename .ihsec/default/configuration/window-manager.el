;; -*- lexical-binding: t -*-

(eval-when-compile
  (require 'use-package))
(require 'bind-key)


(use-package exwm
  ;;  :quelpa (exwm :fetcher github :repo "ch11ng/exwm")
  :straight (:host github :repo "ch11ng/exwm")

  :config
  (require 'exwm-config)
  (require 'exwm-randr)
  (require 'exwm-systemtray)
  (require 'exwm-xim)
  
  ;; fringe size
  (fringe-mode 3)

  ;;  (server-start)

  ;; Uncomment if you want ido to work
  ;; (exwm-config-ido)

  (exwm-input-set-key (kbd "s-r") #'exwm-reset)
  (exwm-input-set-key (kbd "s-d") #'exwm-workspace-delete)
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

  ;; (load-configuration emacsos/screen)

  (use-package emacsos/screen
	:straight nil
	:load-path emacsos/load-path

	:config
	(exwm-input-set-key (kbd "<XF86MonBrightnessDown>") #'emacsos/screen-brightness-down)
	(exwm-input-set-key (kbd "<XF86MonBrightnessUp>") #'emacsos/screen-brightness-up))

  ;; simulation keys are keys that exwm will send to the exwm buffer upon inputting a key combination

  (defvar emacsos/common-bindings
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

	  ([?\M-<] . C-up)
	  ([?\M->] . C-down)

	  ;; cut/paste
	  ([?\C-w] . ?\C-x)
	  ([?\M-w] . ?\C-c)
	  ([?\C-y] . ?\C-v)
	  ([?\M-d] . C-delete)
	  ([M-backspace] . C-backspace)
	  
	  ;; search
	  ([?\C-s] . ?\C-f)
	  ([?\C-r] . ?\C-g)

	  ;; Undo
	  ([?\C-/] . ?\C-z)
	  ([?\M-\;] . ?\C-/)
	  ([?\s-e] . evil-mode)))

  (customize-set-variable 'exwm-input-simulation-keys
						  emacsos/common-bindings)
  
  ;; (exwm-input-set-simulation-keys
  ;;  emacsos/common-bindings)

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
			   XF86LaunchA
			   XF86LaunchB
			   Scroll_Lock
			   print
			   s-SPC
			   s-left
			   s-right))
    (cl-pushnew k exwm-input-prefix-keys))

  (defun egregius313/caps-menu nil
    "Reset the caps lock key to be <menu>"
    (interactive)
    (shell-command "setxkbmap -option caps:menu"))

  (defun egregius313/screen-change ()
	(interactive)
    (start-process-shell-command
     "xrandr" nil "xrandr --output HDMI1 --left-of eDP1 --auto"))

  (defun exwm-async-run (name)
    (interactive
     (list
      (read-string "program name: ")))
    (start-process name nil name))




  (defun egregius313/rename-exwm-window ()
    (interactive)
    (when exwm-class-name
      (let ((name (concat "*" exwm-class-name "*")))
		(rename-buffer name t))))
  
  ;;  (exwm-enable)
  ;;  (exwm-randr-enable)
  ;;  (exwm-init)

  (add-hook 'exwm-init-hook 'exwm-randr-enable)

  (add-hook 'exwm-init-hook #'egregius313/caps-menu)
  (add-hook 'exwm-manage-finish-hook #'egregius313/rename-exwm-window)
  
  ;; An easy way to make key bindings work only in line mode
  (push ?\C-q exwm-input-prefix-keys)
  (push ?\C-\\ exwm-input-prefix-keys)
  
  (exwm-randr-enable)
  ;; (exwm-xim-enable)

  (defun goto-previous-application-buffer ()
	"Goto the first previous buffer which is running an X application under EXWM."
	(interactive)
	(cl-loop with original-buffer = (current-buffer)
			 while (previous-buffer)
			 until (or (eq major-mode 'exwm-mode)
					   (eq original-buffer (current-buffer)))))


  (defun goto-next-application-buffer ()
	"Goto the first next buffer which is running an X application under EXWM."
	(interactive)
	(cl-loop with original-buffer = (current-buffer)
			 while (next-buffer)
			 until (or (eq major-mode 'exwm-mode)
					   (eq original-buffer (current-buffer)))))

  
  (push 's-XF86LaunchA exwm-input-prefix-keys)
  (global-set-key [s-XF86LaunchA] 'goto-previous-application-buffer)

  (push 's-XF86LaunchB exwm-input-prefix-keys)
  (global-set-key [s-XF86LaunchB] 'goto-next-application-buffer)

  
  :bind
  (;; ("s-l" . egregius313/lock-screen)
   ;;   ("<XF86ScreenSaver>" . egregius313/lock-screen)
   :map exwm-mode-map
   ("C-q" . exwm-input-send-next-key))
  
  :custom
  (exwm-workspace-number 1)
  ;; (exwm-randr-workspace-output-plist '(0 "eDP1"))
  (exwm-randr-workspace-monitor-plist '(0 "HDMI1" 1 "eDP1" 2 "HDMI1"))
  
  ;;  :hook
  ;;  ((exwm-init . (egregius313/caps-menu exwm-systemtray-enable))
  ;;   (exwm-randr-screen-change . egregius313/screen-change)
  ;;   (exwm-manage-finish . egregius313/rename-exwm-window))
  )


(use-package dmenu
  :bind
  ("s-SPC" . dmenu))


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


(defun emacsos/run-application (name &optional buffer-name)
  (interactive (list (read-string "Application: ")))
  (if (and buffer-name (get-buffer buffer-name))
	  (switch-to-buffer buffer-name)
	(exwm-async-run name)
	(egregius313/rename-exwm-window)))


(defhydra emacsos/applications (:color blue)
  ("f" (emacsos/run-application "firefox" "*Firefox*"))
  ("s" (emacsos/run-application "slack"))
  ("t" (emacsos/run-application "telegram-desktop" "*TelegramDesktop*")))


(global-set-key [s-a] #'emacsos/applications/body)
(global-set-key (kbd "s-a") #'emacsos/applications/body)


(use-package symon
  :hook
  (exwm-init . symon-mode))


(defun emacsos/mouseless ()
  "Starts an xmouseless process. Temporarily suspends Emacs'
ability to control the keyboard."
  (interactive)
  (start-process "xmouseless" nil "xmouseless"))


(when (executable-find "xmouseless")
  (global-set-key (kbd "s-m") #'emacsos/mouseless))
