;;-----------------
;;---备选解决方案---
;;-----------------

;; smart C-a and C-e
;;-------------------------------------------------------
(defun zp-smart-beginning-of-line ()
  "Move point to `beginning-of-line'. If repeat command it cycle
position between `back-to-indentation' and `beginning-of-line'."
  (interactive "^")
  (if (and (eq last-command 'zp-smart-beginning-of-line)
           (= (line-beginning-position) (point)))
      (back-to-indentation)
    (beginning-of-line)))

(defun zp-smart-end-of-line ()
  "Move point to `end-of-line'. If repeat command it cycle
position between last non-whitespace and `end-of-line'."
  (interactive "^")
  (if (and (eq last-command 'zp-smart-end-of-line)
           (= (line-end-position) (point)))
      (skip-syntax-backward " " (line-beginning-position))
    (end-of-line)))

(global-set-key (kbd "C-a")     'zp-smart-beginning-of-line)
(global-set-key (kbd "C-e")      'zp-smart-end-of-line)



;; move-text 整行、整段移动
;; Meta-up move-text-up (line or active region)
;; Meta-down move-text-down (line or active region)
;;--------------------------------------------
(use-package move-text
  ;;  :defer t
  :config
  (move-text-default-bindings)
  )




;; Hungry deletion
;;--------------------------------------------
(use-package hungry-delete
  :diminish hungry-delete-mode
  :init (add-hook 'after-init-hook 'global-hungry-delete-mode)
  :config (setq-default hungry-delete-chars-to-skip " \t\f\v"))


;; company中显示yasnippet
;;------------------------------------------------------------------------------------------------------
(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")

(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))



;; ;;显示括号匹配 highlight-parentheses
;; ;;----------------------------
;; (use-package highlight-parentheses
;;   :diminish highlight-parentheses-mode
;;   :init
;;   (add-hook 'prog-mode-hook 'highlight-parentheses-mode)
;;   (add-hook 'org-mode-hook 'highlight-parentheses-mode)
;;   (add-hook 'text-mode-hook 'highlight-parentheses-mode)
;;   :config
;;   (set-face-attribute 'hl-paren-face nil :weight 'bold)
;;   (setq hl-paren-colors (quote ("red" "yellow" "blue" "green")))
;;   )








;;显示括号匹配
;;------------------
(show-paren-mode t)
;; show-paren-mode 高亮包含内容的两个括号 备选(highlight-parentheses)
;;------------------------------------------------------------------------
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
		(t (save-excursion
			 (ignore-errors (backward-up-list))
			 (funcall fn)))))

;; '(show-paren-match ((t (:background "dark green" :foreground "snow"))))
;; '(show-paren-mismatch ((t (:background "yellow" :foreground "black"))))





;; 定时只读当前buffer
(run-with-idle-timer 20 t '(lambda()
                             (read-only-mode 1)
                             ))


;; 定时只读所有buffer
;;------------------------------------------------------------------------
(defun zp-auto-read-only-all-buffers ()
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      ;; (when (and (buffer-file-name) (file-exists-p (buffer-file-name)) (not (buffer-modified-p)))
      ;;   (read-only-mode 1))
      (when (and (buffer-file-name) (file-exists-p (buffer-file-name)))
        (read-only-mode 1))
      ))
  (message "All buffers are read-only")
  )
(run-with-idle-timer 60 t 'zp-auto-read-only-all-buffers)


;; 默认打开文件为只读
;;----------------------------------
;; (defun zp-read-only-setup()
;;   (read-only-mode))
;; (add-hook 'find-file-hook #'zp-read-only-setup)


;; ivy custom-set-faces
 '(ivy-current-match ((t (:inherit bold :background "purple4"))))

;; 换行符处理，在DOS系统下的\r(^M)换行符， 这让我们有时候在Unix系统中很是头疼，因为它的存在会使版本控制误以为整行的代码都 被修改过而造成不必要的麻烦
;; 隐藏换行符
(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (unless buffer-display-table
    (setq buffer-display-table (make-display-table)))
  (aset buffer-display-table ?\^M []))
;; 删除换行符
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))


;; 根据系统已经安装字体进行设置
;;-----------------------------------------------------------------------------------------------
;; 判断某字体在系统中是否安装
(defun zp-font-exist (font)
  (if (null (x-list-fonts font))
      nil t))
;; 要按顺序找到一个字体列表list中第一个已经安装可用的字体
(defvar zp-font-list '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
(require 'cl) ;; find-if is in common list package
(find-if #'zp-font-exist zp-font-list)
;; 产生font size信息的font描述文本
(defun zp-make-font-string (font-name font-size)
  (if (and (stringp font-size) 
           (equal ":" (string (elt font-size 0))))
      (format "%s%s" font-name font-size)
    (format "%s %s" font-name font-size)))
;; 设置字体函数(中英文分别设置)但性能有点问题,未使用
(defun zp-set-font (english-fonts
                       english-font-size
                       chinese-fonts
                       &optional chinese-font-size)
  "english-font-size could be set to \":pixelsize=18\" or a integer.
If set/leave chinese-font-size to nil, it will follow english-font-size"
  (require 'cl)  ;;for find if
  (let ((en-font (zp-make-font-string
                  (find-if #'zp-font-exist english-fonts)
                  english-font-size))
        (zh-font (font-spec :family (find-if #'zp-font-exist chinese-fonts)
                            :size chinese-font-size)))
 
    ;; Set the default English font
    ;; The following 2 method cannot make the font settig work in new frames.
    ;; (set-default-font "Consolas:pixelsize=18")
    ;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
    ;; We have to use set-face-attribute
    (message "Set English Font to %s" en-font)
    (set-face-attribute
     'default nil :font en-font)
 
    ;; Set Chinese font 
    ;; Do not use 'unicode charset, it will cause the english font setting invalid
    (message "Set Chinese Font to %s" zh-font)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset
                        zh-font))))
;; 调用
;; (zp-set-font
;;  '("Source Code Pro" "Consolas" "DejaVu Sans Mono") ":pixelsize=14"
;;  '("Source Code Pro" "微软雅黑" "楷体") 14
;;  )
;;-----------------------------------------------------------------------------------------------



;; 切换主题函数 ??? 无法复原主题自定义设置
;;--------------------------
;; (defun zp-switch-theme (theme-a theme-b)
;;   "参数要使用'(theme_name)的形式"
;;   (if (equal custom-enabled-themes theme-a)
;;       (progn
;;         (load-theme (car theme-b) t)
;;         (disable-theme (car theme-a)))
;;     (if (equal custom-enabled-themes theme-b)
;;         (progn
;;           (load-theme (car theme-a) t)
;;           (disable-theme (car theme-b))
;;           ))))

;; 切换深浅theme ??? 切换时无法复原自定义设置
;; (global-set-key (kbd "C-x t") '(lambda()
;;                                  (interactive)
;;                                  (zp-switch-theme zp-theme-dark zp-theme-light)
;;                                  (zp-theme-custom-setting)
;;                                  ))



;; Fill-Column-Indicator
;; https://github.com/alpaker/Fill-Column-Indicator

