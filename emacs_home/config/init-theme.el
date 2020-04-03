;;-------------------------------------------------------
;;--- init-theme.el 测试---
;;-------------------------------------------------------

;; spacemacs-theme
;;----------------------------------------------------------------
(use-package spacemacs-theme
  ;; :ensure t
  :defer t
  :init
  ;; 直接加载方式
  ;; (load-theme 'spacemacs-dark t)

  ;; spacemacs-theme自定义设置
  (defun zp-spacemacs-theme ()
    (if (equal custom-enabled-themes '(spacemacs-dark))
        ;; dark setting
        (progn
          ;; mode-line
          (set-face-attribute 'mode-line nil
                              :box nil
                              :background "gray10"
                              )
          (set-face-attribute 'mode-line-inactive nil
                              :box nil
                              :foreground "gray50"
                              )
          ;; counsel
          (set-face-attribute 'ivy-current-match nil
                              :inherit 'bold
                              :background "purple4"
                              )
          )
      ;; light setting
      (if (equal custom-enabled-themes '(spacemacs-light))
          (progn
            ;; mode-line
            ;;-------------------------------------------
            ;; (set-face-attribute 'mode-line nil
            ;;                     :box nil
            ;;                     ;; :background "gray10"
            ;;                     :background "red"
            ;;                     )
            ;; (set-face-attribute 'mode-line-inactive nil
            ;;                     :box nil
            ;;                     :foreground "gray50"
            ;;                     )
            ))))
  :config)


;; subatomic256-theme
(use-package subatomic256-theme
  :defer t
  
  )




;;End===============
(provide 'init-theme)
