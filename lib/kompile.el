;;; kompile.el --- compile utility

;; Author: sk
;; Keywords: local

;; Description:
;;
;; 1) when first line matches pattern-one, run first line
;;
;;   1: /* gcc tmp.c && a.out
;;   -> $ gcc tmp.c && a.out
;;
;; 2) when first line matches pattern-two, run second line
;; 
;;   1: #!/bin/bash
;;   2: # bash -x test.sh args
;;   -> $ bash -x test.sh args
;;   note: 'conding:' line will be ignored
;;
;; *) else
;;   search build command and run
;;
;;   1: body
;;   2:    head
;;   -> $ make (rake/ant and so on)
;;

(provide 'kompile)

(defvar kompile-line-patterns-one
      '("^/\\* "
	"^// "
	"^# "
	"^% "
	"^-- "
	"^<!-- "))

(defvar kompile-line-patterns-two
  '("^#!"
    "^# coding:"))

(defvar kompile-command-config-alist
  '(("make" . "Makefile")
    ("rake" . "Rakefile")))

(defun kompile-match-line (patterns)
  (let (line (result nil))
    (save-excursion
      (goto-line 1)
      (setq line (thing-at-point 'line t))
      (dolist (pattern patterns)
	(if (string-match pattern line)
	    (setq result t))))
    result))

(defun kompile-get-command (line-number)
  (save-excursion
    (let (line-string command)
      (goto-line line-number)
      (setq line-string (buffer-substring (point-at-bol) (point-at-eol)))
      (string-match " \\(.+\\)" line-string)
      (if (match-string 1 line-string)
	  (setq command (match-string 1 line-string))
	nil))))

(defun kompile-run-first ()
  (if (kompile-match-line kompile-line-patterns-one)
      (compile (kompile-get-command 1))
    nil))

(defun kompile-run-second ()
  (if (kompile-match-line kompile-line-patterns-two)
      (let (command)
	(setq command (kompile-get-command 2))
	(if (string-match "^coding:" command)
	    (setq command (kompile-get-command 3)))
	(compile command))
    nil))

(defun kompile-get-configs (path)
  (let ((configs '())
        (current-dir path))
    (while (stringp current-dir)
      (dolist (file (directory-files current-dir t))
        (when (file-regular-p file)
          (let ((kv (rassoc (file-name-nondirectory file) kompile-command-config-alist)))
            (if kv
		(add-to-list 'configs (cons (car kv) file))))))
      (setq current-dir (kompile-get-parent-dir-or-nil current-dir)))
    configs))

(defun kompile-get-parent-dir-or-nil (path)
  (let ((current-dir (expand-file-name path))
        (parent-dir (expand-file-name (format "%s/.." path))))
    (if (string= current-dir parent-dir)
        nil
      parent-dir)))

(defun kompile-run-config (&optional path)
  (unless path (setq path "."))
  (let ((configs (kompile-get-configs path)))
    (if configs
        (let* ((kv (car configs))
               (command-string (car kv))
               (save-dir default-directory)
               (dir (file-name-directory (cdr kv))))
          (cd dir)
          (compile command-string t)
          (cd save-dir)
          t)
      nil)))

(defun kompile ()
  (interactive)
  (unless (kompile-run-second)
    (unless (kompile-run-first)
      (unless (kompile-run-config)
	(message "nothing to do")))))

;; (push "DIR" load-path)
;; (require 'kompile)
;; (global-set-key "\M-c" 'kompile)

