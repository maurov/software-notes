;; ================================================
;; Mauro's Emacs configuration for Python & friends
;; ================================================

;; CHANGELOG
;; ---------

;; - [2019-09-25] merged useful settings from `mydotemacsU1804`
;; - [2019-09-24] remove elpy -> eglot (python language server)
;; - [2019-09-10] magit entry point + tracked at `sofware-notes`
;; - [2019-09-08] started from https://realpython.com/emacs-the-best-python-editor/

;; INSTALL PACKAGES
;; ----------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    ein  ;; Emacs ipython notebook
    flycheck
    json-mode
    sphinx-doc
    sphinx-mode
    writegood-mode
    magit
    material-theme
    yaml-mode))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; (require 'use-package)


;; -------------------
;; BASIC CUSTOMIZATION
;; -------------------

;; me
(setq user-full-name "Mauro Rovezzi")
(setq user-mail-address "mauro.rovezzi@gmail.com")

(setq inhibit-startup-message t) ;; hide the startup message
(global-linum-mode t) ;; enable line numbers globally

;; DEFAUTL ENCODING: utf8
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; COLOR THEME
(if window-system
    (load-theme 'material t)
  (load-theme 'wombat t))

;; Frame title showing current file name and [directory]
;;http://www.emacswiki.org/emacs/FrameTitle
(setq frame-title-format
      '((:eval (if (buffer-file-name)
		   (file-name-nondirectory (abbreviate-file-name (buffer-file-name)))
		 "%b"))
	(:eval (if (buffer-modified-p)
		   " *"))
	("  [")
	(:eval (if (buffer-file-name)
		   (file-name-directory (abbreviate-file-name (buffer-file-name)))
		 " %b"))
	("]  ")
	)
      )

;; CUA-mode and rectagular editing (C-RET)
;;(setq cua-enable-cua-keys nil) ;only for rectangles
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

;; KEYBOARD SHORTCUTS
(global-set-key (kbd "C-d") 'comment-region)
(global-set-key (kbd "C-S-d") 'uncomment-region)

;; SPELL CHECK
(setq ispell-program-name "aspell" ispell-extra-args '("--sug-mode=ultra"))
(setq ispell-list-command "--list")
(setq ispell-dictionary "english")

;; Enables Flyspell in text-modes
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(add-hook 'rst-mode-hook
	  (lambda () (flyspell-mode 1))) ;Flyspell in RST

;; flyspell in LaTeX
(add-hook 'LaTeX-mode-hook
	  (lambda () (flyspell-mode 1)))
(add-hook 'LaTeX-mode-hook
	  (lambda () (flyspell-buffer 1)))
(setq flyspell-issue-welcome-flag nil) ;; fix flyspell problem

;; Use Python mode with LARCH files
(add-to-list 'auto-mode-alist '("\\.lar$" . python-mode))

;; AUCTeX (from Emacs wiki)
;; (setq TeX-auto-save t)
;; (setq TeX-parse-self t)
;; (setq-default TeX-master nil)

;; (add-hook 'LaTeX-mode-hook 'visual-line-mode)
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; (setq reftex-plug-into-AUCTeX t)

;; org-babel
(require 'ob)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (ditaa . t)
   (python . t)
   (matlab . t)
   (perl . t)
   (dot . t)
   (css . t)
   (gnuplot . t)
   (latex . t))
 )


;; MAGIT
;; -----
(global-set-key (kbd "C-x g") 'magit-status)

;; YAML
;; ----
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; ===================


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (auctex eglot yaml-mode py-autopep8 material-theme magit flycheck elpy ein better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
