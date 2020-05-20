;;-----------------
;;--- 基础设置 ----
;;-----------------

;; ;; Start server
;; (use-package server
;;   :ensure nil
;;   :init (add-hook 'after-init-hook 'server-mode))

;; 用户名称
;;-----------------------
(setq user-full-name "zpbird")

;; Email
;;----------------------
(setq user-mail-address "zpbird7902@126.com")

;; 自定义工作目录
;; (setq default-directory "/test/" )

;; 缩进设置
;;------------------------
(setq-default tab-width 2
			  indent-tabs-mode nil
			  )

;; 保存文件编辑状态(屏幕位置、光标位置)
;;----------------------------
(use-package saveplace
  :ensure nil
  :init
  ;; Emacs 25 has a proper mode for `save-place'
  (if (fboundp 'save-place-mode)
      (add-hook 'after-init-hook 'save-place-mode)
    (setq save-place t)
    )
  :config
  (setq save-place-file "~/places.pl")
  )

;;smex 命令提示
;;---------------------------------------------------------------------------
;; (require 'smex) ;; Not needed if you use package.el
;; (smex-initialize) ;; Can be omitted. This might cause a (minimal) delay
;; ;; when Smex is auto-initialized on its first run.
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; ;; This is your old M-x.
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; swiper
;;---------------------------------------------------------------------------
(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  ;; (global-set-key (kbd "C-c k") 'counsel-ag)
  ;; (global-set-key (kbd "C-c r") 'counsel-rg)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)

  ;; face自定义
  ;; (defun override-zp-ivy-current-match-faces ()
  ;;   (set-face-attribute 'ivy-current-match nil
  ;;                       :inherit 'bold
  ;;                       :background "purple4"
  ;;                       ))
  ;; (add-hook 'after-init-hook 'override-zp-ivy-current-match-faces)
  )




;; counsel
;;---------------------------------------------------------------------------
(use-package counsel
  :defer t
  :bind (("C-c M-a" . counsel-ag)
         ("C-c M-r" . counsel-rg)
         )
  :init
  (global-set-key (kbd "C-x C-r") 'counsel-recentf)
  :config
  ;; 只读打开counsel-rg文件
  (global-set-key (kbd "C-c M-r") '(lambda()
                                     (interactive)
                                     (counsel-rg)
                                     (zp-read-only-buffers)
                                     ))

  )

;; dumb-jump
;;---------------------------------------------------------------------------
(use-package dumb-jump
  :defer t
  :bind (
         ("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window)
         )

  :init
  ;; 只读打开dumb-jump文件
  (global-set-key (kbd "M-g o") '(lambda()
                                   (interactive)
                                   (dumb-jump-go-other-window)
                                   (zp-read-only-buffers)
                                   ))
  
  :config
  (setq dumb-jump-selector 'ivy)
  )

;;窗口管理
;;------------------------------------------
(winner-mode 1)
(global-set-key (kbd "C-c u") 'winner-undo)
(global-set-key (kbd "C-c r") 'winner-redo)

;; scratch buffer设置
;;--------------------------------
(setq initial-scratch-message nil)
(setq initial-major-mode 'org-mode)

;;关闭欢迎界面
;;------------------------------
(setq inhibit-startup-message t)

;;开启最近访问文件列表
;;---------------------------------------------------
(use-package recentf
  :ensure nil
  :defer t
  :init
  (setq recentf-max-saved-items 30)
  ;; lazy load recentf
  ;; (add-hook 'after-init-hook 'recentf-mode)
  (add-hook 'find-file-hook (lambda () (unless recentf-mode
                                         (recentf-mode)
                                         (recentf-track-opened-file))))
  (setq recentf-auto-cleanup 'never)
  :config
  (add-to-list 'recentf-exclude (expand-file-name package-user-dir))
  (add-to-list 'recentf-exclude "bookmarks")
  (add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'"))


;;输入时覆盖选中文本
;;-----------------------
(delete-selection-mode 1)

;; 高亮当前行
;;----------------------
(global-hl-line-mode 1)

;; Emacs自动加载外部修改过的文件
;;---------------------------
(global-auto-revert-mode 1)

;; 关闭系统默认自动另存
(setq auto-save-default nil)

;; 关闭自动备份
;;---------------------------
(setq make-backup-files nil)

;; 关闭Emacs中的警告音
;;-------------------------------
(setq ring-bell-function 'ignore)

;; 简化输入(y or n)
;;------------------------------
(fset 'yes-or-no-p 'y-or-n-p)



;;显示括号匹配
;;------------------
(show-paren-mode t)
(defun override-show-paren-faces ()
  (set-face-attribute 'show-paren-match nil
                      :background "dark green"
                      :foreground "snow"
                      :weight 'bold
                      )

  (set-face-attribute 'show-paren-mismatch nil
                      :background "yellow"
                      :foreground "black"
                      :weight 'bold
                      )
  )
(add-hook 'prog-mode-hook 'override-show-paren-faces)
(add-hook 'text-mode-hook 'override-show-paren-faces)
(add-hook 'org-mode-hook 'override-show-paren-faces)




;; show-paren-mode 高亮包含内容的两个括号 备选(highlight-parentheses)
;;------------------------------------------------------------------------
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
		(t (save-excursion
			 (ignore-errors (backward-up-list))
			 (funcall fn)))))



;;选中(region)自动拷贝到剪切板
(setq x-select-enable-primary t)   ;; 25.1版本之前使用
(setq selec-ennable-primary t)  ;; 
;; (setq select-active-regions t)  ;; ???

;;支持emacs和外部程序的拷贝粘贴
;;----------------------------------
(setq x-select-enable-clipboard t)  ;; 25.1版本之前使用
(setq select-enable-clipboard t)  ;; 

;;在文档最后自动插入空白一行，好像某些系统配置文件是需要这样的
;;------------------------------------------------------
(setq require-final-newline t)
(setq track-eol t)


;;设定删除保存记录为200
;;-----------------------
(setq kill-ring-max 200)



;; 设置垃圾回收，在Windows下，emacs25版本会频繁出发垃圾回收，需要设置
(when (eq system-type 'windows-nt)
  (setq gc-cons-threshold (* 512 1024 1024))
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 5 t #'garbage-collect)
;; 显示垃圾回收信息，这个可以作为调试用
;; (setq garbage-collection-messages t)
)



;; 自动保存文件
;;-------------------------------------------

;; (use-package super-save
;;   :ensure t
;;   :config
;;   (super-save-mode +1)
;;   (setq super-save-auto-save-when-idle t)
;;   (add-to-list 'super-save-hook-triggers 'find-file-hook)
;;   )



;; 保存退出状态
(desktop-save-mode 1)

(column-number-mode t)
(display-time-mode t)


;; 退出emacs时确认
(setq confirm-kill-emacs 'y-or-n-p)

;; 获取linux环境变量




;;=== End =====
(provide 'init-base)

