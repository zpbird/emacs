;;-------------------------------------------------------
;;--- init-others.el 其他---
;;-------------------------------------------------------

;; lua-mode
;;---------------------------
(use-package lua-mode
  :defer t
  :mode "\\.lua$"
  :config
  
  )

;; ssh
;;---------------------------


;; node_path
;; -------------

(setenv "PATH" (concat "/home/zp/.nvm/versions/node/v12.16.0/bin/:" (getenv "PATH")))
(setq exec-path (append exec-path '("/home/zp/.nvm/versions/node/v12.16.0/bin/")))




;;End===============
(provide 'init-others)
