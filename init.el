(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(setq gc-cons-threshold 100000000)
(setq inhibit-startup-message t)

(global-set-key [(control -)] 'undo)
(delete-selection-mode t)
(defalias 'yes-or-no-p 'y-or-n-p)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(custom-set-variables
  '(line-number-mode t))

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


(defconst package-list
  '(irony
    flycheck
    atom-one-dark-theme
    atom-dark-theme
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

;; check OS type
(cond
 ((string-equal system-type "darwin") ; Mac OS X
  (progn
    (load-theme 'atom-dark t)))
 ((string-equal system-type "gnu/linux") ; linux
  (progn
    (load-theme 'atom-one-dark t))))

(add-to-list 'load-path "~/.emacs.d/custom/")

;;(require 'setup-irony)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; Setup flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Package: yasnippet
(require 'yasnippet)
(yas-global-mode 1)
