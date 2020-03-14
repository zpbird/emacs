;;------------------
;;--- web后端相关 ---
;;------------------

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
  )





;; pylint
;;-------------------------------------
(use-package pylint
  :defer t

  :init
  (progn
    (setq flycheck-pylintrc "/store/zpbird/note/python/pylint/pylint.conf")
    (setq flycheck-python-pylint-executable "/home/zp/.pyenv/shims/pylint")

    )
  
  :config
  (add-hook 'python-mode-hook 'pylint-add-menu-items)
  (add-hook 'python-mode-hook 'pylint-add-key-bindings)
  )








;;End===================
(provide 'init-backend)
