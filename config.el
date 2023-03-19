(setq user-full-name "Keara Coara"
      user-mail-address "for156th@gmail.com")

(setq doom-font (font-spec :family "Fira Code" :size 20 :weight 'semi-light))
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;

(setq doom-theme 'doom-one)

(setq display-line-numbers-type t)

;   (after! PACKAGE
;     (setq x y))

(evil-global-set-key 'normal (kbd "u") 'evil-previous-line)
(evil-global-set-key 'normal (kbd ",.")'evil-jump-item)
(evil-global-set-key 'normal (kbd "e") 'evil-next-line)
(evil-global-set-key 'normal (kbd "n") 'evil-backward-char)
(evil-global-set-key 'normal (kbd "i") 'evil-forward-char)
(evil-global-set-key 'visual (kbd "u") 'evil-previous-line)
(evil-global-set-key 'visual (kbd "e") 'evil-next-line)
(evil-global-set-key 'visual (kbd "n") 'evil-backward-char)
(evil-global-set-key 'visual (kbd "i") 'evil-forward-char)
(evil-global-set-key 'normal (kbd "N") 'evil-beginning-of-line)
(evil-global-set-key 'normal (kbd "I") 'evil-end-of-line)
(evil-global-set-key 'visual (kbd "N") 'evil-beginning-of-line)
(evil-global-set-key 'visual (kbd "I") 'evil-end-of-line)
(evil-global-set-key 'normal (kbd "h") 'evil-undo)
(evil-global-set-key 'normal (kbd "s") 'evil-insert)
(evil-global-set-key 'normal (kbd "L") 'evil-insert-line)
(evil-global-set-key 'normal (kbd "`") 'evil-invert-char)
(evil-global-set-key 'normal (kbd "S") 'save-buffer)
(evil-global-set-key 'normal (kbd "Q") 'evil-quit)
(evil-global-set-key 'normal (kbd ";") 'evil-ex)
(evil-global-set-key 'normal (kbd "j") 'evil-forward-word-end)
(evil-global-set-key 'normal (kbd "J") 'evil-forward-word-end)
(evil-global-set-key 'normal (kbd "k") (if (eq evil-search-module 'evil-search) 'evil-ex-search-next 'evil-search-next))
(evil-global-set-key 'normal (kbd "K") (if (eq evil-search-module 'evil-search) 'evil-ex-search-previous 'evil-search-previous))
(evil-global-set-key 'normal (kbd "SPC w u") 'evil-window-up)
(evil-global-set-key 'normal (kbd "SPC w e") 'evil-window-down)
(evil-global-set-key 'normal (kbd "SPC w n") 'evil-window-left)
(evil-global-set-key 'normal (kbd "SPC w i") 'evil-window-right)

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
