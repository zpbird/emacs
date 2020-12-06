;;================================================================================================================
;;--- �Զ���Emacs��HOMEĿ¼ ---
;;----------------------------------------------------------------------------------------------------------------
;; 1. Emacs �������ļ�Ĭ�ϱ����� ~/.emacs.d/init.el �ļ��С�����䲻���ڿ����д����� �����ļ�Ҳ�ɱ����� ~/.emacs �ļ���
;;    ע�⣺ ���ϣ�������÷��� ~/.emacs.d/init.el �ļ��У���ô��Ҫ�ֹ�ɾ�� ~/.emacs �ļ���
;; 2. linux��ָ�������ļ���λ��
;;    1. ��/usr/share/emacs/25.2/site-lisp/Ŀ¼�д���site-start.el�ļ�
;;    2. �ڴ��ļ������ָ�������ļ�λ�����
;;       (setenv "HOME" "/store/zpbird/software/emacs/emacs_home/")
;; 3. windowsָ�������ļ�λ��
;;    1. ͨ����site-start.el�ļ���ʹ���ж���䣬ʹ��windows��linux����ʹ��ͬһ���ļ�
;;    2. ע�������homeĿ¼
;;       Windows 7x86  HKEY_LOCAL_MACHINE/Software/GNU/Emacs/HOME=D:\zpbird\software\emacs\emacs_home
;;       Windows 7x64  HKEY_LOCAL_MACHINE/Software/Wow6432Node/GNU/Emacs/HOME=D:\zpbird\software\emacs\emacs_home
;;----------------------------------------------------------------------------------------------------------------


(package-initialize)
(add-to-list 'load-path "~/config/")



;;==============================================================================
;;--- �������ļ� ---
;;------------------------------------------------------------------------------
;; ע�����˳��


;;     1. init-packages.el        # �������
(require 'init-packages)
;;     2. init-zpbird.el          # �Զ��峣��������������
(require 'init-zpbird)
;;     3. init-codingfont.el      # �ļ����롢��������
(require 'init-codingfont)
;;     4. init-base.el            # ��������
(require 'init-base)
;;     5. init-theme.el           # ���ⰲװ���Զ�������
(require 'init-theme)
;;     6. init-ui.el              # �Ӿ�������
(require 'init-ui)
;;     7. init-edit.el            # �ı��༭����
(require 'init-edit)
;;     8. init-org.el             # org-mode����
(require 'init-org)
;;     9. init-company.el         # company����
(require 'init-company)
;;    10. init-flycheck.el        # flycheck����
(require 'init-flycheck)
;;    11. init-frontend.el        # webǰ�����
(require 'init-frontend)
;;    12. init-backend.el         # web������
(require 'init-backend)
;;    13. init-others.el          # ����
(require 'init-others)
;;    14. init-test.el            # ����
(require 'init-test)
;;    15. custom.el               # ���ʹ�ñ༭���ӿڲ�����������Ϣ
(setq custom-file (expand-file-name "~/config/custom.el" user-emacs-directory))
(load-file custom-file)
;;    16. init-lsp.el
(require 'init-lsp)
;;==============================================================================








