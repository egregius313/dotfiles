;;; -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))

(use-package erlang)

(setq lsp-erlang-server-path
	  (expand-file-name "lang-servers/erlang_ls/_build/default/bin/erlang_ls"
						user-emacs-directory))

(provide 'config-lang/erlang)
