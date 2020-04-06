;;; llvm.el --- LLVM IR and TableGen support -*- lexical-binding: t -*-

(defcustom llvm-repository-path
  (expand-file-name "~/gitdownloads/llvm/")
  "The path to a copy of the LLVM repository")

(add-to-list 'load-path
			 (expand-file-name "utils/emacs" llvm-repository-path))

(require 'llvm-mode)
(require 'tablegen-mode)

(provide 'config-lang/llvm)
