;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;

(setq frame-resize-pixelwise t)
(setq tab-width 2)

;; (add-to-list 'default-frame-alist '(undecorated . t))

;(add-to-list 'default-frame-alist '(alpha-background . 90))
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
;; (setq ns-use-proxy-icon nil)
;; (setq frame-title-format nil)
(setq scroll-margin 6)
;(set-frame-parameter nil 'alpha-background 97)
(global-set-key (kbd "<f4>") (lambda () (interactive) (find-file "~/org/agenda/inbox.org")))
(global-set-key (kbd "<f5>") (lambda () (interactive) (find-file "~/.doom.d/config.org")))
(global-set-key (kbd "<f6>") (lambda () (interactive) (find-file "~/Dropbox/emacs/agenda/agenda.org")))
(global-set-key (kbd "<f7>") 'org-agenda)
(global-set-key (kbd "<f12>") (lambda ()
                                (interactive)
                                (call-interactively 'org-store-link)
                                (org-capture nil "i")))
; (add-to-list 'default-frame-alist '(fullscreen . fullheight)) 

;; (setq doom-font (font-spec :family "FiraCode Nerd Font" :size 17))
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font" :size 13))
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org")
(setq org-roam-directory "~/orgroam")

  (setq dashboard-banner-logo-title "NOW'S YOUR CHANCE TO BE A [[BIG SHOT]]")
(use-package! ox-hugo)
;; accept completion from copilot and fallback to company
(use-package! copilot
  ;; :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))
(beacon-mode 1)
(after! org
  (setq org-agenda-files '(
                           ;; " ~/Dropbox/emacs/agenda/agenda.org"
                           ;; "~/Dropbox/emacs/agenda/project.org"
                           ;; "~/Dropbox/emacs/agenda/inbox.org"
                           ;; "~/Dropbox/emacs/agenda/someday.org"
                           "~/org/agenda"))
  (setq org-agenda-custom-commands
        '(("d" "今日事"
           ((agenda ""
                    ((org-agenda-skip-function '(org-agenda-skip-entry-if 'loop))
                     (org-agenda-span 1)))))
          ("v" "Org 看板"
           ((agenda ""
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp "\\[#A\\]"))
                   (org-agenda-entry-types '(:scheduled))
                   (org-agenda-span 7)
                   (org-agenda-time-grid nil)
                   (org-agenda-overriding-header "高优先级 紧急")))
            (agenda ""
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'regexp "\\[#A\\]"))
                   (org-agenda-entry-types '(:scheduled))
                   (org-agenda-span 5)
                   (org-agenda-time-grid nil)
                   (org-agenda-overriding-header "中低优先级 紧急")))
            (tags "+PRIORITY=\"A\""
                  ((org-agenda-overriding-header "高优先级")))
            (tags "+PRIORITY=\"B\"" ((org-agenda-overriding-header "中优先级")))
            (tags "+PRIORITY=\"C\"" ((org-agenda-overriding-header "低优先级"))))))) 

          
  (setq org-agenda-start-day "0d")
  (setq org-todo-repeat-to-state t)
  (setq org-capture-templates `(("i" "Inbox" entry (file "~/Dropbox/emacs/agenda/inbox.org")
                                 ,(concat "* TODO %? \n"
                                          "/Entered on/ %U"))
                                ("T" "Tickler" entry
                                    (file+headine "~/gtd/tickler.org" "Tickler")
                                    "* %i%? \n %U")))
(setq org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t% s")
        (todo   . " %i %-12:c")
        (tags   . " %i %-12:c")
        (search . " %i %-12:c")))
(setq org-refile-targets '((org-agenda-files :maxlevel . 3))) 
(setq org-refile-use-outline-path 'file) 
(setq org-outline-path-complete-in-steps nil)
(define-key org-mode-map (kbd "C-c c") 'ob-sagemath-execute-async))

(setq org-agenda-hide-tags-regexp ".*")

(setq org-agenda-prefix-format
      '((agenda . " %i %?-12t% s")
        (todo . " %i ")
        (tags . " %i ")
        (search . " %i ")))
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
 ; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! evil
  (setq evil-shift-width 2))
(setq evil-want-C-i-jump nil)
(defun repeat-command (proc times)
  (dotimes (_ times)
	(funcall proc)))
(defun my-previous-five-line () ; U = 5u
  (interactive)
  (repeat-command 'evil-previous-line 5))
(defun my-next-five-line ()
  (interactive)
  (repeat-command 'evil-next-line 5))
(setq my-evil-global-binding '(
        ("u" . evil-previous-line)
        ("e" . evil-next-line)
        ("n" . evil-backward-char)
        ("i" . evil-forward-char)
        (",." . evil-jump-item)
        ("U" . my-previous-five-line)
        ("E" . my-next-five-line)
        ("N" . evil-beginning-of-line)
        ("I" . evil-end-of-line)
        ("j" . evil-undo)
        ("l" . evil-insert)
        ("L" . evil-insert-line)
        ("`" . evil-invert-char)
        ("Q" . kill-current-buffer)
        ("M" . execute-extended-command)
        (";" . evil-ex)
        ("h" . evil-forward-word-end)
        ("H" . evil-forward-word-end)
        ("k" . evil-ex-search-next)
        ("K" . evil-ex-search-previous)
        ("C-w u" . evil-window-up)
        ("C-w e" . evil-window-down)
        ("C-w n" . evil-window-left)
        ("C-w i" . evil-window-right)))
