;;================================================================================================================
;;--- 自定义Emacs的HOME目录 ---
;;----------------------------------------------------------------------------------------------------------------
;; 1. Emacs 的配置文件默认保存在 ~/.emacs.d/init.el 文件中。如果其不存在可自行创建， 配置文件也可保存在 ~/.emacs 文件中
;;    注意： 如果希望把配置放在 ~/.emacs.d/init.el 文件中，那么需要手工删除 ~/.emacs 文件。
;; 2. linux下指定配置文件的位置
;;    1. 在/usr/share/emacs/25.2/site-lisp/目录中创建site-start.el文件
;;    2. 在此文件中添加指定配置文件位置语句
;;       (setenv "HOME" "/store/zpbird/software/emacs/emacs_home/")
;; 3. windows指定配置文件位置
;;    1. 通过中site-start.el文件中使用判断语句，使得windows与linux可以使用同一个文件
;;    2. 注册表设置home目录
;;       Windows 7x86  HKEY_LOCAL_MACHINE/Software/GNU/Emacs/HOME=D:\zpbird\software\emacs\emacs_home
;;       Windows 7x64  HKEY_LOCAL_MACHINE/Software/Wow6432Node/GNU/Emacs/HOME=D:\zpbird\software\emacs\emacs_home
;;----------------------------------------------------------------------------------------------------------------


(package-initialize)
(add-to-list 'load-path "~/config/")



;;==============================================================================
;;--- 子配置文件 ---
;;------------------------------------------------------------------------------
;; 注意加载顺序


;;     1. init-packages.el        # 插件管理
(require 'init-packages)
;;     2. init-zpbird.el          # 自定义常量、变量、函数
(require 'init-zpbird)
;;     3. init-codingfont.el      # 文件编码、字体设置
(require 'init-codingfont)
;;     4. init-base.el            # 基础设置
(require 'init-base)
;;     5. init-theme.el           # 主题安装、自定义设置
(require 'init-theme)
;;     6. init-ui.el              # 视觉层配置
(require 'init-ui)
;;     7. init-edit.el            # 文本编辑功能
(require 'init-edit)
;;     8. init-org.el             # org-mode配置
(require 'init-org)
;;     9. init-company.el         # company设置
(require 'init-company)
;;    10. init-flycheck.el        # flycheck设置
(require 'init-flycheck)
;;    11. init-frontend.el        # web前端相关
(require 'init-frontend)
;;    12. init-backend.el         # web后端相关
(require 'init-backend)
;;    13. init-others.el          # 其他
(require 'init-others)
;;    14. init-test.el            # 测试
(require 'init-test)
;;    15. custom.el               # 存放使用编辑器接口产生的配置信息
(setq custom-file (expand-file-name "~/config/custom.el" user-emacs-directory))
(load-file custom-file)
;;    16. init-lsp.el
(require 'init-lsp)
;;==============================================================================








