;;; for emacs on macosx

;; appearance
(if window-system
    (progn
      (setq initial-frame-alist '(
                                  (width . 140)
                                  (height . 51)
                                  (left . 0)
                                  (top . 75)))
      (set-background-color "LemonChiffon")
      (set-foreground-color "Black")))

;; ignore icon of visible-bell
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; backslash
(define-key global-map [?¥] [?\\])

;; default directory
(setq default-directory "~/")
(setq command-line-default-directory "~/")


;; Fonts
;; (let* ((size 15)
;;        (asciifont "Ricty")
;;        (jpfont "Ricty")
;;        (h (* size 10))
;;        (fontspec (font-spec :family asciifont))
;;        (jp-fontspec (font-spec :family jpfont)))
;;   (set-face-attribute 'default nil :family asciifont :height h)
;;   (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
;;   (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
;;   (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
;;   (set-fontset-font nil '(#x0080 . #x024F) fontspec) 
;;   (set-fontset-font nil '(#x0370 . #x03FF) fontspec))

(when (and (>= emacs-major-version 24) (not (null window-system)))
  (let* ((font-family "Menlo")
         (font-size 9)
         (font-height (* font-size 13))
         (jp-font-family "ヒラギノ角ゴ ProN"))
    (set-face-attribute 'default nil :family font-family :height font-height)
    (let ((name (frame-parameter nil 'font))
          (jp-font-spec (font-spec :family jp-font-family))
          (jp-characters '(katakana-jisx0201
                           cp932-2-byte
                           japanese-jisx0212
                           japanese-jisx0213-2
                           japanese-jisx0213.2004-1))
          (font-spec (font-spec :family font-family))
          (characters '((?\u00A0 . ?\u00FF)    ; Latin-1
                        (?\u0100 . ?\u017F)    ; Latin Extended-A
                        (?\u0180 . ?\u024F)    ; Latin Extended-B
                        (?\u0250 . ?\u02AF)    ; IPA Extensions
                        (?\u0370 . ?\u03FF)))) ; Greek and Coptic
      (dolist (jp-character jp-characters)
        (set-fontset-font name jp-character jp-font-spec))
      (dolist (character characters)
        (set-fontset-font name character font-spec))
      (add-to-list 'face-font-rescale-alist (cons jp-font-family 1.2)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ auctex

(setq TeX-default-mode 'japanese-latex-mode)
(setq japanese-LaTeX-command-default "pLaTeX")
(setq japanese-LaTeX-default-style "jsarticle")
(setq TeX-output-view-style '(("^dvi$" "." "xdvi '%d'")))
(setq preview-image-type 'dvipng)
(setq TeX-file-extensions '("tex" "sty" "cls" "ltx" "texi" "texinfo" "dtx"))
(setq LaTeX-clean-intermediate-suffixes '("\\.aux" "\\.log" "\\.out" "\\.toc" "\\.brf" "\\.nav" "\\.snm"))
(setq TeX-view-program-list '(("TeXShop" "open -a TeXShop.app %o")
                              ("open" "open %o")
                              ))
(setq TeX-view-program-selection '((output-pdf "TeXShop")
                                   (output-html "open")
                                   ))
(add-hook 'LaTeX-mode-hook (function (lambda ()
  (add-to-list 'TeX-command-list
    '("pLaTeX" "%(PDF)platex %`%S%(PDFout)%(mode)%' %t"
     TeX-run-TeX nil (latex-mode) :help "Run ASCII pLaTeX"))
  (add-to-list 'TeX-command-list
    '("dvi" "dvipdfmx -V 4 '%s' " TeX-run-command t nil))
  (add-to-list 'TeX-command-list
    '("pdf" "open -a TeXShop.app '%s.pdf' " TeX-run-command t nil))
  (add-to-list 'TeX-command-list
    ; '("xxx" "%(PDF)platex %`%S%(PDFout)%(mode)%' %t && dvipdfmx -V 4 '%s' && open -a TeXShop.app '%s.pdf' "
    '("up" "%(PDF)uplatex %`%S%(PDFout)%(mode)%' %t && dvipdfmx -V 4 '%s' && open -a Skim.app '%s.pdf' "
      TeX-run-TeX nil (latex-mode) :help "Run ASCII pLaTeX" TeX-run-command TeX-run-command))
  (add-to-list 'TeX-command-list
    ; '("xxx" "%(PDF)platex %`%S%(PDFout)%(mode)%' %t && dvipdfmx -V 4 '%s' && open -a TeXShop.app '%s.pdf' "
    '("pl" "%(PDF)platex %`%S%(PDFout)%(mode)%' %t && dvipdfmx -V 4 '%s' && open -a Skim.app '%s.pdf' "
      TeX-run-TeX nil (latex-mode) :help "Run ASCII pLaTeX" TeX-run-command TeX-run-command))
)))
(setq kinsoku-limit 10)
(setq LaTeX-indent-level 4)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin/"))  
(setq exec-path (append exec-path '("/Library/TeX/texbin/")))
