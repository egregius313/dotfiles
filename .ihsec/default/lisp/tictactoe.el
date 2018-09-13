;;; tictactoe.el -- Play tictactoe interactively in Emacs


(defun tictactoe ()
  "Begin a game of tictactoe"
  (interactive)

  (switch-to-buffer "*tictactoe*")
  (tictactoe-mode)
  (tictactoe-init))


(define-derived-mode tictactoe-mode special-mode
  "tictactoe")


(defconst *tictactoe-size* 3
  "Size for length/width of tictactoe board")

(defun tictactoe-init-board ()
  "Initial board for tictactoe."
  (make-vector (* *tictactoe-size*
				  *tictactoe-size*)
			   ?\.))

(defvar *tictactoe-board* (tictactoe-init-board)
  "The board for tictactoe.")


(defun tictactoe-init ()
  "Initialize the tictactoe board"
  (interactive)
  (print-tictactoe-board))


(defun print-tictactoe-board ()
  "Display the board in the buffer"
  (let ((inhibit-read-only t))
	(erase-buffer)
	(dotimes (row *tictactoe-size*)
	  (dotimes (col *tictactoe-size*)
		(insert "")
		)
	  (newline)
	  )
	))

(defun tictactoe-mark ()
  "Mark the cell on the board")
