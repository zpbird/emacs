;;-------------
;;---company---
;;------------- 


;; company
;;----------------------------------------------------------------------------
(use-package company
  :ensure t
  ;; :hook (after-init . global-company-mode)
  :defer t
  :init
  (progn
    (global-company-mode 1)
    (setq company-minimum-prefix-length 1) ;;输入第一个字符开启补全
    (setq company-show-numbers t) ;;显示编号
    (define-key company-active-map (kbd "C-n") #'company-select-next) ;;选择键
    (define-key company-active-map (kbd "C-p") #'company-select-previous)
    (define-key company-active-map (kbd "<escape>") #'company-abort)
    (global-set-key (kbd "C-c c") 'company-complete)
    )
  :config
  (setq company-idle-delay 0.4)
  (setq company-global-modes '(not package-menu-mode org-mode fundamental-mode))
  )


;; company后端设置
;;------------------------------------------------------
;; 设置默认后端 `company-backends'
(setq company-backends
      `((
         company-files
         company-keywords
         company-capf
         company-dabbrev
         )))
;; javascript后端
(dolist (hook '(
                js-mode-hook
                js2-mode-hook
                js3-mode-hook
                ))
  (add-hook hook
            (lambda ()
              (tern-mode t)
              (setq-local company-backends
                          '((
                             company-files
                             company-keywords
                             company-capf
                             company-yasnippet
                             ;;company-tern
                             ;; company-dabbrev
                             ))
                          ))))

;; typescript后端
(dolist (hook '(
                typescript-mode-hook
                ))
  (add-hook hook
            (lambda ()
              (tern-mode t)
              (setq-local company-backends
                          '((
                             company-files
                             company-keywords
                             company-capf
                             company-yasnippet
                             ;; company-tern
                             company-tide
                             company-dabbrev
                             ))
                          ))))

;; css后端
(dolist (hook '(
                css-mode-hook
                ))
  (add-hook hook
            (lambda ()
              (setq-local company-backends
                          '((
                             company-files
                             company-capf
                             company-yasnippet
                             company-css
                             ;; company-dabbrev
                             ))
                          ))))
;; web-mode后端
(dolist (hook '(
                web-mode-hook
                ))
  (add-hook hook
            (lambda ()
              ;; (tern-mode t)
              (setq-local company-backends
                          '((
                             company-files
                             company-keywords
                             company-capf
                             company-web-html
                             company-css
                             ;;company-tern
                             company-tide
                             company-yasnippet
                             ;; company-dabbrev
                             ))
                          ))))





;; python
(dolist (hook '(
                python-mode-hook
                ))
  (add-hook hook
            (lambda ()
              (setq-local company-backends
                          '((
                             company-files
                             company-keywords
                             company-capf
                             company-yasnippet
                             ;; company-dabbrev
                             ))
                          ))))


;; go-mode
;; -------------------------------------------------------
(dolist (hook '(
                go-mode-hook
                ))
  (add-hook hook
            (lambda ()
              (setq-local company-backends
                          '((
                             company-files
                             company-keywords
                             company-capf
                             company-yasnippet
                             ;; company-dabbrev
                             ))
                          ))))


;;company-statistics排序
;;-------------------------------------------------------
(use-package company-statistics
  :defer t
  :init
  (progn
    (add-hook 'company-mode-hook 'company-statistics-mode)
    )
  )

;; company-tern 
;;--------------------------------------------------------
;;(use-package company-tern 
;;  :defer t
;;  :init
;;  )

;; company-web
;;----------------------------
(use-package company-web
  :defer t
  :init
  )

;; tern
;;--------------------------------------
(use-package tern 
  :defer t
  :init
  )

;; yasnippet
;;-----------------------------------------------------------------
(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode)
  :defer t
  :init
  (progn
    (global-set-key (kbd "C-c C-y") 'company-yasnippet)
    ;; (yas-global-mode 1) ;;全局使用
    ;; (add-hook 'prog-mode-hook #'yas-minor-mode) ;;指定局部使用的mode
    (setq yas-snippet-dirs
          '(
            "~/config/snippets"                 ;; personal snippets
            ;; yas-installed-snippets-dir
            ))





    
;; test----------------------------------------------
    (dolist (hook '(
                    css-mode-hook
                    js-mode-hook
                    js2-mode-hook
                    js3-mode-hook
                    web-mode-hook
                    typescript-mode-hook
                    svelte-mode-hook
                    ))
      (add-hook hook
                (lambda ()
                  (yas-minor-mode t)
                  (yas--load-snippet-dirs) ;; 加载snippet目录
                  'yas-minor-mode-hook
                  )))
    
;; test end------------------------------------------



    ))



















;; End-----------------
(provide 'init-company)
