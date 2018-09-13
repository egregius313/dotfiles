(defvar csharp-repl-executable
  "csharp"
  "Executable name to run the C# repl")


(defun csharp-repl ()
  "Switch to C# repl buffer, creating it if it doesn't exist"
  (interactive)
  (let ((buf (get-buffer-create "*csharp*")))
	(split-window)
	(other-window 1)
	(comint-run csharp-repl-executable)))


(define-key csharp-mode-map
  (kbd "C-c C-z")
  'csharp-repl)

