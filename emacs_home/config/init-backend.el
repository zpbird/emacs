;;------------------
;;--- web后端相关 ---
;;------------------


;; go-mode
;;-------------------------------------
(use-package go-mode
  :defer t
  :init
  (progn
    ;; (add-hook 'go-mode-hook 'yas-minor-mode)

    (add-hook 'go-mode-hook 'company-mode)(add-hook 'go-mode-hook (lambda ()  (set (make-local-variable 'company-backends) '(company-lsp company-go))
                                                                    (company-mode)))

    (add-hook 'go-mode-hook
              (lambda ()
                (setq tab-width 4)))
    ;; (add-hook 'go-mode-hook #'gorepl-mode)
    ))

;; company-go
;;-------------------------------------
(use-package company-go
  :config
  (setq company-begin-commands '(self-insert-command))
  
    )


;; nox
;;-------------------------------------

;; (add-to-list 'load-path "~/config/manual/nox/")
;; (require 'nox)
;; (dolist (hook (list
;;                ;; 'js-mode-hook
;;                ;; 'rust-mode-hook
;;                ;; 'python-mode-hook
;;                ;; 'ruby-mode-hook
;;                ;; 'java-mode-hook
;;                ;; 'sh-mode-hook
;;                ;; 'php-mode-hook
;;                ;; 'c-mode-common-hook
;;                ;; 'c-mode-hook
;;                ;; 'c++-mode-hook
;;                'go-mode-hook
;;                ))
;;   (add-hook hook '(lambda () (nox-ensure))))
;; (require 'posframe)



;; eglot
;;-------------------------------------
;; (add-hook 'go-mode-hook 'eglot-ensure)




;; jedi
;;-------------------------------------
(use-package jedi
  :defer t

  :init
  (progn
    (setq jedi:setup-keys t) ;;注意这句的位置要靠前
    (add-hook 'python-mode-hook 'jedi:setup)
    (setq jedi:complete-on-dot t)   ;; optional
    )
  
    )



;; elpy
;;-------------------------------------
(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  :config
  ;; use flycheck not flymake with elpy
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))
  (setq elpy-rpc-backend "jedi")
  (setq elpy-rpc-virtualenv-path "/home/zp/.pyenv/shims/")


  ;; (defun company-yasnippet-or-completion ()
  ;;   "Solve company yasnippet conflicts."
  ;;   (interactive)
  ;;   (let ((yas-fallback-behavior
  ;;          (apply 'company-complete-common nil)))
  ;;     (yas-expand)))

  ;; (add-hook 'company-mode-hook
  ;;           (lambda ()
  ;;             (substitute-key-definition
  ;;              'company-complete-common
  ;;              'company-yasnippet-or-completion
  ;;              company-active-map)))

  
  )





;; pylint
;;-------------------------------------
(use-package pylint
  :defer t

  :init
  ;; (progn
  ;;   (setq flycheck-pylintrc "/store/zpbird/note/python/pylint/pylint.conf")
  ;;   (setq flycheck-python-pylint-executable "/home/zp/.pyenv/shims/pylint")
  ;;   )

  (if (string= system-type "windows-nt")
      (progn
        ;; (message "I am windows_system")
        (setq flycheck-pylintrc "D:\\zpbird\\note\\python\\pylint\\pylint.conf")
        (setq flycheck-python-pylint-executable "C:\\Users\\zp\\.pyenv\\pyenv-win\\versions\\3.7.6-amd64\\Scripts\\pylint")  
        )

    (progn
      ;; (message "I am linux")
      (setq flycheck-pylintrc "/store/zpbird/note/python/pylint/pylint.conf")
      (setq flycheck-python-pylint-executable "/home/zp/.pyenv/shims/pylint")        
      )
    )

  
  :config
  (add-hook 'python-mode-hook 'pylint-add-menu-items)
  (add-hook 'python-mode-hook 'pylint-add-key-bindings)
  )








;;End===================
(provide 'init-backend)
