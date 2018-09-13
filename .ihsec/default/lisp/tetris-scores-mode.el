(require 'tetris)


(define-derived-mode tetris-scores-mode special-mode
  "tetris-scores")


(defun tetris-scores-quit ()
  (interactive)
  (delete-window)
  (switch-to-buffer tetris-buffer-name))


(defun tetris-scores-start-game ()
  (interactive)
  (switch-to-buffer tetris-buffer-name)
  (tetris-start-game))


(define-key tetris-scores-mode-map "n" #'tetris-scores-start-game)
(define-key tetris-scores-mode-map "q" #'tetris-scores-quit)


;;;###autoload
(add-to-list 'auto-mode-alist
			 `(,tetris-score-file . tetris-scores-mode))

