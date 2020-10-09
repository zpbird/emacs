;;------------------
;;---flycheck相关---
;;------------------


;; flycheck
;;--------------------------------------
(use-package flycheck
  :ensure t
  :init
  (progn
    (global-flycheck-mode 1)
    (flycheck-add-mode 'javascript-eslint 'javascript-mode)
    (flycheck-add-mode 'javascript-eslint 'js2-mode)
    (setq flycheck-global-modes '(not org-mode emacs-lisp-mode text-mode css-mode))
    ))


;; End------------------
(provide 'init-flycheck)
