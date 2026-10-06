# Emacs-init
some basic emacs configuration

# Cloning and keeping up to date

To setup the init file with git so that it can be updated easily, I normally run the following commands while in the .emacs.d directory:

git init .

git remote add -t \* -f origin <repository-url>

git checkout master

## Pasteable init.el (may not be latest version)

``` emacs lisp
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
;; (package-initialize)

;; Other package sources to try and help install themes (or other stuff)
;; failed on windows, check out https://github.com/mswift42/warm-night-theme
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

;; ;; 2019-11-23
;; ;; python 3 by default
;; ;; https://stackoverflow.com/questions/11071701/python-3-in-emacs
;; (setq py-python-command "python3")
;; ;; change default interpreter to python3
;; (defcustom python-shell-interpreter "python3"
;;   "Default Python interpreter for shell."
;;   :type 'string
;;   :group 'python)
;; ;; Command to change it back at will:
;; ;; M-x customize-variable [RET] python-shell-interpreter [RET]

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(ispell-program-name "/usr/bin/ispell")
 '(package-selected-packages '(rust-mode ## go-mode k8s-mode dockerfile-mode docker)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; major mode for R scripts
(use-package ess)
```