(dolist (pair my-evil-global-binding)
    (evil-global-set-key 'normal (kbd (car pair)) (cdr pair))
    (evil-global-set-key 'visual (kbd (car pair)) (cdr pair)))

(set-evil-initial-state! 'vterm-mode 'emacs) ; vterm 下使用 emacs 模式
(set-evil-initial-state! 'dired-mode 'emacs) ;dired 下使用 emacs 模式
(set-evil-initial-state! 'elfeed-search-mode 'emacs) ;elfeed 下使用 emacs 模式
(setq elfeed-org t)

(use-package!
  rime
  :bind (:map rime-mode-map
			  ("C-`" . 'rime-send-keybinding))
  :custom (default-input-method "rime")
  (rime-librime-root "~/.emacs.d/librime/dist")
  :config
  (setq         ;; rime-show-candidate 'posframe ;; 用形码吧
        mode-line-mule-info '((:eval (rime-lighter)))
        rime-inline-ascii-trigger 'shift-l
        rime-inline-ascii-holder ?x
        rime-user-data-dir "~/.emacs.d/Rime"))

(setq org-startup-numerated t)
(use-package! grip-mode  ; 用于在网页端实时预览 markdown、org
  :ensure t
  :config
  (setq grip-preview-use-webkit t))
(use-package! ox-gfm)  ; 预览上色
(use-package! paredit
  :hook ((scheme-mode racket-mode) . paredit-mode))
(use-package! evil-paredit
  :hook ((paredit-mode) . evil-paredit-mode))
(require 'org-tempo)
(setq org-structure-template-alist
      (append org-structure-template-alist
          '(("el" . "src emacs-lisp")
            ("sh" . "src bash")
            ("py" . "src python :results output")
            ("fi" . "src fish")
            ("cc" . "src c")
            ("cp" . "src cpp")
            ("pw" . "src powershell"))))

(after! org
    ;; (add-to-list 'org-preview-latex-process-alist '(xdvsvgm :progams
    ;;                             ("xelatex" "dvisvgm")
    ;;                             :discription "xdv > svg"
    ;;                             :message "you need install the programs: xelatex and dvisvgm."
    ;;                             :image-input-type "xdv"
    ;;                             :image-output-type "svg"
    ;;                             :latex-compiler ("xelatex -interaction nonstopmode -no-pdf -output-directory %o %f")
    ;;                             :image-converter ("dvisvgm %f -n -b min -c %S -o %O")))
  (setq org-latex-default-packages-alist
        (append org-latex-default-packages-alist
                '(("" "multirow" t)("" "ctex" t)))
        org-latex-compiler "xelatex"
        org-format-latex-options (plist-put org-format-latex-options :scale 1.5)
        ;; org-preview-latex-default-process 'xdvsvgm
        ))
(setq org-babel-python-command "/usr/local/Caskroom/miniforge/base/bin/python")
;; (setq org-structure-template-alist '(("n" . "notes")
;;  ("a" . "export ascii")
;;  ("c" . "center")
;;  ("C" . "comment")
;;  ("e" . "example")
;;  ("E" . "export")
;;  ("h" . "export html")
;;  ("l" . "export latex")
;;  ("q" . "quote")
;;  ("s" . "src")
;;  ("v" . "verse")))

(after! cdlatex
  (setq cdlatex-math-symbol-alist
      '((?c ("\\mathcal\{\}" nil nil nil))
        (?o ("\\omega" "\\circ" nil nil)))))

(after! org-roam
  (setq org-roam-completion-everywhere t)
  (setq org-roam-capture-templates
        '(("d" "default" plain
           ""
           :if-new (file+head "%<%Y%m%d%H>-${slug}.org" "#+TITLE: ${title}\n#+FILETAGS: %^{tags}\n")
           :immediate-finish t
           :unnarrowed t)
          ("i" "issues" plain
           "* 环境\n* 报错\n* 原因\n* 解决方法\n* 参见\n "
           :if-new (file+head "%<%Y%m%d%H>-${slug}.org" "#+TITLE: ${title}\n#+FILETAGS: %^{tags}\n")
           :immediate-finish t
           :unnarrowed t)
          ;; ... other templates
          ;; bibliography note template
          ("r" "bibliography reference" plain "%?"
           :if-new (file+head "references/${citekey}.org" "#+TITLE: ${title}\n#+FILETAGS: /cite/")
          :immediate-finish t
          :unnarrowed t)
          ("s" "structure of subjects"
           plain
           "* 基本概念\n* 发展历史\n* 主要流派\n* 基本理念\n* 知识体系\n* 相关资源\n"
           :if-new (file+head "%<%Y%m%d%H>-${slug}.org" "#+TITLE: ${title}\n#+FILETAGS: %^{tags}\n")
           :immediate-finish t
           :unnarrowed t)))
  (require 'org-roam-protocol))

(map! :after org
      :map evil-normal-state-map
      :prefix "SPC n r"
      :desc "Add completion"
      "m" #'completion-at-point)

(map! :after org
      :map evil-normal-state-map
      :prefix "SPC n r"
      :desc "Go to map"
      "G" #'org-roam-ui-open)

(use-package! websocket
    :after org-roam)


(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-database-connector 'sqlite)
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(defun org-summary-todo-after-state-change ()
  "Switch headline to DONE when all subentries are DONE, to TODO otherwise."
  (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
         (parent-end (save-excursion (org-up-heading-safe) (point)))
         (n-done 0)
         (n-not-done 0))
    (save-excursion
      (org-back-to-heading t)
      (org-show-subtree)
      (while (and (< (point) subtree-end)
                  (re-search-forward org-heading-regexp subtree-end t))
        (let ((state (org-get-todo-state)))
          (if (string= state "DONE")
              (setq n-done (1+ n-done))
            (setq n-not-done (1+ n-not-done)))))
    (when (= n-not-done 0)
      (save-excursion
        (goto-char parent-end)
        (org-todo "DONE"))))))

;; (add-hook 'org-after-todo-statistics-hook #'org-summary-todo)
;; (add-hook 'org-after-todo-state-change-hook #'org-summary-todo-after-state-change)

;; (defun org-turn-subentries-to-todo (headline-point)
;;     (save-excursion
;;         (org-map-entries (lambda () (org-todo "TODO")) "/+DONE" 'tree)))

;; (defun org-toggle-subentries-to-todo ()
;;   "Toggle all subentries under a headline to TODO state."
;;   (interactive)
;;   (let ((headline-point (org-get-at-bol 'org-hd-marker)))
;;     (org-turn-subentries-to-todo headline-point)))

(map! :after org :map evil-normal-state-map
      :prefix "SPC m"
      :desc "Toggle subentries to TODO"
      "X" #'org-toggle-subentries-to-todo)


;; (setq org-hierarchical-todo-statistics t)

(use-package! org-ref
  :config
  (setq bibtex-completion-bibliography '("~/Dropbox/emacs/bibliography/references.bib")
  citar-bibliography '("~/Dropbox/emacs/bibliography/references.bib")
	bibtex-completion-library-path '("~/Dropbox/emacs/bibliography/bibtex-pdfs/")
	bibtex-completion-notes-path "~/Dropbox/emacs/bibliography/notes/"
	citar-library-path '("~/Dropbox/emacs/bibliography/bibtex-pdfs/")
	citar-notes-path "~/Dropbox/emacs/bibliography/notes/"
	bibtex-completion-notes-template-multiple-files "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n"

	bibtex-completion-additional-search-fields '(keywords)
	bibtex-completion-display-formats
	'((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
	  (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
	  (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
	  (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
	  (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}"))
	bibtex-completion-pdf-open-function
	(lambda (fpath)
	  (call-process "open" nil 0 nil fpath))))

(use-package! org-roam-bibtex
  :after (org-roam citar-org-rom)
  :config
  (require 'citar-org-roam)
  (citar-register-notes-source
 'orb-citar-source (list :name "Org-Roam Notes"
        :category 'org-roam-node
        :items #'citar-org-roam--get-candidates
        :hasitems #'citar-org-roam-has-notes
        :open #'citar-org-roam-open-note
        :create #'orb-citar-edit-note
        :annotate #'citar-org-roam--annotate))
  (setq citar-notes-source 'orb-citar-source))

(use-package! citar-org-roam
  :after (citar org-roam)
  :config (citar-org-roam-mode))

(map! :after org :map evil-normal-state-map
      :prefix "SPC n e"
      :desc "Insert citation"
      "b" #'citar-insert-citation
      :desc "Open notes"
      "o" #'citar-open-notes
      :desc "Insert reference"
      "r" #'citar-insert-reference
      :desc "Insert node citation"
      "i" #'orb-insert-link)

(setq system-time-locale "zh_CN")
(setq chinese-calendar-celestial-stem
  ["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"])
(setq chinese-calendar-terrestrial-branch
  ["子" "丑" "寅" "卯" "辰" "巳" "午" "未" "申" "酉" "戌" "亥"])
(defvar chinese-shuxiang-name
  ["鼠" "牛" "虎" "兔" "龙" "蛇" "马" "羊" "猴" "鸡" "狗" "猪"])
(nth 5 (decode-time))
(defun chinese-year (year)
  (concat
    (aref chinese-calendar-celestial-stem
            (% (- year 4) 10))
    (aref chinese-calendar-terrestrial-branch
            (% (- year 4) 12))
    (aref chinese-shuxiang-name
            (% (- year 4) 12))
    "年"))
(setq chinese-year-now (chinese-year (nth 5 (decode-time))))
(setq org-journal-file-type 'yearly)
(setq org-journal-file-format (concat "%Y-" chinese-year-now))
(setq org-journal-date-format "%Y/%m/%d W%W D%j（%a）")
(format-time-string "%Y/%m/%d W%W D%j (%a)")

(setq yas-snippet-dirs (append yas-snippet-dirs
                               '("~/.doom.d/snippets")))

(setq lsp-clients-clangd-args '("-j=3"
				"--background-index"
				"--clang-tidy"
				"--completion-style=detailed"
				"--header-insertion=never"
				"--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

;; (setq org-contacts-files "~/org/contacts.org"
(use-package! kbd-mode) ; kmonad
(remove-hook 'doom-first-buffer-hook #'ws-butler-global-mode)
(use-package! hackernews)
(setq company-minimum-prefix-length 6)
(setq rmh-elfeed-org-files (list "~/org/elfeed.org"))
(use-package! oj
  :config (setq oj-default-online-judge 'codeforces)
(setq               oj-home-dir "~/oj")
(quickrun-set-default "c++" "c++/clang++")
(setq                oj-login-args "-u for156th@gmail.com -p Oyzh030725"))
(setq reftex-default-bibliography '("~/Dropbox/emacs/bibliography/references.bib"))
(setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))
(setq cnfonts-personal-fontnames
      '(;;英文字体
        ("Liga SFMono Nerd font")
        ;; 中文字体)
        ("PingFang SC")))
(cnfonts-mode 1)
(global-set-key (kbd "s--") 'cnfonts-decrease-fontsize)
(global-set-key (kbd "s-=") 'cnfonts-increase-fontsize)
(use-package! sage-shell-mode)
(use-package! ob-sagemath
  :config
  (setq org-babel-default-header-args:sage '((:session . t)
                                             (:results . "output"))
        sage-shell::sage-root "/usr/local/bin/sage"
        org-confirm-babel-evaluate nil
        org-export-babel-evaluate nil
        org-startup-with-inline-images t))
(use-package! ob-powershell
  :config
  (add-to-list 'load-path "~/.emacs.d/lisp/ob-powershell"))
(use-package! oz)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
