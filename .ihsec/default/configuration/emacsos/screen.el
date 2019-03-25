;; -*- mode: emacs-lisp -*-
;;; emacsos/screen.el  --- Screen management for EmacsOS

;; Copyright (C) 2019  Edward Minnix III

;; Author: Edward Minnix III
;; Version: 0.0.1
;; Keywords: emacsos

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Screen management and locking.

(defcustom emacsos/screen-locker "slock"
  "The program to execute to lock the screen.")


;;;###autoload
(defun emacsos/screen-lock nil
  "Lock the screen. Uses emacos/screen-locker to lock the screen."
  (interactive)
  (start-process "lock-screen" nil emacsos/screen-locker))


(defvar emacsos/screen--idle-timer nil
  "Timer returned by emacsos/screen-enable-idle-lock")


(defcustom emacsos/screen-lock-after-minutes 15
  "Amount of time to lock the screen after time idle.")


;;;###autoload
(defun emacsos/screen-enable-idle-lock ()
  "Lock the screen after a certain amount of time idle"
  (interactive)
  (let ((period (* emacsos/screen-lock-after-minutes 60)))
	(prog1 (setq emacsos/screen--idle-timer
				 (run-with-idle-timer period nil #'emacsos/screen-lock))
	  (message "Screen locking enabled."))))


;;;###autoload
(defun emacsos/screen-disable-idle-lock ()
  "Disable the idle timer for locking the screen"
  (interactive)
  (when emacsos/screen--idle-timer
	(prog1 (cancel-timer emacsos/screen--idle-timer)
	  (setq emacsos/screen--idle-timer nil)
	  (message "Screen locking disabled."))))


;; Brightness controls
;; From github repo haikarainen/light
(defun emacsos/screen-brightness-down ()
  "Lower the brightness of the screen."
  (interactive)
  (shell-command "light -U 5; light"))


(defun emacsos/screen-brightness-up ()
  "Raise the brightness of the screen."
  (interactive)
  (shell-command "light -A 5; light"))



(provide 'emacsos/screen)
