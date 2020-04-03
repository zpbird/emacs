;; 拷贝本文件到/usr/share/emacs/25.2/site-lisp/目录中

(if (string= system-type "windows-nt")

	(progn
	  ;; (message "I am windows_system")
	  (setenv "HOME" "D:\\zpbird\\software\\emacs\\emacs_home")
	  )

  (progn
	;; (message "I am linux")
	(setenv "HOME" "/store/zpbird/software/emacs/emacs_home/")
	)

  )




