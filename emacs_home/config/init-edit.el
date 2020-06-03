;;--------------------
;;---文本编辑功能配置---
;;--------------------

;;缩写补全 缩写前使用的7也类似于命名空间的作用,使其不会与常用字符串冲突
;;------------------------------------------------------------
;; (setq-default abbrev-mode t)
;; (define-abbrev-table 'global-abbrev-table '(
;; 					    ("7zp" "zpbird")
;; 					   ))

;; 设置取消快捷键
;;--------------------
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; 默认打开文件为只读
;;----------------------------------
;; (defun zp-read-only-setup()
;;   (read-only-mode))
;; (add-hook 'find-file-hook #'zp-read-only-setup)
;; (global-set-key (kbd "C-x C-f") 'find-file-read-only)
(global-set-key (kbd "C-x C-f") '(lambda()
                                   (interactive)
                                   (counsel-find-file)
                                   (zp-read-only-buffers)
                                   ))

;; 只读打开recentf文件
;;----------------------------------------------------------
(global-set-key (kbd "C-x C-r") '(lambda()
                                   (interactive)
                                   (counsel-recentf)
                                   (zp-read-only-buffers)
                                   ))
;; 只读切换buffer
;;---------------------------------------------------------------------
(global-set-key (kbd "C-x b") '(lambda()
                                   (interactive)
                                   (ivy-switch-buffer)
                                   (zp-read-only-buffers)
                                   ))

;; 只读切换
;;---------------------------------------------
;; (global-set-key (kbd "C-c o") 'read-only-mode)
(global-set-key (kbd "C-z") 'read-only-mode)

;; 定时只读所有buffer
;;------------------------------------------------------------------------
(run-with-idle-timer 300 t 'zp-read-only-buffers)



;; 关闭所有buffer
;;----------------------------------
(global-set-key (kbd "C-c C-k") 'zp-close-all-buffers)




;;smartparens 自动完成括号
;;-----------------------------------
(use-package smartparens
  :config
  (progn
	(smartparens-global-strict-mode +1)
	)
  )

;;smart-hungry-delete 删除多个空格
;;-------------------------------
(use-package smart-hungry-delete
  :ensure t
  :bind (("<backspace>" . smart-hungry-delete-backward-char)
		 ("C-d" . smart-hungry-delete-forward-char))
  :defer nil ;; dont defer so we can add our functions to hooks 
  :config (smart-hungry-delete-add-default-hooks)
  )

;;行首行尾优化(备选:smart C-a and C-e)
;;-----------------------------------------------
(use-package mwim
  :defer t
  :bind (("C-a" . mwim-beginning-of-code-or-line)
         ("C-e" . mwim-end-of-code-or-line)))

;; 支持驼峰书写的光标移动
;;--------------------------------------------------------
(use-package syntax-subword
  :ensure nil
  :defer t
  :diminish syntax-subword-mode
  :init
  (add-hook 'prog-mode-hook 'syntax-subword-mode)
  (add-hook 'org-mode-hook 'syntax-subword-mode)
  (add-hook 'text-mode-hook 'syntax-subword-mode)
  )

;;剪切和复制当前行设置
;;-------------------------------------------------------------
(defadvice kill-ring-save (before slickcopy activate compile)  
   (interactive  
    (if mark-active (list (region-beginning) (region-end))  
      (list (line-beginning-position)  
            (line-beginning-position 2)))))  
 (defadvice kill-region (before slickcut activate compile)  
   (interactive  
    (if mark-active (list (region-beginning) (region-end))  
      (list (line-beginning-position)  
            (line-beginning-position 2))))) 
;;禁用sp-kill-region中的快捷键C-w占用
(setq smartparens-strict-mode-map nil)

;;插入空行
;;--------------------------------------------------------------
(global-set-key (kbd "M-n") '(lambda ()
							   (interactive)
							   (move-end-of-line 1)
							   (newline)))
(global-set-key (kbd "M-p") '(lambda ()
							   (interactive)
							   (move-beginning-of-line 1)
							   (open-line 1)))

;;expand-region 扩展选择
;;--------------------------------------------------
(use-package expand-region
  :defer t
  :bind ("C-`" . er/expand-region)
  )

;; Drag stuff (lines, words, region, etc...) around (备选:move-text)
;;------------------------------------------------------------------
(use-package drag-stuff
  :defer t
  :diminish drag-stuff-mode
  :init (add-hook 'after-init-hook 'drag-stuff-global-mode)
  :config
  (add-to-list 'drag-stuff-except-modes 'org-mode)
  (drag-stuff-define-keys))







;; 新建窗口并激活
;;------------------------------------------------------------
(defun split-window-below-and-focus ()
  "Split the window vertically and focus the new window."
  (interactive)
  (split-window-below)
  (windmove-down)
  )
(global-set-key (kbd "C-x 2") 'split-window-below-and-focus)


(defun split-window-right-and-focus ()
  "Split the window horizontally and focus the new window."
  (interactive)
  (split-window-right)
  (windmove-right)
  )
(global-set-key (kbd "C-x 3") 'split-window-right-and-focus)


;;一键注释
;;------------------------------------------------------------------------------
(global-set-key [?\C-c ?\C-/] 'comment-or-uncomment-region)

(defun zp-comment-or-uncomment-region (beg end &optional arg)  
  (interactive (if (use-region-p)  
                   (list (region-beginning) (region-end) nil)  
                 (list (line-beginning-position)  
                       (line-beginning-position 2))))  
  (comment-or-uncomment-region beg end arg)  
)  
(global-set-key [remap comment-or-uncomment-region] 'zp-comment-or-uncomment-region)

;;代码缩进indent-region使用下面的代码可以一次重新缩进全部缓冲区的代码
;;-------------------------------------------------------------
(defun indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indent selected region."))
      (progn
	(indent-buffer)
	(message "Indent buffer.")))))
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)



;; goto-last-change
;;-----------------------------------------
(use-package goto-last-change
  :defer t
  :bind ("C-c l" . goto-last-change)
  )

;; root权限打开文件
;;-----------------------------------------
(use-package sudo-edit
  :defer t
  :bind ("C-c C-r" . sudo-edit)
  )




;; markdown-mode
;; ----------------------------------------------
(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init 
  (progn
    (setq markdown-command "multimarkdown")
    )
  :config
  ;; (markdown-hide-body)

  )




;; dockerfile-mode
;; ----------------------------------------------
;; You can specify the image name in the file itself by adding a line like this at the top of your Dockerfile.
;; ## -*- docker-image-name: "your-image-name-here" -*-

(use-package dockerfile-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
  
  ;; If you don't, you'll be prompted for an image name each time you build. You may want to add the following to your emacs config:
  ;; (put 'dockerfile-image-name 'safe-local-variable #'stringp)
  )



;; yaml-mode
;; ----------------------------------------------
(use-package dockerfile-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
    
  )



;; docker-compose-mode
;; ----------------------------------------------
(use-package docker-compose-mode)


;; magit
;; ----------------------------------------------
(use-package magit
  :ensure t
  :bind ("C-x C-g" . magit-status)
  :config (setq magit-save-repository-buffers 'dontask))


;; iedit
;; ----------------------------------------------
(use-package iedit
  
  )









;;=== End ==========
(provide 'init-edit)



