(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (setq use-package-verbose t)
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

(use-package cl-generic :ensure t)


(use-package paradox :ensure t)
;(load "~/.emacs.d/.paradox-token.el")

(setq custom-file "~/.emacs.d/customize.el")

(setq backup-directory-alist '((".*" . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;read further in www.wisdomandwonder.com/worpress/wp-content/uploads/2014/03/C3F.html -via sachachua.com
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
	search-ring
	regexp-search-ring))

;;interface
(menu-bar-showhide-tool-bar-menu-customize-disable)
(scroll-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)

;line numbers

(use-package smartparens
  :ensure t 
  :demand t
  :config
  (require 'smartparens-config)
  (smartparens-global-mode t))

(use-package undo-tree
  :ensure t
  :demand t
  :config 
  (global-undo-tree-mode)) ;;explore more settings 

;;japanese input
(use-package mozc
  :config
  (setq default-input-methond "japanese-mozc"
	mozc-candidate-style 'overlay))

(use-package dired+ :ensure t)

;;helm
(use-package helm
  :ensure t
  :diminish helm-mode
  :init
  (require 'helm-config)
  (setq helm-quick-update t
	helm-M-x-requires-pattern nil
	helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match t
	helm-M-x-fuzzy-match t)
  (helm-mode)
  :bind (("C-h a" . helm-apropos)
	 ("C-x C-b" . helm-buffers-list)
	 ("M-y" . helm-show-kill-ring)
	 ("M-x" . helm-M-x)
	 ("C-x c o" . helm-occur)
	 ("C-x c y" . helm-yas-complete)
	 ("C-x c SPC" . helm-all-mark-rings)
	 ))
(use-package helm-descbinds
  :ensure t
  :init
  (helm-descbinds-mode))
; also explore helm-swoop

;;pdf and epub tools

;;the org
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-html-checkbox-type 'unicode)
(setq org-html-checkbox-types
 '((unicode (on . "<span class=\"task-done\">&#x2611;</span>")
            (off . "<span class=\"task-todo\">&#x2610;</span>")
            (trans . "<span class=\"task-in-progress\">[-]</span>"))))


(use-package ox-reveal
	     :ensure t
	     :config
	     (setq org-reveal-root "file:///home/plaintext/reveal.js"))

(use-package org-bullets
	     :ensure t
	     :init
	     (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
;;theme
(use-package base16-theme :ensure t)
(use-package nyan-mode :ensure t :demand t);Demand the NYAN!!
(load "~/.emacs.d/customize.el")

;;python

(use-package ein :ensure t)
(use-package jedi
	     :ensure t
	     :config
	     (add-hook 'python-mode-hook 'jedi:setup)
	     (setq jedi:complete-on-dot))
(use-package pydoc-info
	     :ensure t
	     :load-path "/path/to/pydoc-info")
(use-package matlab :ensure t)
