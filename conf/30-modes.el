;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ coffee
(add-hook 'coffee-mode-hook
	  '(lambda()
	     (and (set (make-local-variable 'tab-width) 2)
		  (set (make-local-variable 'coffee-tab-width) 2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ cpp
(add-hook 'c++-mode-hook
	  '(lambda()
	     (and (set (make-local-variable 'tab-width) 2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ css
(add-hook 'css-mode-hook
              (lambda ()
                (setq css-indent-offset 2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ feature

(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ feature

(require 'gdscript-mode)
(add-to-list 'auto-mode-alist '("\.tscn$" . gdscript-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ howm
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(mapc
 (lambda (f)
   (autoload f
     "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
             howm-list-grep howm-create
             howm-keyword-to-kill-ring))
;; リンクを TAB で辿る
(eval-after-load "howm-mode"
  '(progn
     (define-key howm-mode-map [tab] 'action-lock-goto-next-link)
     (define-key howm-mode-map [(meta tab)] 'action-lock-goto-previous-link)))
;; 「最近のメモ」一覧時にタイトル表示
(setq howm-list-recent-title t)
;; 全メモ一覧時にタイトル表示
(setq howm-list-all-title t)
;; メニューを 2 時間キャッシュ
(setq howm-menu-expiry-hours 2)
;; howm の時は auto-fill で
(add-hook 'howm-mode-on-hook 'auto-fill-mode)
;; RET でファイルを開く際, 一覧バッファを消す
;; C-u RET なら残る
(setq howm-view-summary-persistent nil)
;; メニューの予定表の表示範囲
;; 10 日前から
(setq howm-menu-schedule-days-before 10)
;; 3 日後まで
(setq howm-menu-schedule-days 3)
;; howm のファイル名
;; 以下のスタイルのうちどれかを選んでください
;; で，不要な行は削除してください
;; 1 メモ 1 ファイル (デフォルト)
;;(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.howm")
;; 1 日 1 ファイルであれば
(setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")
(setq howm-file-name-format "%Y/%m/%Y%m%d.rd")
;; 表示ファイル検索用の正規表現
(setq howm-view-grep-parse-line
      "^\\(\\([a-zA-Z]:/\\)?[^:]*\\.howm\\):\\([0-9]*\\):\\(.*\\)$")
;; 検索しないファイルの正規表現
(setq
 howm-excluded-file-regexp
 "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")
;; いちいち消すのも面倒なので
;; 内容が 0 ならファイルごと削除する
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'delete-file-if-no-contents after-save-hook)))
(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (string-match "\\.howm" (buffer-file-name (current-buffer)))
         (= (point-min) (point-max)))
    (delete-file
     (buffer-file-name (current-buffer)))))
;; http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi?SaveAndKillBuffer
;; C-cC-c で保存してバッファをキルする
(defun my-save-and-kill-buffer ()
  (interactive)
  (when (and
         (buffer-file-name)
;;         (string-match "\\.howm"
         (string-match "\\.rd"
                       (buffer-file-name)))
    (save-buffer)
    (kill-buffer nil)))
(eval-after-load "howm"
  '(progn
     (define-key howm-mode-map
       "\C-c\C-c" 'my-save-and-kill-buffer)))
;; メニューを自動更新しない
(setq howm-menu-refresh-after-save nil)
;; 下線を引き直さない
(setq howm-refresh-after-save nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ js-mode
(add-hook 'js-mode-hook '(lambda ()
			   (lambda ()
			     (setq js-indent-level 2)
			     (setq indent-tabs-mode nil))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ org-mode

(setq org-directory "~/Dropbox/org")
(setq org-agenda-files (list "~/Dropbox/org"))
(global-set-key "\C-cc" 'org-capture)
(setq org-capture-templates
      '(
	("t" "todo" entry (file+headline "~/Dropbox/org/todo.org" "Inbox")
         "** %T %?\n ")
	("j" "journal" entry (file+headline "~/Dropbox/org/journal.org" "Inbox")
         "** %T %?\n ")
	("n" "note" entry (file+headline "~/Dropbox/org/note.org" "Inbox")
         "** %T %?\n ")
	("m" "memo" entry (file+headline "~/Dropbox/org/memo.org" "Inbox")
         "** %T %?\n ")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ php
(add-hook 'php-mode-hook (lambda () (require 'php-align) (php-align-setup)))
(add-hook 'php-mode-hook
	  '(lambda ()
	     (define-key c-mode-base-map "\C-ca" 'align-current)))
(add-hook 'php-mode-hook '(lambda ()
			    (setq tab-width 4
				  indent-tabs-mode t)))
(defadvice align-current (around indent-tabs-mode activate)
  "Let align-current indent with spaces."
  (when indent-tabs-mode (setq indent-tabs-mode nil))
  ad-do-it)

(add-to-list 'auto-mode-alist (cons "\\.tpl\\'" 'php-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ rinari
(require 'rinari)
(global-rinari-mode)
(setq rinari-rails-env "development")
;(setq rinari-rails-env "production")
(add-hook 'compilation-shell-minor-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'compilation-minor-mode-hook 'ansi-color-for-comint-mode-on)
(setq ruby-insert-encoding-magic-comment nil)

(defun rinari-local-hook ()
  (setq inf-ruby-prompt-format
	(concat
	 (mapconcat
	  #'identity
	  '("\\(^%s> *\\)"                      ; Simple
	    "\\(^(rdb:1) *\\)"                  ; Debugger
	    "\\(^(byebug) *\\)"                 ; byebug
	    "\\(^\\(irb([^)]+)"                 ; IRB default
	    "\\([[0-9]+] \\)?[Pp]ry ?([^)]+)"   ; Pry
	    "\\(jruby-\\|JRUBY-\\)?[1-9]\\.[0-9]\\(\\.[0-9]+\\)*\\(-?p?[0-9]+\\)?" ; RVM
	    "[0-9]+\\.[0-9]+\\(\\.[0-9]+\\)*-rc[0-9]+"; @ RVM with rc version
	    "^rbx-head\\)")                     ; RVM continued
	  "\\|")
	 ;; Statement and nesting counters, common to the last four.
	 " ?[0-9:]* ?%s *\\)"))
  (setq inf-ruby-first-prompt-pattern (format inf-ruby-prompt-format ">" ">"))
  (setq inf-ruby-prompt-pattern (format inf-ruby-prompt-format "[?>]" "[\]>*\"'/`]")))

(add-hook 'inf-ruby-mode-hook 'rinari-local-hook)
	  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ ruby
;; re-order smaps and solve conflict of anthy japanese input and ruby-mode.
(let ((rel (assq 'ruby-electric-mode minor-mode-map-alist)))
  (setq minor-mode-map-alist (append (delete rel minor-mode-map-alist) (list rel))))
(add-to-list 'auto-mode-alist (cons "\\.schema\\'" 'ruby-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ shell
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; (defun set-exec-path-from-shell-PATH ()
;;   "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.
;; This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
;;   (interactive)
;;   (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
;;     (setenv "PATH" path-from-shell)
;;     (setq exec-path (split-string path-from-shell path-separator))))
;; (set-exec-path-from-shell-PATH)

(add-hook 'comint-output-filter-functions
           'comint-watch-for-password-prompt)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ web-mode
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-hook 'web-mode-hook
          '(lambda ()
             (setq web-mode-attr-indent-offset nil)
             (setq web-mode-markup-indent-offset 2)
             (setq web-mode-css-indent-offset 2)
             (setq web-mode-code-indent-offset 2)
             (setq web-mode-sql-indent-offset 2)
             (setq indent-tabs-mode nil)
             (setq tab-width 2)
	     (setq web-mode-script-padding 2)
	     (setq web-mode-style-padding 2)
	     (setq web-mode-block-padding 2)
          ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; autoinsert

(auto-insert-mode t)
(setq auto-insert-directory "~/.emacs.d/skel/")
(setq auto-insert-query nil)
(setq auto-insert-alist
      (append '((c-mode  . "skel.c")
                (c++-mode . "skel.cpp")
                (makefile-mode . "skel.make")
                (bsdmakefile-mode . "skel.make")
                (feature-mode . "skel.feature")
                (gnumakefile-mode . "skel.make")
		(php-mode . "skel.php")
                ;(sql-mode . "skel.sql")
                ;(ruby-mode . "skel.rb")
                (shell-script-mode . "skel.sh")
                (".dat"  . "skel.dat")
                ("deb"  . "skel.gdb"))
              auto-insert-alist))

