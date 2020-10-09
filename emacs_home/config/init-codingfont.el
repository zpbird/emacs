;;-----------------------------------------
;;--- init-codingfont.e 文件编码、字体设置---
;;-----------------------------------------

;;-------------------
;;---coding system---
;;-------------------
;; 设置默认读入文件编码
(prefer-coding-system 'utf-8)

;; 设置写入文件编码
(setq default-buffer-file-coding-system 'utf-8)




;;------------------
;;---font setting---
;;------------------
;; 设置字体
(if (display-graphic-p)
    ;;设置图形界面下字体
    ;; (zp-set-fonts "等距更纱黑体 SC" "Source Code Pro" "DejaVu Sans Mono" "10")
    
    (if (string= system-type "windows-nt")

        (progn
          ;; (message "I am windows_system")
          (zp-set-fonts "等距更纱黑体 SC" "Source Code Pro" "DejaVu Sans Mono" "11")
          )

      (progn
        ;; (message "I am linux")
        (zp-set-fonts "等距更纱黑体 SC" "Source Code Pro" "DejaVu Sans Mono" "12")
        )

      )

  )



;;------------------------------







;; 文件末尾
(provide 'init-codingfont)
