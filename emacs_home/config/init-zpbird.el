;;-------------------------------------------------------
;;--- init-zpbird.el 自定义常量、变量、函数---
;;-------------------------------------------------------


;; 打开文件只读所有buffer
;;-------------------------
(defun zp-read-only-buffers ()
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (file-exists-p (buffer-file-name)))
        (read-only-mode 1))
      ))
  (message "all buffers are read only")
  )

;; 关闭所有buffer
;;-------------------------------------
(defun zp-close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list))
  (delete-other-windows)
  )




;; 根据系统已经安装字体进行设置
;;-----------------------------------------------------------------------------------------------
;; 判断某字体在系统中是否安装
(defun zp-font-exist (font)
  (if (null (x-list-fonts font))
      nil t))

;; 自定义设置字体函数
(defun zp-set-fonts (font-a font-b font-c font-size)
  ;; font-a
  (if (zp-font-exist font-a)
      (progn
        (set-default-font (concat font-a "-" font-size))
        ;; (message (concat "设置字体为：" font-a ))
        )
    ;; font-b
    (if (zp-font-exist font-b)
        (progn
          (set-default-font (concat font-b "-" font-size))
          ;; (message (concat "设置字体为：" font-b ))
          )
      ;; font-c
      (if (zp-font-exist font-c)
          (progn
            (set-default-font (concat font-c "-" font-size))
            ;; (message (concat "设置字体为：" font-c ))
            )
        (message "未指定字体")
        ))))

;; 加载主题自定义设置
(defun zp-theme-custom-setting ()
  ;; spacemacs-dark 自定义设置
  (if (equal custom-enabled-themes '(spacemacs-dark))
      (zp-spacemacs-theme)
    ;; spacemacs-light 自定义设置
    (if (equal custom-enabled-themes '(spacemacs-light))
        (zp-spacemacs-theme)
      ;; 其他主题(elseif嵌套)...
        )
      ))

;; 文件末尾
(provide 'init-zpbird)
