;;;; -*- mode: emacs-lisp; coding: iso-2022-7bit -*-
;;;;
;;;; Copyright (C) 2001 The Meadow Team

;; Author: Koichiro Ohba <koichiro@meadowy.org>
;;      Kyotaro HORIGUCHI <horiguti@meadowy.org>
;;      Hideyuki SHIRAI <shirai@meadowy.org>
;;      KOSEKI Yoshinori <kose@meadowy.org>
;;      and The Meadow Team.


;; ;;; Mule-UCS $B$N@_Dj(B
;; ;; ftp://ftp.m17n.org/pub/mule/Mule-UCS/ $B$,(B $B%*%U%#%7%c%k%5%$%H$G$9$,!"(B
;; ;; http://www.meadowy.org/~shirai/elisp/mule-ucs.tar.gz $B$K4{CN$N%Q%C%A(B
;; ;; $B$r$9$Y$FE,MQ$7$?$b$N$,$*$$$F$"$j$^$9!#(B
;; ;; (set-language-environment) $B$NA0$K@_Dj$7$^$9(B
;; (require 'jisx0213)


;;; $BF|K\8l4D6-@_Dj(B
(set-language-environment "Japanese")

;;; IME$B$N@_Dj(B
(mw32-ime-initialize)
(setq default-input-method "MW32-IME")
(setq-default mw32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator-list '("[--]" "[$B$"(B]" "[--]"))
(add-hook 'mw32-ime-on-hook
          (function (lambda () (set-cursor-height 2))))
(add-hook 'mw32-ime-off-hook
          (function (lambda () (set-cursor-height 4))))


;; ;;; $B%+!<%=%k$N@_Dj(B
;; ;; (set-cursor-type 'box)            ; Meadow-1.10$B8_49(B (SKK$BEy$G?'$,JQ$k@_Dj(B)
;; ;; (set-cursor-type 'hairline-caret) ; $B=DK@%-%c%l%C%H(B


;;; $B%^%&%9%+!<%=%k$r>C$9@_Dj(B
(setq w32-hide-mouse-on-key t)
(setq w32-hide-mouse-timeout 5000)


;;; font-lock$B$N@_Dj(B
(global-font-lock-mode t)


;; ;;; TrueType $B%U%)%s%H@_Dj(B
;; (w32-add-font
;;  "private-fontset"
;;  '((spec
;;     ((:char-spec ascii :height 120)
;;      strict
;;      (w32-logfont "Courier New" 0 -13 400 0 nil nil nil 0 1 3 49))
;;     ((:char-spec ascii :height 120 :weight bold)
;;      strict
;;      (w32-logfont "Courier New" 0 -13 700 0 nil nil nil 0 1 3 49))
;;     ((:char-spec ascii :height 120 :slant italic)
;;      strict
;;      (w32-logfont "Courier New" 0 -13 400 0   t nil nil 0 1 3 49))
;;     ((:char-spec ascii :height 120 :weight bold :slant italic)
;;      strict
;;      (w32-logfont "Courier New" 0 -13 700 0   t nil nil 0 1 3 49))
;;     ((:char-spec japanese-jisx0208 :height 120)
;;      strict
;;      (w32-logfont "$B#M#S(B $B%4%7%C%/(B" 0 -16 400 0 nil nil nil 128 1 3 49))
;;     ((:char-spec japanese-jisx0208 :height 120 :weight bold)
;;      strict
;;      (w32-logfont "$B#M#S(B $B%4%7%C%/(B" 0 -16 700 0 nil nil nil 128 1 3 49)
;;      ((spacing . -1)))
;;     ((:char-spec japanese-jisx0208 :height 120 :slant italic)
;;      strict
;;      (w32-logfont "$B#M#S(B $B%4%7%C%/(B" 0 -16 400 0   t nil nil 128 1 3 49))
;;     ((:char-spec japanese-jisx0208 :height 120 :weight bold :slant italic)
;;      strict
;;      (w32-logfont "$B#M#S(B $B%4%7%C%/(B" 0 -16 700 0   t nil nil 128 1 3 49)
;;      ((spacing . -1))))))

;; (set-face-attribute 'variable-pitch nil :family "*")


;; ;;; BDF $B%U%)%s%H@_Dj(B
;;
;; ;;; ($BJ}K!$=$N(B1) Netinstall $B%Q%C%1!<%8$r;H$&J}K!(B
;; ;;; misc $B$H(B intlfonts $B%Q%C%1!<%8$rF~$l$^$9!#(B
;; ;;; .emacs$B$N@_Dj(B
;; (setq bdf-use-intlfonts16 t)
;; (setq initial-frame-alist '((font . "intlfonts16")))
;;
;; ;;; ($BJ}K!$=$N(B1') 
;; ;;; intlfonts-file-16dot-alist $B$N7A<0$G(B bdf-fontset-alist $B$r=q$-!"(B
;; ;;; $B<!$r@_Dj$9$l$PNI$$!#(B
;; ;;;  (require 'bdf)
;; ;;;  (bdf-configure-fontset "bdf-fontset" bdf-fontset-alist)
;; ;;; $B>\:Y$O(B $MEADOW/pkginfo/auto-autoloads.el $B$H(B $MEADOW/site-lisp/bdf.el $B$r(B
;; ;;; $B;2>H$N$3$H!#(B
;;
;; ;;; ($BJ}K!$=$N(B2) 
;; ;;; $B%U%)%s%H$N;XDjJ}K!$O<!$N%5%s%W%k$r;29M$K$9$k!#(B
;; ;;; normal, bold, italic, bold-itaric $B%U%)%s%H$r;XDj$9$kI,MW$"$j!#(B
;; (setq bdf-font-directory "c:/Meadow/fonts/intlfonts/")
;; (w32-add-font "bdf-fontset"
;; `((spec 
;;    ;; ascii
;;    ((:char-spec ascii :height any :weight normal :slant normal)
;;     strict (bdf-font ,(expand-file-name "lt1-16-etl.bdf" bdf-font-directory)))
;;    ((:char-spec ascii :height any :weight bold :slant normal)
;;     strict (bdf-font ,(expand-file-name "lt1-16b-etl.bdf" bdf-font-directory)))
;;    ((:char-spec ascii :height any :weight normal :slant any)
;;     strict (bdf-font ,(expand-file-name "lt1-16i-etl.bdf" bdf-font-directory)))
;;    ((:char-spec ascii :height any :weight bold :slant any)
;;     strict (bdf-font ,(expand-file-name "lt1-16bi-etl.bdf" bdf-font-directory)))
;;    ;; katakana-jisx0201
;;    ((:char-spec katakana-jisx0201 :height any :weight normal :slant normal)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))
;;     ((encoding . 1-byte-set-msb))) 
;;    ((:char-spec katakana-jisx0201 :height any :weight bold :slant normal)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))
;;     ((encoding . 1-byte-set-msb))) 
;;    ((:char-spec katakana-jisx0201 :height any :weight normal :slant any)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))
;;     ((encoding . 1-byte-set-msb))) 
;;    ((:char-spec katakana-jisx0201 :height any :weight bold :slant any)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))
;;     ((encoding . 1-byte-set-msb)))
;;    ;; latin-jisx0201
;;    ((:char-spec latin-jisx0201 :height any :weight normal :slant normal)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory)))
;;    ((:char-spec latin-jisx0201 :height any :weight bold :slant normal)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory)))
;;    ((:char-spec latin-jisx0201 :height any :weight normal :slant any) 
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))) 
;;    ((:char-spec latin-jisx0201 :height any :weight bold :slant any) 
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory)))
;;    ;; japanese-jisx0208
;;    ((:char-spec japanese-jisx0208 :height any :weight normal :slant normal) 
;;     strict (bdf-font ,(expand-file-name "j90-16.bdf" bdf-font-directory)))
;;    ((:char-spec japanese-jisx0208 :height any :weight bold :slant normal)
;;     strict (bdf-font ,(expand-file-name "j90-16.bdf" bdf-font-directory))) 
;;    ((:char-spec japanese-jisx0208 :height any :weight normal :slant any)
;;     strict (bdf-font ,(expand-file-name "j90-16.bdf" bdf-font-directory)))
;;    ((:char-spec japanese-jisx0208 :height any :weight bold :slant any)
;;     strict (bdf-font ,(expand-file-name "j90-16b.bdf" bdf-font-directory))))))

;; $B=i4|%U%l!<%`$N@_Dj(B
(setq default-frame-alist
      (append (list '(foreground-color . "black")
                    '(background-color . "LemonChiffon")
                    '(background-color . "gray")
                    '(border-color . "black")
                    '(mouse-color . "white")
                    '(cursor-color . "black")
                    ;;      '(ime-font . (w32-logfont "$B#M#S(B $B%4%7%C%/(B"
                    ;;           0 16 400 0 nil nil nil
                    ;;           128 1 3 49)) ; TrueType $B$N$_(B
                    ;;      '(font . "bdf-fontset")    ; BDF
                    ;;      '(font . "private-fontset"); TrueType
                    '(width . 100)
                    '(height . 40)
                    '(top . 0)
                    '(left . 50))
              default-frame-alist))


;; ;;; shell $B$N@_Dj(B

;; ;;; Cygwin $B$N(B bash $B$r;H$&>l9g(B
(setq explicit-shell-file-name "bash")
(setq shell-file-name "sh")
(setq shell-command-switch "-c") 

;; ;;; Virtually UN*X!$B$K$"$k(B tcsh.exe $B$r;H$&>l9g(B
;; (setq explicit-shell-file-name "tcsh.exe") 
;; (setq shell-file-name "tcsh.exe") 
;; (setq shell-command-switch "-c") 

;; ;;; WindowsNT $B$KIUB0$N(B CMD.EXE $B$r;H$&>l9g!#(B
;; (setq explicit-shell-file-name "CMD.EXE") 
;; (setq shell-file-name "CMD.EXE") 
;; (setq shell-command-switch "\\/c") 


;;; argument-editing $B$N@_Dj(B
(require 'mw32script)
(mw32script-init)


;; ;;; browse-url $B$N@_Dj(B
;; (global-set-key [S-mouse-2] 'browse-url-at-mouse)


;; ;;; $B0u:~$N@_Dj(B
;; ;; $B$3$N@_Dj$G(B M-x print-buffer RET $B$J$I$G$N0u:~$,$G$-$k$h$&$K$J$j$^$9(B
;; ;;
;; ;;  notepad $B$KM?$($k%Q%i%a!<%?$N7A<0$N@_Dj(B
;; (define-process-argument-editing "notepad"
;;   (lambda (x) (general-process-argument-editing-function x nil t)))
;;
;; (defun w32-print-region (start end
;;       &optional lpr-prog delete-text buf display
;;       &rest rest)
;;   (interactive)
;;   (let ((tmpfile (convert-standard-filename (buffer-name)))
;;     (w32-start-process-show-window t)
;;     ;; $B$b$7!"(Bdos $BAk$,8+$($F$$$d$J?M$O>e5-$N(B `t' $B$r(B `nil' $B$K$7$^$9(B
;;     ;; $B$?$@$7!"(B`nil' $B$K$9$k$H(B Meadow $B$,8G$^$k4D6-$b$"$k$+$b$7$l$^$;$s(B
;;     (coding-system-for-write w32-system-coding-system))
;;     (while (string-match "[/\\]" tmpfile)
;;   (setq tmpfile (replace-match "_" t nil tmpfile)))
;;     (setq tmpfile (expand-file-name (concat "_" tmpfile "_")
;;            temporary-file-directory))
;;     (write-region start end tmpfile nil 'nomsg)
;;     (call-process "notepad" nil nil nil "/p" tmpfile)
;;     (and (file-readable-p tmpfile) (file-writable-p tmpfile)
;;      (delete-file tmpfile))))
;; 
;; (setq print-region-function 'w32-print-region)

;; ;;; fakecygpty $B$N@_Dj(B
;; ;; $B$3$N@_Dj$G(B cygwin $B$N2>A[C<Kv$rMW5a$9$k%W%m%0%i%`$r(B Meadow $B$+$i(B
;; ;; $B07$($k$h$&$K$J$j$^$9(B
;; (setq mw32-process-wrapper-alist
;;       '(("/\\(bash\\|tcsh\\|svn\\|ssh\\|gpg[esvk]?\\)\\.exe" .
;;    (nil . ("fakecygpty.exe" . set-process-connection-type-pty)))))

;;;
;;; end of file
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sk

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
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(mapc
 (lambda (f)
   (autoload f
     "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
             howm-list-grep howm-create
             howm-keyword-to-kill-ring))
;; $B%j%s%/$r(B TAB $B$GC)$k(B
(eval-after-load "howm-mode"
  '(progn
     (define-key howm-mode-map [tab] 'action-lock-goto-next-link)
     (define-key howm-mode-map [(meta tab)] 'action-lock-goto-previous-link)))
;; $B!V:G6a$N%a%b!W0lMw;~$K%?%$%H%kI=<((B
(setq howm-list-recent-title t)
;; $BA4%a%b0lMw;~$K%?%$%H%kI=<((B
(setq howm-list-all-title t)
;; $B%a%K%e!<$r(B 2 $B;~4V%-%c%C%7%e(B
(setq howm-menu-expiry-hours 2)
;; howm $B$N;~$O(B auto-fill $B$G(B
(add-hook 'howm-mode-on-hook 'auto-fill-mode)
;; RET $B$G%U%!%$%k$r3+$/:](B, $B0lMw%P%C%U%!$r>C$9(B
;; C-u RET $B$J$i;D$k(B
(setq howm-view-summary-persistent nil)
;; $B%a%K%e!<$NM=DjI=$NI=<(HO0O(B
;; 10 $BF|A0$+$i(B
(setq howm-menu-schedule-days-before 10)
;; 3 $BF|8e$^$G(B
(setq howm-menu-schedule-days 3)
;; howm $B$N%U%!%$%kL>(B
;; $B0J2<$N%9%?%$%k$N$&$A$I$l$+$rA*$s$G$/$@$5$$(B
;; $B$G!$ITMW$J9T$O:o=|$7$F$/$@$5$$(B
;; 1 $B%a%b(B 1 $B%U%!%$%k(B ($B%G%U%)%k%H(B)
;;(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.howm")
;; 1 $BF|(B 1 $B%U%!%$%k$G$"$l$P(B
(setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")
(setq howm-file-name-format "%Y/%m/%Y%m%d.rd")
;; $BI=<(%U%!%$%k8!:wMQ$N@55,I=8=(B
(setq howm-view-grep-parse-line
      "^\\(\\([a-zA-Z]:/\\)?[^:]*\\.howm\\):\\([0-9]*\\):\\(.*\\)$")
;; $B8!:w$7$J$$%U%!%$%k$N@55,I=8=(B
(setq
 howm-excluded-file-regexp
 "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")
;; $B$$$A$$$A>C$9$N$bLLE]$J$N$G(B
;; $BFbMF$,(B 0 $B$J$i%U%!%$%k$4$H:o=|$9$k(B
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
;; C-cC-c $B$GJ]B8$7$F%P%C%U%!$r%-%k$9$k(B
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
 ;; $B%a%K%e!<$r<+F099?7$7$J$$(B
(setq howm-menu-refresh-after-save nil)
;; $B2<@~$r0z$-D>$5$J$$(B
(setq howm-refresh-after-save nil)

;;  auctex
(load "auctex.el" nil t t)
(setq TeX-default-mode 'japanese-latex-mode)
(setq japanese-TeX-command-default "pTeX")
(setq japanese-LaTeX-command-default "pLaTeX")
(setq japanese-LaTeX-default-style "jsarticle")
(setq kinsoku-limit 10)
;(setq TeX-output-view-style '(("^dvi$" "." "c:/w32tex/dviout/dviout.exe %d")))
;(setq TeX-command-list
;      (append (list (list "View" "dviout %s.dvi" 'TeX-run-command t nil)) TeX-command-list))
(setq TeX-output-view-style '(("^pdf$" "." "c:/Program Files (x86)/Adobe/Reader 9.0/Reader/AcroRd32.exe %o")))
(setq preview-auto-cache-preamble nil)
;(setq preview-auto-cache-preamble t)

;; w3m
(require 'w3m-load)
;;(require 'mime-w3m)
(global-set-key "\C-c3" 'w3m)
(setq w3m-search-default-engine "google")
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "w" 'dired-w3m-find-file)))
(defun dired-w3m-find-file ()
  (interactive)
  (require 'w3m)
  (let ((file (dired-get-filename)))
    (w3m-find-file file)))

;; navi2ch
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)

;; $B=*N;;~$KK,$M$J$$(B
(setq navi2ch-ask-when-exit nil)
;; $B%9%l$N%G%U%)%k%HL>$r;H$&(B
(setq navi2ch-message-user-name "")
;; $B$"$\!<$s$,$"$C$?$?$-85$N%U%!%$%k$OJ]B8$7$J$$(B
(setq navi2ch-net-save-old-file-when-aborn nil)
;; $BAw?.;~$KK,$M$J$$(B
(setq navi2ch-message-ask-before-send nil)
;; kill $B$9$k$H$-$KK,$M$J$$(B
(setq navi2ch-message-ask-before-kill nil)
;; $B%P%C%U%!$O(B 5 $B$D$^$G(B
(setq navi2ch-article-max-buffers 5)
;; navi2ch-article-max-buffers $B$rD6$($?$i8E$$%P%C%U%!$O>C$9(B
(setq navi2ch-article-auto-expunge t)
;; Board $B%b!<%I$N%l%9?tMs$K%l%9$NA}2C?t$rI=<($9$k!#(B
(setq navi2ch-board-insert-subject-with-diff t)
;; Board $B%b!<%I$N%l%9?tMs$K%l%9$NL$FI?t$rI=<($9$k!#(B
(setq navi2ch-board-insert-subject-with-unread t)
;; $B4{FI%9%l$O$9$Y$FI=<((B
(setq navi2ch-article-exist-message-range '(1 . 1000))
;; $BL$FI%9%l$b$9$Y$FI=<((B
(setq navi2ch-article-new-message-range '(1000 . 1))
;; 3 $B%Z%$%s%b!<%I$G$_$k(B
(setq navi2ch-list-stay-list-window t)
;; C-c 2 $B$G5/F0(B
(global-set-key "\C-c2" 'navi2ch)

(setq navi2ch-mona-enable t)
(add-hook 'navi2ch-mona-load-hook
          (lambda ()
            (set-face-attribute 'navi2ch-mona-face nil :family "Mona")))
;;            (set-face-attribute 'navi2ch-mona-face nil :family "Mona $BI8=`(B")))
;;            (set-face-attribute 'navi2ch-mona-face nil :family "$B%b%J!<(B")))
;;            (set-face-attribute 'navi2ch-mona-face nil :family "IPA $B%b%J!<(B $BL@D+(B")))
;; (add-hook 'navi2ch-mona-load-hook
;;           (lambda ()
;;             (set-face-attribute 'navi2ch-mona-face nil :family "MS P $B%4%7%C%/(B")))

;; coding system

(prefer-coding-system 'utf-8-unix)
(setq default-file-name-coding-system 'shift_jis) ;for dired

(cd "~")
