;; interaction

(transient-mark-mode t)
(setq visible-bell t)
(show-paren-mode)
(global-set-key "\M-g" 'goto-line)

;; bars

(if window-system
  (progn (tool-bar-mode 0)
	 (scroll-bar-mode 0))
  (menu-bar-mode 0))

;; mode lines

(column-number-mode t)
(line-number-mode t)
(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time-mode t)
;; (defun count-lines-and-chars ()
;;   (if mark-active
;;       (format "%d lines, %d chars "
;;               (count-lines (region-beginning) (region-end))
;;               (- (region-end) (region-beginning)))
;;     ""))
;; (add-to-list 'default-mode-line-format
;;             '(:eval (count-lines-and-chars)))
(setq-default tab-width 8)

;; dired

(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(setq dired-dwim-target t)
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; supress warning
(setq byte-compile-warnings '(not cl-functions obsolete))
