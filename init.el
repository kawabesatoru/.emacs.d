;;
;; init.el
;;

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lib"))

;;; @@ pakacge
;; M-x package-list-packages
;; M-x package-list-packages-no-fetch
;; M-x package-refresh-contents
;; M-x package-install PKGNAME

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t) ; melpa
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t) ; melpa stble
; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t) ; marmalade
(package-initialize)
;; (package-refresh-contents)

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/conf")

;; (setq indent-tabs-mode nil)

;; ツールバーを非表示
(tool-bar-mode -1)
;; メニューバーを非表示
(menu-bar-mode -1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; automatically added by package manager, don't remove

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js-indent-level 2)
 '(package-selected-packages
   '(gdscript-mode web-mode-edit-element org feature-mode gherkin-mode rinari yaml-mode slim-mode sass-mode php-mode lua-mode json-mode js2-mode web-mode howm haml-mode less-css-mode auctex init-loader coffee-mode ruby-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
