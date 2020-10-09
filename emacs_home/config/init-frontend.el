;;---------------
;;--- web前端 ---
;;---------------

;;emmet-mode 书写HTML工具
;;---------------------------------
(use-package emmet-mode
  :defer t
  :init
  (dolist (hook '(html-mode-hook
				  web-mode-hook
				  js2-mode-hook
				  css-mode-hook
				  ))
	(add-hook hook (lambda () (emmet-mode 1))))
  )

;; web-mode
;;----------------------------------------
(use-package web-mode
  :defer t
  :mode "\\.\\(phtml\\|php|[gj]sp\\|as[cp]x\\|erb\\|djhtml\\|html?\\|hbs\\|ejs\\|jade\\|swig\\|tmpl\\|vue\\)$"
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-style-padding 2)
  (setq web-mode-script-padding 2)
  ;; (setq web-mode-enable-css-colorization nil)
  ;; (setq web-mode-enable-css-colorization t)
  (setq web-mode-enable-current-element-highlight 1)

  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t)



  ;; (add-hook 'web-mode-hook
  ;;           (lambda ()
  ;;             (tide-setup)
  ;;             ))

  ;; (add-hook 'web-mode-hook
  ;;         (lambda ()
  ;;           (when (string-equal "vue" (file-name-extension buffer-file-name))
  ;;             (setup-tide-mode)
  ;;             )))
  
  (flycheck-add-mode 'typescript-tslint 'web-mode)  
  

  )




;; js2-mode
;; ---------------------------------

(use-package js2-mode
  :defer t
  :mode "\\.js$"
  :interpreter "node"
  :init
  (add-hook 'js2-mode-hook
            (lambda ()
              (setq js2-basic-offset 4)
              (setq js2-strict-trailing-comma-warning nil)
              (js2-imenu-extras-mode 1)))
  :config
  (use-package js2-refactor
    :defer t
    :diminish js2-refactor-mode
    :init (add-hook 'js2-mode-hook #'js2-refactor-mode)
    :config (js2r-add-keybindings-with-prefix "C-c C-m")))



;; json-mode
;;---------------------
(use-package json-mode
  :defer t
  :init
  )

;; CSS eldoc
;;-------------------------------------------------------
(use-package css-eldoc
  :commands turn-on-css-eldoc
  :init
  (dolist (hook '(css-mode-hook scss-mode-hook less-css-mode-hook web-mode-hook))
    (add-hook hook 'turn-on-css-eldoc)))

;; 如果启用css-eldoc使得isearch变慢启用如下代码
;; (defun isearch-forward-noeldoc ()
;;   "close eldoc temperaily"
;;   (interactive)
;;   (eldoc-mode -1)
;;   (isearch-forward)
;;   (eldoc-mode 1))
;; (add-hook 'less-css-mode-hook (lambda ()
;; 				(local-set-key [remap isearch-forward] 'isearch-forward-noeldoc)))

;; (defun isearch-backward-noeldoc ()
;;   "close eldoc temperaily"
;;   (interactive)
;;   (eldoc-mode -1)
;;   (isearch-backward)
;;   (eldoc-mode 1))
;; (add-hook 'less-css-mode-hook (lambda ()
;; 				(local-set-key [remap isearch-backward] 'isearch-backward-noeldoc)))
;;-------------------------------------------------------

;; javascript-eldoc
;; (use-package javascript-eldoc
;;   :commands turn-on-javascript-eldoc
;;   :init
;;     (progn
;; 	(add-to-list 'load-path  "~/config/eldoc/javascript-eldoc-master/")
;; 	(dolist (hook '(js-mode-hook js2-mode-hook))
;; 	  (add-hook hook 'turn-on-javascript-eldoc)))
;; 	)








;; tide
;;------------------------------------------------------------------------

(use-package tide
  :ensure t
  :after (web-mode typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)

         (web-mode . tide-setup)
         (web-mode . tide-hl-identifier-mode)

         ;; (before-save . tide-format-before-save)
         )
  :config


  )



;; node_path
;; -------------

;; (setenv "PATH" (concat "/home/zp/.nvm/versions/node/v12.16.0/bin/:" (getenv "PATH")))
;; (setq exec-path (append exec-path '("/home/zp/.nvm/versions/node/v12.16.0/bin/")))













;;End===================
(provide 'init-frontend)
