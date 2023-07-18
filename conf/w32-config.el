;;; w32-config.el

(global-set-key "\C-h" 'help-for-help)

;; japanese

(set-default-font "ＭＳ ゴシック-10.5")
(add-hook 'set-language-environment-hook 
          (lambda ()
            (when (equal "ja_JP.UTF-8" (getenv "LANG"))
              (setq default-process-coding-system '(utf-8 . utf-8))
              (setq default-file-name-coding-system 'utf-8))
            (when (equal "Japanese" current-language-environment)
              (setq default-buffer-file-coding-system 'iso-2022-jp))))
(set-language-environment "Japanese")

(setq default-input-method "W32-IME")
(w32-ime-initialize)
(setq-default mw32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
(setq w32-ime-buffer-switch-p t)

;; coding system

;(prefer-coding-system 'utf-8-unix)
;(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;(setq default-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-16le-dos)
(setq shell-mode-hook
      (function (lambda()
                  (set-buffer-process-coding-system 'utf-8-unix
                                                    'utf-8-unix))))

(setq default-file-name-coding-system 'japanese-shift-jis-dos) ; for dired japanese file name.

;; default frame

(setq default-frame-alist
      (append (list '(foreground-color . "black")
                    '(background-color . "LemonChiffon")
                    '(background-color . "gray")
                    '(border-color . "black")
                    '(mouse-color . "white")
                    '(cursor-color . "black")
                    ;;      '(ime-font . (w32-logfont "ＭＳ ゴシック"
                    ;;           0 16 400 0 nil nil nil
                    ;;           128 1 3 49)) ; TrueType のみ
                    ;;      '(font . "bdf-fontset")    ; BDF
                    ;;      '(font . "private-fontset"); TrueType
                    '(width . 120)
                    '(height . 45)
                    '(top . 0)
                    '(left . 50))
              default-frame-alist))

;; shell
(setq explicit-shell-file-name "bash")
(setq shell-file-name "sh")
(setq shell-command-switch "-c")

;; fiber
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map
              "z" 'dired-fiber-find)))
(defun dired-fiber-find ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (file-directory-p file)
        (start-process "explorer" "diredfiber" "explorer.exe"
                       (unix-to-dos-filename file))
      (start-process "fiber" "diredfiber" "fiber.exe" file))))

;; howm
(add-to-load-path "~/.emacs.d/howm-1.4.0rc2/lisp/howm")
(require 'howm)
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
;(setq howm-file-name-format "%Y/%m/%Y%m%d.rd")
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

;;
;; AUCTeX for windows
;;

(add-to-list 'load-path "~/.emacs.d/elisp/auctex/")
(load "auctex.el" nil t t)
;(load "preview-latex.el" nil t t)

(setq TeX-default-mode 'japanese-latex-mode)
(setq japanese-LaTeX-default-style "jsarticle")
(setq TeX-engine-alist '((ptex "pTeX" "eptex -kanji=utf8 -guess-input-enc" "platex -kanji=utf8 -guess-input-enc" "eptex")
                         (jtex "jTeX" "jtex" "jlatex" nil)
                         (uptex "upTeX" "euptex -kanji=utf8 -no-guess-input-enc" "uplatex -kanji=utf8 -no-guess-input-enc" "euptex")))
(setq TeX-engine 'ptex)
(setq TeX-view-program-list '(("dviout" "C:/w32tex/dviout/dviout -1 %d")
                              ("TeXworks" "texworks %o")
                              ("SumatraPDF" "if exist \"C:/Program Files/SumatraPDF/SumatraPDF.exe\" (\"C:/Program Files/SumatraPDF/SumatraPDF\" -reuse-instance %o -forward-search \"%b\" %n) else (\"C:/Program Files (x86)/SumatraPDF/SumatraPDF\" -reuse-instance %o -forward-search \"%b\" %n)")
                              ("fwdsumatrapdf" "C:/w32tex/NDde/Binary/fwdsumatrapdf %o \"%b\" %n")
                              ("Chrome" "powershell -Command \"& {$s = echo %o;$p = [System.IO.Path]::GetFullPath($s);rundll32 shell32,ShellExec_RunDLL \"$env:LOCALAPPDATA/Google/Chrome/Application/chrome.exe\" --new-window $p}\"")
                              ("pdfopen" "pdfopen --rxi --file %o")))
(setq TeX-view-program-selection '((output-dvi "dviout")
                                   (output-pdf "TeXworks")))
(setq preview-image-type 'dvipng)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook
          (function (lambda ()
                      (add-to-list 'TeX-command-list
                                   '("Latexmk" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde --rxi & latexmk %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk1" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde --rxi & latexmk -e \"$latex=q/platex\"\" \"\"-kanji=utf8\"\" \"\"-guess-input-enc\"\" \"\"%S\"\" \"\"%(mode)/\"\"\" -e \"$bibtex=q/pbibtex\"\" \"\"-kanji=utf8/\"\"\" -e \"$makeindex=q/mendex\"\" \"\"-U/\"\"\" -e \"$dvipdf=q/dvipdfmx\"\" \"\"%%O\"\" \"\"-o\"\" \"\"%%D\"\" \"\"%%S/\"\"\" -norc -gg -pdfdvi %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk1"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk2" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde --rxi & latexmk -e \"$latex=q/platex\"\" \"\"-kanji=utf8\"\" \"\"-guess-input-enc\"\" \"\"%S\"\" \"\"%(mode)/\"\"\" -e \"$bibtex=q/pbibtex\"\" \"\"-kanji=utf8/\"\"\" -e \"$makeindex=q/mendex\"\" \"\"-U/\"\"\" -e \"$dvips=q/dvips\"\" \"\"%%O\"\" \"\"-z\"\" \"\"-f\"\" \"\"%%S\"\" \"\"|\"\" \"\"convbkmk\"\" \"\"-g\"\" \"\">\"\" \"\"%%D/\"\"\" -e \"$ps2pdf=q/ps2pdf.bat\"\" \"\"%%O\"\" \"\"%%S\"\" \"\"%%D/\"\"\" -norc -gg -pdfps %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk2"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk3" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde --rxi & latexmk -e \"$latex=q/uplatex\"\" \"\"-kanji=utf8\"\" \"\"-no-guess-input-enc\"\" \"\"%S\"\" \"\"%(mode)/\"\"\" -e \"$bibtex=q/upbibtex/\" -e \"$makeindex=q/mendex\"\" \"\"-U/\"\"\" -e \"$dvipdf=q/dvipdfmx\"\" \"\"%%O\"\" \"\"-o\"\" \"\"%%D\"\" \"\"%%S/\"\"\" -norc -gg -pdfdvi %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk3"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk4" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde --rxi & latexmk -e \"$latex=q/uplatex\"\" \"\"-kanji=utf8\"\" \"\"-no-guess-input-enc\"\" \"\"%S\"\" \"\"%(mode)/\"\"\" -e \"$bibtex=q/upbibtex/\" -e \"$makeindex=q/mendex\"\" \"\"-U/\"\"\" -e \"$dvips=q/dvips\"\" \"\"%%O\"\" \"\"-z\"\" \"\"-f\"\" \"\"%%S\"\" \"\"|\"\" \"\"convbkmk\"\" \"\"-u\"\" \"\">\"\" \"\"%%D/\"\"\" -e \"$ps2pdf=q/ps2pdf.bat\"\" \"\"%%O\"\" \"\"%%S\"\" \"\"%%D/\"\"\" -norc -gg -pdfps %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk4"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk5" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde --rxi & latexmk -e \"$pdflatex=q/pdflatex\"\" \"\"%S\"\" \"\"%(mode)/\"\"\" -e \"$bibtex=q/bibtex/\" -e \"$makeindex=q/makeindex/\" -norc -gg -pdf %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk5"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk6" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde --rxi & latexmk -e \"$pdflatex=q/lualatex\"\" \"\"%S\"\" \"\"%(mode)/\"\"\" -e \"$bibtex=q/bibtexu/\" -e \"$makeindex=q/texindy/\" -norc -gg -pdf %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk6"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk7" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde --rxi & latexmk -e \"$pdflatex=q/xelatex\"\" \"\"%S\"\" \"\"%(mode)/\"\"\" -e \"$bibtex=q/bibtexu/\" -e \"$makeindex=q/texindy/\" -norc -gg -xelatex %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk7"))
                      (add-to-list 'TeX-command-list
                                   '("pdfpLaTeX" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde --rxi & platex -kanji=utf8 -guess-input-enc %S %(mode) -jobname=%s %t && dvipdfmx %d"
                                     TeX-run-TeX nil (latex-mode) :help "Run pLaTeX and dvipdfmx"))
                      (add-to-list 'TeX-command-list
                                   '("pdfpLaTeX2" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde --rxi & platex -kanji=utf8 -guess-input-enc %S %(mode) -jobname=%s %t && dvips -Ppdf -z -f %d | convbkmk -g > %f && ps2pdf.bat %f"
                                     TeX-run-TeX nil (latex-mode) :help "Run pLaTeX, dvips, and ps2pdf"))
                      (add-to-list 'TeX-command-list
                                   '("pdfupLaTeX" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde --rxi & uplatex -kanji=utf8 -no-guess-input-enc %S %(mode) %t && dvipdfmx %d"
                                     TeX-run-TeX nil (latex-mode) :help "Run upLaTeX and dvipdfmx"))
                      (add-to-list 'TeX-command-list
                                   '("pdfupLaTeX2" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde --rxi & uplatex -kanji=utf8 -no-guess-input-enc %S %(mode) %t && dvips -Ppdf -z -f %d | convbkmk -u > %f && ps2pdf.bat %f"
                                     TeX-run-TeX nil (latex-mode) :help "Run upLaTeX, dvips, and ps2pdf"))
                      (add-to-list 'TeX-command-list
                                   '("pBibTeX" "pbibtex -kanji=utf8 %s"
                                     TeX-run-BibTeX nil t :help "Run pBibTeX"))
                      (add-to-list 'TeX-command-list
                                   '("upBibTeX" "upbibtex %s"
                                     TeX-run-BibTeX nil t :help "Run upBibTeX"))
                      (add-to-list 'TeX-command-list
                                   '("BibTeXu" "bibtexu %s"
                                     TeX-run-BibTeX nil t :help "Run BibTeXu"))
                      (add-to-list 'TeX-command-list
                                   '("Mendex" "mendex -U %s"
                                     TeX-run-command nil t :help "Create index file with mendex"))
                      (add-to-list 'TeX-command-list
                                   '("TeXworks" "texworks %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run TeXworks"))
                      (add-to-list 'TeX-command-list
                                   '("SumatraPDF" "if exist \"C:/Program Files/SumatraPDF/SumatraPDF.exe\" (echo \"C:/Program Files/SumatraPDF/SumatraPDF\" -reuse-instance %o -forward-search \"%b\" %n) else (echo \"C:/Program Files (x86)/SumatraPDF/SumatraPDF\" -reuse-instance %o -forward-search \"%b\" %n) | sed -e \"s/\\.dvi/\\.pdf/\" | cmd"
                                     TeX-run-discard-or-function t t :help "Forward search with SumatraPDF"))
                      (add-to-list 'TeX-command-list
                                   '("fwdsumatrapdf" "C:/w32tex/NDde/Binary/fwdsumatrapdf %s.pdf \"%b\" %n"
                                     TeX-run-discard-or-function t t :help "Forward search with SumatraPDF"))
                      (add-to-list 'TeX-command-list
                                   '("Chrome" "powershell -Command \"& {$s = echo %s.pdf;$p = [System.IO.Path]::GetFullPath($s);rundll32 shell32,ShellExec_RunDLL \"$env:LOCALAPPDATA/Google/Chrome/Application/chrome.exe\" --new-window $p}\""
                                     TeX-run-discard-or-function t t :help "Run Chrome PDF Viewer"))
                      (add-to-list 'TeX-command-list
                                   '("pdfopen" "pdfopen --rxi --file %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run Adobe Reader")))))

;;
;; RefTeX with AUCTeX
;;
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;;
;; kinsoku.el
;;
(setq kinsoku-limit 10)


(setq BibTeX-file-extensions '("bib"))


;; w3m
;;
;; emacs-w3m 1.4.4 doesn't support emacs24
;;
;(require 'w3m-load)
;;(require 'mime-w3m)
;;(global-set-key "\C-c3" 'w3m)
;; (setq w3m-search-default-engine "google")
;; (add-hook 'dired-mode-hook
;;           (lambda ()
;;             (define-key dired-mode-map "w" 'dired-w3m-find-file)))
;; (defun dired-w3m-find-file ()
;;   (interactive)
;;   (require 'w3m)
;;   (let ((file (dired-get-filename)))
;;     (w3m-find-file file)))

;; navi2ch
;(add-to-load-pathn "c:/meadow/site-lisp/navi2ch")
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)
;; 終了時に訪ねない
(setq navi2ch-ask-when-exit nil)
;; スレのデフォルト名を使う
(setq navi2ch-message-user-name "")
;; あぼーんがあったたき元のファイルは保存しない
(setq navi2ch-net-save-old-file-when-aborn nil)
;; 送信時に訪ねない
(setq navi2ch-message-ask-before-send nil)
;; kill するときに訪ねない
(setq navi2ch-message-ask-before-kill nil)
;; バッファは 5 つまで
(setq navi2ch-article-max-buffers 5)
;; navi2ch-article-max-buffers を超えたら古いバッファは消す
(setq navi2ch-article-auto-expunge t)
;; Board モードのレス数欄にレスの増加数を表示する。
(setq navi2ch-board-insert-subject-with-diff t)
;; Board モードのレス数欄にレスの未読数を表示する。
(setq navi2ch-board-insert-subject-with-unread t)
;; 既読スレはすべて表示
(setq navi2ch-article-exist-message-range '(1 . 1000))
;; 未読スレもすべて表示
(setq navi2ch-article-new-message-range '(1000 . 1))
;; 3 ペインモードでみる
(setq navi2ch-list-stay-list-window t)
;; C-c 2 で起動
(global-set-key "\C-c2" 'navi2ch)

(setq navi2ch-mona-enable t)
(add-hook 'navi2ch-mona-load-hook
          (lambda ()
            (set-face-attribute 'navi2ch-mona-face nil :family "Mona")))
;;            (set-face-attribute 'navi2ch-mona-face nil :family "Mona 標準")))
;;            (set-face-attribute 'navi2ch-mona-face nil :family "モナー")))
;;            (set-face-attribute 'navi2ch-mona-face nil :family "IPA モナー 明朝")))
;; (add-hook 'navi2ch-mona-load-hook
;;           (lambda ()
;;             (set-face-attribute 'navi2ch-mona-face nil :family "MS P ゴシック")))


(cd "~")

