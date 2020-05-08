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




;; lsp-mode GOOD
;;----------------------------------------------------------------------------

;; (use-package lsp-mode
;;   :ensure t
;;   :commands (lsp)
;;   :hook (go-mode . lsp)
;;   :config
;;   (lsp-register-custom-settings
;;    '(("gopls.completeUnimported" t t)
;;      ("gopls.staticcheck" t t)))
;;   (setq lsp-prefer-flymake nil)
;;   ;; (setq lsp-enable-symbol-highlighting nil)
;;   )


;; lsp-mode 3
;;----------------------------------------------------------------------------

(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook (go-mode . lsp)
  :config
  (setq lsp-prefer-flymake nil)
  (setq lsp-signature-auto-activate nil)

  (setq lsp-flycheck-live-reporting nil)

  (lsp-register-custom-settings
   '(("gopls.completeUnimported" t t)
     ("gopls.staticcheck" t t)))
)




  ;;-------------------------------------------------------------------------------------
  ;; (setq flycheck-check-syntax-automatically '(save mode-enabled)) ;;打开和保存时进行检查

  ;; (setq gc-cons-threshold 100000000)
  ;; (setq read-process-output-max (* 1024 1024)) ;; 1mb
  ;; (setq lsp-prefer-capf t)
  ;; (setq lsp-idle-delay 0.500)
  ;; (setq lsp-print-performance t)
  

  ;; (lsp-register-custom-settings
  ;;  '(("gopls.completeUnimported" t t)
  ;;    ("gopls.staticcheck" t t)))
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;;-------------------------------------------------------------------------------------

  









;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)


;; Optional - provides fancier overlays.
(use-package lsp-ui
  :commands lsp-ui-mode)

;; company-lsp integrates company mode completion with lsp-mode.
;; completion-at-point also works out of the box but doesn't support snippets.
(use-package company-lsp
  :ensure t
  :commands company-lsp
  )
























;; End-----------------
(provide 'init-lsp)
