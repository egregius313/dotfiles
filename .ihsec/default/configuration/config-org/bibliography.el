;;; -*- lexical-binding: t -*-

(setq my/org-bibliography-directory (expand-file-name "~/org/bibliography"))

(use-package org-ref
  :defer t
  
  :custom
  (reftex-default-bibliography (list (expand-file-name "references.bib" my/org-bibliography-directory)))
  (org-ref-bibliography-notes (expand-file-name "notes.org" my/org-bibliography-directory))
  (org-ref-default-bibliography (list (expand-file-name "references.bib" my/org-bibliography-directory)))
  (org-ref-pdf-directory (expand-file-name "bibtex-pdfs/" my/org-bibliography-directory))
  
  :config
  (setq org-latex-pdf-process
        '("pdflatex -interaction nonstopmode -output-directory %o %f"
          "biber %b"
          "pdflatex -interaction nonstopmode -output-directory %o %f"
          "pdflatex -interaction nonstopmode -output-directory %o %f")))

(provide 'config-org/bibliography)
