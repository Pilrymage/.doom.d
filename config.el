(setq user-full-name "Keara Coara"
      user-mail-address "for156th@gmail.com")

(setq doom-font (font-spec :family "Fira Code" :size 20 :weight 'semi-light))
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;

(setq doom-theme 'doom-one)

(setq display-line-numbers-type t)

(setq scroll-margin 4)

;   (after! PACKAGE
;     (setq x y))

(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-c") 'kill-ring-save) ;;对应Windows上面的Ctrl-c 复制
(global-set-key (kbd "s-s") 'save-buffer) ;; 对应Windows上面的Ctrl-s 保存
(global-set-key (kbd "s-v") 'yank) ;对应Windows上面的Ctrl-v 粘贴
(global-set-key (kbd "s-z") 'undo) ;对应Windows上面的Ctrol-z 撤销
(global-set-key (kbd "s-x") 'kill-region) ;对应Windows上面的Ctrol-x 剪切
(setq w32-apps-modifier 'super)       ; 通过SharpKeys改成了 Application

;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.doom.d/config.org"))

;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)

(defun repeat-command (proc times)
  (dotimes (_ times)
    (funcall proc)))

(defun my-previous-five-line ()
  (interactive)
  (repeat-command 'evil-previous-line 5))

(defun my-next-five-line ()
  (interactive)
  (repeat-command 'evil-next-line 5))
(after! org
(evil-global-set-key 'normal (kbd "u") 'evil-previous-line)
(evil-global-set-key 'normal (kbd "e") 'evil-next-line)
(evil-global-set-key 'normal (kbd "n") 'evil-backward-char)
(evil-global-set-key 'normal (kbd "i") 'evil-forward-char)
(evil-global-set-key 'normal (kbd ",.")'evil-jump-item)
(evil-global-set-key 'normal (kbd "U") 'my-previous-five-line)
(evil-global-set-key 'normal (kbd "E") 'my-next-five-line)

(evil-global-set-key 'visual (kbd "u") 'evil-previous-line)
(evil-global-set-key 'visual (kbd "e") 'evil-next-line)
(evil-global-set-key 'visual (kbd "n") 'evil-backward-char)
(evil-global-set-key 'visual (kbd "i") 'evil-forward-char)
(evil-global-set-key 'visual (kbd ",.")'evil-jump-item)
(evil-global-set-key 'visual (kbd "U") 'my-previous-five-line)
(evil-global-set-key 'visual (kbd "E") 'my-next-five-line)

(evil-global-set-key 'normal (kbd "N") 'evil-beginning-of-line)
(evil-global-set-key 'normal (kbd "I") 'evil-end-of-line)

(evil-global-set-key 'visual (kbd "N") 'evil-beginning-of-line)
(evil-global-set-key 'visual (kbd "I") 'evil-end-of-line)

(evil-global-set-key 'normal (kbd "j") 'evil-undo)
(evil-global-set-key 'normal (kbd "s") 'evil-insert)
(evil-global-set-key 'normal (kbd "L") 'evil-insert-line)
(evil-global-set-key 'normal (kbd "`") 'evil-invert-char)
(evil-global-set-key 'normal (kbd "S") 'save-buffer)
(evil-global-set-key 'normal (kbd "Q") 'evil-quit)
(evil-global-set-key 'normal (kbd ";") 'evil-ex)
(evil-global-set-key 'normal (kbd "h") 'evil-forward-word-end)
(evil-global-set-key 'normal (kbd "H") 'evil-forward-word-end)
(evil-global-set-key 'normal (kbd "k") (if (eq evil-search-module 'evil-search) 'evil-ex-search-next 'evil-search-next))
(evil-global-set-key 'normal (kbd "K") (if (eq evil-search-module 'evil-search) 'evil-ex-search-previous 'evil-search-previous))
(evil-global-set-key 'normal (kbd "SPC w u") 'evil-window-up)
(evil-global-set-key 'normal (kbd "SPC w e") 'evil-window-down)
(evil-global-set-key 'normal (kbd "SPC w n") 'evil-window-left)
(evil-global-set-key 'normal (kbd "SPC w i") 'evil-window-right)

(evil-global-set-key 'visual (kbd "j") 'evil-undo)
(evil-global-set-key 'visual (kbd "s") 'evil-insert)
(evil-global-set-key 'visual (kbd "L") 'evil-insert-line)
(evil-global-set-key 'visual (kbd "`") 'evil-invert-char)
(evil-global-set-key 'visual (kbd "S") 'save-buffer)
(evil-global-set-key 'visual (kbd "Q") 'evil-quit)
(evil-global-set-key 'visual (kbd ";") 'evil-ex)
(evil-global-set-key 'visual (kbd "h") 'evil-forward-word-end)
(evil-global-set-key 'visual (kbd "H") 'evil-forward-word-end)
(evil-global-set-key 'visual (kbd "k") (if (eq evil-search-module 'evil-search) 'evil-ex-search-next 'evil-search-next))
(evil-global-set-key 'visual (kbd "K") (if (eq evil-search-module 'evil-search) 'evil-ex-search-previous 'evil-search-previous))
(evil-global-set-key 'visual (kbd "SPC w u") 'evil-window-up)
(evil-global-set-key 'visual (kbd "SPC w e") 'evil-window-down)
(evil-global-set-key 'visual (kbd "SPC w n") 'evil-window-left)
(evil-global-set-key 'visual (kbd "SPC w i") 'evil-window-right))

(setq org-directory "~/Data/Org/")

(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)
   (scheme . t)  ;; I use only geiser-guile
   (python . t)
   (shell . t)))
(setq org-format-latex-options (plist-put org-format-latex-options :scale 3.0))

(after! org
  (setq org-agenda-files
        '("~/Data/Org/agenda.org")))
(setq org-agenda-time-grid (quote (((daily today require-timed)
                                    (800 1000 1200 1400 1600 1800 2000)
                                    "......" "----------------"))))
(setq org-agenda-include-diary t)
(setq org-agenda-diary-file "~/Data/Org/Diary")

(setq org-hugo-auto-set-lastmod nil) ; Disable auto-setting "lastmod" timestamp
(setq org-hugo-use-code-for-kbd t)   ; Use <kbd>...</kbd> for displaying keys
(setq org-hugo-default-section-directory "post") ; Directory name for each post
(setq org-hugo-section "post") ; Export as leaf bundles
(setq org-hugo-date-format "YYYY-MM-DD") ; Customize the date format
(setq org-hugo-section-directory "index.md") ; Export leaf bundles to /content/post/my-first-post/index.md

(pyim-basedict-enable)
(setq default-input-method "pyim")
(pyim-default-scheme 'microsoft-shuangpin)
(setq pyim-cloudim 'google)
(setq pyim-page-length 8)
(defun my-converter (string)
  (if (equal string "×")
      "*"
    string))
(setq pyim-outcome-magic-converter #'my-converter)
