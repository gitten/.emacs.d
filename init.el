(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(setq custom-file (concat user-emacs-directory "init-customize.el"))
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))


;; Load org file config
(org-babel-load-file (concat user-emacs-directory "init-config.org"))
