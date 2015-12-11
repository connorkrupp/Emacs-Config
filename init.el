(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(setq gc-cons-threshold 100000000)
(setq inhibit-startup-message t)

(global-set-key [(control -)] 'undo)
(delete-selection-mode t)
(defalias 'yes-or-no-p 'y-or-n-p)
(custom-set-variables
  '(line-number-mode t))

(defconst package-list
  '(irony
		yasnippet))

(defun install-packages ()
  "Install all required packages."
  (interactive)
  (unless package-archive-contents
    (package-refresh-contents))
  (dolist (package package-list)
    (unless (package-installed-p package)
      (package-install package))))

(install-packages)

(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-irony)

;; Package: yasnippet
(require 'yasnippet)
(yas-global-mode 1)
