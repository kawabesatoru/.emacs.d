;;; rinari-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "rinari" "rinari.el" (23250 48397 990812 237000))
;;; Generated autoloads from rinari.el

(autoload 'rinari-launch "rinari" "\
Call function `rinari-minor-mode' if inside a rails project.
Otherwise, disable that minor mode if currently enabled.

\(fn)" t nil)

(autoload 'rinari-minor-mode "rinari" "\
Enable Rinari minor mode to support working with the Ruby on Rails framework.

\(fn &optional ARG)" t nil)

(defvar global-rinari-mode nil "\
Non-nil if Global Rinari mode is enabled.
See the `global-rinari-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-rinari-mode'.")

(custom-autoload 'global-rinari-mode "rinari" nil)

(autoload 'global-rinari-mode "rinari" "\
Toggle Rinari minor mode in all buffers.
With prefix ARG, enable Global Rinari mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Rinari minor mode is enabled in all buffers where
`rinari-launch-maybe' would do it.
See `rinari-minor-mode' for more information on Rinari minor mode.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; rinari-autoloads.el ends here
