;;-------------------------------------------------------
;;--- init-packages.el 插件管理 ---
;;-------------------------------------------------------


;;--- 开启自动安装软件 ---
;;放置在配置文件顶端,直接使用Melpa作为插件源,将插件名字写在my/packages中,Emacs启动时会自动下载未被安装的插件
(when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
          ("melpa" . "http://elpa.emacs-china.org/melpa/"))))
;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像
;; cl - Common Lisp Extension
 (require 'cl)

;; 安装软件列表
(defvar my/packages '(
            ;;-------------------------
            ;; --- use-package ---
            ;;------------------------
            use-package
            ;;-------------------------
            ;; --- Auto-completion ---
            ;;-------------------------
            tern
            pylint
            elpy
            smex
            swiper
            counsel
            company
            company-statistics
            company-tern
            company-jedi
            yasnippet
            yasnippet-snippets
            jedi
            ;; jedi-core
            ;;-----------------------
            ;; --- Better Editor ---
            ;;-----------------------
            dumb-jump
            multiple-cursors
            smartparens
            expand-region
            smart-hungry-delete
            drag-stuff
            vimish-fold
            beacon
;;            org-mind-map
            mwim
            syntax-subword
            symbol-overlay
            goto-last-change
            sudo-edit
            super-save
            magit
            ;;--------------------
            ;; --- Major Mode ---
            ;;--------------------
            web-mode
            js2-mode
            json-mode
            lua-mode
            dockerfile-mode
            yaml-mode
            docker-compose-mode
            go-mode
            gorepl-mode
            company-lsp
            company-go
            ;; svelte-mode
            ;; posframe
            ;; jsonrpc
            ;; eglot
            ;;--------------------
            ;; --- Minor Mode ---
            ;;--------------------
            emmet-mode
            flycheck
            company-web
            css-eldoc
            js2-refactor
            markdown-mode
            tide
            lsp-mode
            lsp-ui
            
            ;;--------------------
            ;; --- UI ---
            ;;--------------------
            rainbow-mode
            ;; window-numbering
            rainbow-delimiters
            centaur-tabs
            ;;----------------
            ;; --- Themes ---
            ;;----------------
            spacemacs-theme
            ;; subatomic256-theme
            ;;----------------
            ;; --- Others ---
            ;;----------------
            ;;
            ;; ssh
            ;;
            ;;----------------
            ) "Default packages")

;;------------------------------------------

(setq package-selected-packages my/packages)

(defun my/packages-installed-p ()
     (loop for pkg in my/packages
     when (not (package-installed-p pkg)) do (return nil)
     finally (return t)))

(unless (my/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg my/packages)
       (when (not (package-installed-p pkg))
   (package-install pkg))))

;; Find Executable Path on OS X 苹果系统使用
;; (when (memq window-system '(mac ns))
;;   (exec-path-from-shell-initialize))

;;设置软件源,如果不使用上面自动安装软件功能的话，下面为单独设置插件源
;;(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
;;                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))

;; End------------------
(provide 'init-packages)
