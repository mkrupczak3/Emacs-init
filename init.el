;; Basics
(set-face-attribute 'default nil :height 140)
(setq-default visible-bell 1)
(setq-default indent-tabs-mode nil)
(setq-default show-paren-mode 1)
(if window-system (tool-bar-mode 0))
(if (boundp 'aquamacs-version) (tabbar-mode 0))
(setq-default linum-format "%4d ")
(set-scroll-bar-mode 'right)
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(setq-default visual-line-fringe-indicators '(nil nil))
(setq-default word-wrap t)
(setq-default column-number-mode t)
(show-paren-mode 1)
(delete-selection-mode 1)
(setq-default ispell-program-name "/usr/local/bin/ispell")
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; UTF-8 everywhere
(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)

;; linum-mode everywhere, except where it doesn't belong
(require 'linum)
(setq linum-disabled-modes-list '(eshell-mode
                                  wl-summary-mode
                                  compilation-mode
                                  dired-mode
                                  speedbar-mode
                                  doc-view-mode))
(defun linum-on ()
  (unless (or (minibufferp)
              (member major-mode linum-disabled-modes-list)
            (and (not (eq (buffer-name) "*scratch*"))
                 (string-match "*" (buffer-name))))
    (linum-mode 1)))
(global-linum-mode 1)
(setq linum-eager nil)

;; Keybindings
(global-set-key (kbd "M-j") 'join-line)
(global-set-key (kbd "M-g") 'goto-line)
;; Web browser esque switching tabs
(global-set-key (kbd "<C-tab>") 'next-buffer)
(global-set-key (kbd "<backtab>") 'previous-buffer)

;; From http://www.emacswiki.org/emacs/SmoothScrolling
;; Scroll one line at a time (less "jumpy" than defaults)
(setq-default mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq-default mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq-default mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq-default scroll-step 1) ;; keyboard scroll one line at a time

;; Account for size of gutter and fringes
(add-to-list 'initial-frame-alist '(width . 88))
(add-to-list 'default-frame-alist '(width . 88))

;; MELPA stuff to try and help install flycheck (or other stuff)
(require 'package)

(add-to-list 'package-archives
             '("MELPA Stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; Other package sources to try and help install themes (or other stuff)
;; failed on windows, check out https://github.com/mswift42/warm-night-theme
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)


;; ;; 2017-10-28
;; ;; Flycheck stuff
;; ;; Not officially supported on Windows
;; ;; Requires Node.js and NPM
;; ;; requires JSLinter
;; ;; npm install jslinter -g
;; (require 'json)
;; (require 'flycheck)
;; (defun my-parse-jslinter-warning (warning)
;;   (flycheck-error-new
;;    :line (1+ (cdr (assoc 'line warning)))
;;    :column (1+ (cdr (assoc 'column warning)))
;;    :message (cdr (assoc 'message warning))
;;    :level 'error
;;    :buffer (current-buffer)
;;    :checker 'javascript-jslinter))
;; (defun jslinter-error-parser (output checker buffer)
;;   (mapcar 'parse-jslinter-warning
;;           (cdr (assoc 'warnings (aref (json-read-from-string output) 0)))))
;; (flycheck-define-checker javascript-jslinter
;;   "A JavaScript syntax and style checker based on JSLinter.

;; See URL `https://github.com/tensor5/JSLinter'."
;;   :command ("c:/Users/matth/AppData/Roaming/npm/node_modules/jslinter/jslint" "--raw" source)
;;   :error-parser jslinter-error-parser
;;   :modes (js-mode js2-mode js3-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; 2017-12-16
;; Attempting to have some kind of night mode
;; (load-library "color-theme")
;; (color-theme-select)
;; (defun toggle-night-color-theme ()
;;   "Switch to/from night color scheme."
;;   (interactive)
;;   (require 'color-theme)
;;   (if (eq (frame-parameter (next-frame) 'background-mode) 'dark)
;;       (color-theme-snapshot) ; restore default (light) colors
;;     ;; create the snapshot if necessary
;;     (when (not (commandp 'color-theme-snapshot))
;;       (fset 'color-theme-snapshot (color-theme-make-snapshot)))
;;     (color-theme-dark-laptop)))

;; (global-set-key (kbd "<f9> n") 'toggle-night-color-theme)

;; 2019-02-27
;; Attempting to install pdf-tools
;; https://github.com/politza/pdf-tools
;; May only work on linux
(pdf-tools-install)


;; ;; 2019-04-17
;; ;; DEPRECATED, best to use plink on windows instead, e.g. :
;; ;; C-x C-f /plink:user@host:/path/to/file
;;
;; ;; Failed attempt to get broken ssh tramp working on windows
;; (add-to-list 'load-path
;;  (expand-file-name "c:/Program Files/PuTTY/plink.exe"))
;; (require 'tramp)
;; ;(setq tramp-chunksize "500")
;; (setq tramp-default-method "plink")

;; Set default python indentation
(setq python-indent-offset 4)

;; 2019-04-17
;; AUCTex tex mode config
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
;(setq TeX-PDF-mode t)

;; 2019-11-23
;; Elpy python IDE for emacs installation
(use-package elpy
  :ensure t
  :init
  (elpy-enable))
