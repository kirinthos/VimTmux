(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((eval set-formatter! 'shfmt "shfmt -ln bash -i 4" :modes
      '(sh-mode))
     (shfmt-arguments "-ln" "bash" "-i" "4")
     (lsp-json-schemas \`
      [(:fileMatch
        ["*/spec/examples/*.json"]
        :url "./data/schemas/src/spec/spec-schema.json")
       (:fileMatch
        ["*/workflow/examples/*.json"]
        :url "./data/schemas/src/workflow/workflow-schema.json")
       (:fileMatch
        ["*/integration/examples/*.json"]
        :url "./data/schemas/src/integration/integration-schema.json")])
     (lsp-rust-analyzer-exclude-dirs .
      [".cargo"])
     (eval if
      (boundp 'lsp-file-watch-ignored-directories)
      (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.cargo\\'")
      (setq lsp-file-watch-ignored-directories
            (list "[/\\\\]\\.cargo\\'"))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
