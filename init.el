;; Move customize config out of init.el
(setq custom-file (concat user-emacs-directory "customize-init.el"))
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))


;; Load org file config
(org-babel-load-file (concat user-emacs-directory "config.org"))
