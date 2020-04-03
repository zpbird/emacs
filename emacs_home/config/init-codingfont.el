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
    (zp-set-fonts "等距更纱黑体 SC" "Source Code Pro" "DejaVu Sans Mono" "10")
    ;; (zp-set-fonts "明黑等宽" "Source Code Pro" "DejaVu Sans Mono" "12")
    ;; (zp-set-fonts "M+ 1m" "Source Code Pro" "DejaVu Sans Mono" "10")
    ;; (zp-set-fonts "Ubuntu Mono" "Source Code Pro" "DejaVu Sans Mono" "11")
    ;; (zp-set-fonts "Cascadia Code" "Source Code Pro" "DejaVu Sans Mono" "10")
    ;; (zp-set-fonts "YaHei Monaco Hybird" "Source Code Pro" "DejaVu Sans Mono" "10")

    ;; win10下有时候需要设置为系统自带中文字体，否则会出现卡顿
    ;; (zp-set-fonts "YaHei Consolas Hybrid" "Source Code Pro" "DejaVu Sans Mono" "10")
    ;; (zp-set-fonts "微软雅黑Monaco" "Source Code Pro" "DejaVu Sans Mono" "10")
  ;;设置终端下字体
  ;; (zp-set-fonts "Consolas" "DejaVu Sans Mono" "Source Code Pro" "10")
  )



;;------------------------------







;; 文件末尾
(provide 'init-codingfont)
