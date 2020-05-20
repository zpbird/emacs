;;-----------------------------
;;--- init-ui.el 视觉层配置---
;;-----------------------------

;;Theme设置
;;-------------------------------------------
;; 老式直接加载指定主题
;; (load-theme 'spacemacs-dark t)

(if (display-graphic-p)
    ;;GUI主题
    (progn
      ;; 设置深浅theme
      (setq zp-theme-dark '(spacemacs-dark))
      (setq zp-theme-light '(spacemacs-light))

      ;; 设置默认当前主题
      (setq zp-current-theme zp-theme-dark)
      ;; (setq zp-current-theme zp-theme-light)

      ;; 加载当前主题
      (load-theme (car zp-current-theme) t)
      ;; 加载当前主题自定义设置
      (zp-theme-custom-setting)
      )
  ;;Terminal主题
  (progn
    (load-theme 'subatomic256 t)
    )
  )


;;beacon光标
;;--------------------------------------------------------
(use-package beacon
  :ensure nil
  :defer t
  :init
  (beacon-mode 1)
  (setq beacon-blink-delay 0.1)
  (setq beacon-blink-duration 0.1)
  (setq beacon-blink-when-buffer-changes nil)
  (setq beacon-blink-when-point-moves-horizontally nil)
  (setq beacon-blink-when-point-moves-vertically 0)
  (setq beacon-color 0.6)
  (setq beacon-dont-blink-commands (quote (forward-line)))
  (setq beacon-size 20)
  )

;;window-numbering 窗口编号
;;---------------------------
(use-package window-numbering
  :defer t
  :init
  (window-numbering-mode 1)
  )

;;rainbow-mode 颜色预览
;;------------------------------------------------
(use-package rainbow-mode
  :defer t
  :init
  (dolist (hook '(html-mode-hook
          css-mode-hook
          js2-mode-hook
          web-mode-hook
          ))
    (add-hook hook (lambda () (rainbow-mode 1)))
    )
  :config
  (add-to-list 'rainbow-html-colors-major-mode-list 'js2-mode)
  ;; (add-to-list 'rainbow-html-colors-major-mode-list 'web-mode)
  )

;;rainbow-delimiters
;;---------------------------------------------------
(use-package rainbow-delimiters
  :defer t
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )

;; Highlight symbols
;;------------------------------------------------------
(use-package symbol-overlay
  :defer t
  :diminish symbol-overlay-mode
  :bind (("M-i" . symbol-overlay-put)
         ("C-c n" . symbol-overlay-jump-next)
         ("C-c p" . symbol-overlay-jump-prev)
         ("C-c q" . symbol-overlay-remove-all))
  :init (add-hook 'prog-mode-hook 'symbol-overlay-mode)
  :config
  (set-face-attribute 'symbol-overlay-default-face nil :inherit 'unspecified)
  )

;;显示行号
;;-------------------
(add-hook 'package-menu-mode-hook 'linum-mode)

;;fill-column
;;---------------------------
(setq-default fill-column 80)


;;设置行号宽度
;;-----------------------
;; (setq linum-format "%d ")
(setq linum-format "%3s")

;;显示列号
;;-------------------------
(setq column-number-mode t)

;;去掉工具栏
;;-----------------
(tool-bar-mode -1)
;;去掉滚动条
;;-------------------
(scroll-bar-mode -1)

;;去掉菜单栏
;;-------------------
(menu-bar-mode -1)

;;在标题栏提示当前位置
;;-----------------------------------------------------------------------
;; (setq frame-title-format
;;       (list	"ZPBIRD --> "
;;    ;;	"[" '(:eval (projectile-project-name)) "]"
;;      '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))
;; Title
;;-----------------------------------------------------------------------
(setq frame-title-format
      '("GNU Emacs " emacs-version "@" user-login-name " : "
        (:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))
(setq icon-title-format frame-title-format)

;;启动时全屏
;;---------------------------------------------
(toggle-frame-maximized)
(global-set-key [f12] 'toggle-frame-fullscreen)

;; 设置mode-line中显示日期时间
;;---------------------------------------------
(display-time-mode tabulated-list--header-string)

;;时间使用24小时制
;;-------------------------------
(setq display-time-24hr-format t)

;;时间显示包括日期和具体时间
;;--------------------------------
(setq display-time-day-and-date t)

;;时间的变化频率
;;----------------------------
(setq display-time-interval 1)

;;显示时间，格式如下
;;--------------------------------
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

;; mode-line
;;-----------------------------------
;; (set-face-attribute 'mode-line nil
;;                     :box nil
;;                     :background "gray10"
;;                     )

;; (set-face-attribute 'mode-line-inactive nil
;;                     :box nil
;;                     :foreground "gray50"
;;                     )


;; region
;;------------------------------------
(set-face-attribute 'region nil
                    :inherit 'bold
                    :background "black"
                    :foreground "deep pink"
                    )




;; centaur-tabs
;;------------------------------------
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-style "wave")
  (setq centaur-tabs-height 18)
  ;; (setq centaur-tabs-gray-out-icons 'buffer)
  (setq centaur-tabs-set-close-button nil)
  
  ;; (setq centaur-tabs--buffer-show-groups t)
  :bind
  ;; ("C-<prior>" . centaur-tabs-backward)
  ;; ("C-<next>" . centaur-tabs-forward)
  ("<backtab>" . centaur-tabs-backward)
  ("C-<tab>" . centaur-tabs-forward)
  )



















;; 文件末尾
(provide 'init-ui)
