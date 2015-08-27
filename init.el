(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

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

(setq custom-file "~/.emacs.d/customize-init.el")

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

;; no tabs
(setq-default indent-tabs-mode nil)

;;line numbers

(use-package smartparens
  :ensure t 
  :demand t
  :diminish smartparens-mode
  :config
  (require 'smartparens-config)
  (smartparens-global-mode t))

(use-package undo-tree
  :ensure t
  :demand t
  :diminish undo-tree-mode
  :config 
  (global-undo-tree-mode)) ;;explore more settings 

;;japanese input
(use-package mozc
  :config
  (setq default-input-methond "japanese-mozc"
	mozc-candidate-style 'overlay))

(use-package dired+ :ensure t)

(use-package magit :ensure t)

;;auto completion
(use-package company-c-headers :ensure t)

(use-package company-auctex
             :ensure t
             :init(company-auctex-init))

(use-package company-jedi :ensure t)
(use-package company-web :ensure t)
(use-package company-ghc :ensure t)
(use-package company-ghci :ensure t)

(use-package company
             :ensure t
             :demand t
             :diminish company-mode
             :config
             (global-company-mode )
;             (add-hook 'after-init-hook 'global-company-mode)
             (add-to-list 'company-backends '(company-c-headers))
             (add-to-list 'company-backends '(company-auctex))
             (add-to-list 'company-backends '(company-jedi))
             (add-to-list 'company-backends '(company-web-html))
             (add-to-list 'company-backends '(company-web-jade))
             (add-to-list 'company-backends '(company-web-slim))
             (add-to-list 'company-backends '(company-ghc))
             (add-to-list 'company-backends '(company-ghci))
             )

;;lisp
(use-package adjust-parens
             :ensure t
             :config
             (local-set-key (kbd "TAB") 'lisp-indent-adjust-parens);for terminal?
             (local-set-key (kbd "<backtab>") 'lisp-dedent-adjust-parens))

(use-package pretty-lambdada
  :ensure t
  :init
  (global-pretty-lambda-mode))

;;helm
(use-package helm
  :ensure t
  :diminish helm-mode
  :config
  (require 'helm-config)
  (setq helm-quick-update t
	helm-M-x-requires-pattern nil
	helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match t
	helm-M-x-fuzzy-match t)
  (helm-mode)
  (helm-adaptative-mode 1)
  :bind
  (("C-h a" . helm-apropos)
   ("C-x C-b" . helm-buffers-list)
   ("M-y" . helm-show-kill-ring)
   ("M-x" . helm-M-x)
   ("C-x c o" . helm-occur)
   ("C-x c y" . helm-yas-complete)
   ("C-x c SPC" . helm-all-mark-rings))
  :config
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent acgtion
(define-key helm-map (kbd "C-z") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-i")  'helm-select-action)) ; list action

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



;;python

;;(use-package ein :ensure t) look into ob-ipython
(use-package jedi
	     :ensure t
	     :config
	     (add-hook 'python-mode-hook 'jedi:setup)
	     (setq jedi:complete-on-dot))
(use-package pydoc-info :ensure t) ; :load-path "/path/to/pydoc-info")
(use-package matlab-mode :ensure t)

;;web-mode
(use-package web-mode
	     :ensure t
	     :config
	     (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
             (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
	     (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
             (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
             (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
             (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
             (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
             (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
             (setq web-mode-engines-alist '(("django" . "\\.html\\'")))
                          (defun my-web-mode-hook ()
	       "Hooks for Web mode."
	       (setq web-mode-markup-indent 2)
	       (setq web-mode-css-indent-offset 2)
	       (setq web-mode-code-indent-offset 2)
	       (setq web-mode-enable-css-colorization t)
	       (setq web-mode-enable-block-face t)
	       (setq web-mode-enable-part-face t)
	       (setq web-mode-enable-heredoc-fontification t)
	       (setq web-mode-enable-current-element-highlight t)
	       (setq web-mode-enable-current-column-highlight t)
	       ;(setq web-mode-enable-auto-pairing t)
	       )	       
	     (add-hook 'web-mode-hook 'my-web-mode-hook))










;;theme
(use-package mode-icons
             :ensure t
             :demand t
             :init
             (mode-icons-mode))
(use-package base16-theme :ensure t)
(use-package nyan-mode
             :ensure t
             :demand t
             :init
             
             (nyan-mode)
             (add-hook 'eshell-load-hook 'nyan-prompt-enable))

(load "~/.emacs.d/customize-init.el")
