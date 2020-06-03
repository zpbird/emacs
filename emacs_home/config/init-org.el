;;-------------------------
;;---org-mode相关设置-------
;;-------------------------





;;禁用冲突快捷键
;;------------------------------------------------------
(use-package org
  :defer t
  :config
  (org-defkey org-mode-map (kbd "C-a") nil)
  (org-defkey org-mode-map (kbd "C-e") nil)
  (org-defkey org-mode-map (kbd "C-c C-k") nil)
  (org-defkey org-mode-map (kbd "C-c C-r") nil)
  (org-defkey org-mode-map (kbd "C-<tab>") nil)
  (org-defkey org-mode-map (kbd "S-<tab>") nil)
  (org-defkey org-mode-map (kbd "<backtab>") nil)
  )


;;文学编程
;;----------------------------------------
(setq org-src-fontify-natively t)


;;各级别标题字体大小
;;--------------------------------------------------
(defun override-org-level-faces ()
  (dolist (face '(org-level-1
                  org-level-2
                  org-level-3
                  org-level-4
                  org-level-5
                  org-level-6
                  org-level-7
                  org-level-8
                  ))
    (set-face-attribute face nil
                        :inherit 'bold
                        :height 1.0
                        :weight 'bold
                        )))
(add-hook 'org-mode-hook 'override-org-level-faces)

;;自动换行
;;---------------------------------------------------------------
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

;;大纲缩进
;;--------------------------------------------------
;; (setq org-startup-indented t)
(setq-default org-startup-indented t)







;;=== End =========
(provide 'init-org)
