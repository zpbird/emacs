;;-------------
;;---lsp---
;;------------- 


;; lsp-mode
;;----------------------------------------------------------------------------
;; (use-package lsp-mode
;;   :ensure t
;;   :commands (lsp lsp-deferred)
;;   :hook (go-mode . lsp-deferred)
;;   :config
;;   (lsp-register-custom-settings
;;    '(("gopls.completeUnimported" t t)
;;      ("gopls.staticcheck" t t)))
;;   (setq lsp-prefer-flymake nil)
;;   )


(use-package lsp-mode
  :ensure t
  :commands (lsp)
  :hook (go-mode . lsp)
  :config
  (lsp-register-custom-settings
   '(("gopls.completeUnimported" t t)
     ("gopls.staticcheck" t t)))
  (setq lsp-prefer-flymake nil)
  )




;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)


;; Optional - provides fancier overlays.
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; company-lsp integrates company mode completion with lsp-mode.
;; completion-at-point also works out of the box but doesn't support snippets.
(use-package company-lsp
  :ensure t
  :commands company-lsp)






















;; End-----------------
(provide 'init-lsp)
