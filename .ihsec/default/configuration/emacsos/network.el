(require 'cl-lib)
(require 'dbus)

(defmacro emacsos/defenum (prefix doc &rest body)
  `(progn
	 ,@(cl-loop for (name value doc) in body
				for enum-name = (intern (concat (symbol-name prefix)
												"/"
												(symbol-name name)))
				collect `(defconst ,enum-name ,value ,doc))
	 (defun ,(intern (concat (symbol-name prefix) "-describe-value"))
		 (value)
	   (case value
		 ,@(cl-loop for (name value _) in body
					collect `(,value ',name))))
	 
	 (defconst ,(intern (concat (symbol-name prefix) "/enum")) '(,@(mapcar #'car body))
	   ,(format "names of the %S enum values" prefix))))


(emacsos/defenum
 nm/state
 "Network manager state"
 (unknown 0 "Network state is unknown")
 (asleep 10 "Network is not enabled")
 (disconnected 20 "There is no active network connection")
 (disconnecting 30 "Network connections are being cleaned up")
 (connecting 40 "A network connection is being started")
 (connected-local 50 "There is only local IPv4 and/or IPv6 connection.")
 (connected-site 60 "There is only site-wide IPv4 and/or IPv6 connectivity.")
 (connected-global 70 "There is global IPv4 and/or IPv6 internet connectivity."))


(emacsos/defenum
 nm/connectivity-state
 ""
 (unknown 0 "Network connectivity is unknown.")
 (none    1 "The host is not connected to any network.")
 (portal  2 "The internet connection is hijacked by a captive portal gateway.")
 (limited 3 "The host is connected to a network, does not appear to be able to reach the full internet, but a captive portal has not been detected.")
 (full    4 "The host is connected to a network, and appears to be able to reach the full internet."))


(defmacro nm/call-method (&rest args)
  `(dbus-call-method
	:system "org.freedesktop.NetworkManager" "/org/freedesktop/NetworkManager"
	"org.freedesktop.NetworkManager" ,@args))


(defmacro nm-settings/call-method (&rest args)
  `(dbus-call-method
	:system "org.freedesktop.NetworkManager" "/org/freedesktop/NetworkManager/Settings"
	"org.freedesktop.NetworkManager.Settings" ,@args))


(defun nm/get-devices ()
  "Get list of realized network devices."
  (nm/call-method "GetDevices"))


(defun nm/get-all-devices ()
  "Get the list of all network devices."
  (nm/call-method "GetAllDevices"))


(defun nm/get-device-by-ip-interface (interface)
  "Return the object path of network device referenced by its IP interface name."
  (nm/call-method "GetDeviceByIpIface" interface))


(defun nm/activate-connection (connection device specific-object)
  "Adds a new connection using the given details"
  (nm-call-method "ActivateConnection" connection device specific-object))


(defun nm/disable ()
  "Disable all networking."
  (interactive)
  (nm/enable :disable))


(defun nm/enable (&optional enable)
  "Control whether overall networking is enabled or disabled."
  (interactive)
  (case enable
	((:enable t nil) (nm/call-method "Enable" t))
	(:disable (nm/call-method "Enable" nil))))


(defun nm/check-connectivity ()
  "Re-check the network connectivity state."
  (interactive)
  (nm/connectivity-state-describe-value (nm/call-method "CheckConnectivity")))


(defun nm/state ()
  (nm/state-describe-value (nm/call-method "state")))


(defun nm/list-connections ()
  "List the saved network connections known to NetworkManager"
  (nm-settings/call-method "ListConnections"))



