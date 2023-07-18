;; for linux

;; $ sudo yum install epel-release
;; $ sudo yum install emacs-anthy
;; default key bind is C-\ 

(defvar local-anthy-dir "/usr/share/emacs/site-lisp/anthy")

;;(if (file-directory-p local-anthy-dir)
(if nil
    (progn
      (add-to-list 'load-path local-anthy-dir)
      (require 'anthy)
      (load-library "anthy")
      (set-language-environment "Japanese")
      (set-input-method nil)
      
      (set-terminal-coding-system 'utf-8)
      (set-keyboard-coding-system 'utf-8)
      (set-buffer-file-coding-system 'utf-8)
      (setq default-buffer-file-coding-system 'utf-8)
      (prefer-coding-system 'utf-8)
      (set-default-coding-systems 'utf-8)
      (setq file-name-coding-system 'utf-8)
      ;; (set-input-method nil)
      ;; (setq default-input-method "japanese-anthy")

      (defun anthy-change-hankaku-kana-map (key str)
	(anthy-send-map-edit-command 5 key str))

      (anthy-change-hankaku-kana-map "[" "｢")
      (anthy-change-hankaku-kana-map "]" "｣")
      (anthy-change-hankaku-kana-map "." "｡")
      (anthy-change-hankaku-kana-map "," "､")
      (anthy-change-hankaku-kana-map "-" "ｰ")))

;; eof
 
