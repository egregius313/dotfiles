(use-package pulseaudio-control
  :config
  
  
  :bind
  (("<XF86AudioLowerVolume>" . pulseaudio-control-decrease-volume)
   ("<XF86AudioRaiseVolume>" . pulseaudio-control-increase-volume)))

(defconst volume-modifier 4)
(defconst audio/mixer-executable "pulsemixer")

(defun audio/mute ()
  (interactive)
  (start-process "audio-mute" nil audio/mixer-executable "--toggle-mute"))


(defun audio/raise-volume (&optional mult)
  (interactive "P")
  (let* ((mult (or mult 1))
		 (volume (* mult volume-modifier))
		 (vol-string (concat "+" (int-to-string volume))))
	(start-process "raise-volume" nil audio/mixer-executable
				   "--change-volume" vol-string)))
 
(defun audio/lower-volume (&optional mult)
  (interactive "P")
    (let* ((mult (or mult 1))
		   (volume (* mult volume-modifier))
		   (vol-string (concat "-" (int-to-string volume))))
	(start-process "lower-volume" nil audio/mixer-executable
				   "--change-volume" vol-string)))

(defconst volume-quarter-modifier 1)

(defun audio/quarter-raise-volume ()
  (interactive)
  (let ((mod (concat "+" (number-to-string volume-quarter-modifier))))
	(start-process "quarter-raise" nil audio/mixer-executable "--change-volume" mod)))

(defun audio/quarter-lower-volume ()
  (interactive)
  (let ((mod (concat "-" (number-to-string volume-quarter-modifier))))
	(start-process "quarter-raise" nil audio/mixer-executable "--change-volume" mod)))

(global-set-key (kbd "C-<XF86AudioLowerVolume>") #'audio/quarter-lower-volume)
(global-set-key (kbd "C-<XF86AudioRaiseVolume>") #'audio/quarter-raise-volume)


(global-set-key (kbd "<XF86AudioMute>") 'audio/mute)
;; (global-set-key (kbd "<XF86AudioRaiseVolume>") 'audio/raise-volume)
;; (global-set-key (kbd "<XF86AudioLowerVolume>") 'audio/lower-volume)

