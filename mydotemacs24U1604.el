;; -*- emacs-lisp -*-
;; ------------------------------------------------------------
;; Mauro Rovezzi's EMACS config file <mauro.rovezzi@gmail.com>
;; MIT License
;; Current version: optimized for XUbuntu 16.04 (ubox1604)
;; Previous version: mydotemacs (mydotemacs24U1404)
;; ~/.emacs -> ~/devel/software-notes/mydotemacs24U1604
;; ------------------------------------------------------------
;; System packages required:
;; emacs
;; aspell-*
;; ------------------------------------------------------------
;; Local packages/repositories required:
;; ------------------------------------------------------------

;; me
(setq user-full-name "Mauro Rovezzi")
(setq user-mail-address "mauro.rovezzi@gmail.com")

;; add current local dir
;;(add-to-list 'load-path "~/local/emacs/") ;;

;; Start-up options // MISC

;;VISUAL-LINE MODE
;;(setq visual-line-mode t)
;;(global-visual-line-mode 0)
;;(global-visual-line-mode 1); Proper line wrapping
;;(setq adaptive-wrap-prefix-mode t)

;;(global-hl-line-mode 1); Highlight current row
(show-paren-mode 1); Matches parentheses and such in every mode
(setq calendar-week-start-day 1); Calender should start on Monday
(add-to-list 'default-frame-alist '(left . 0)); Default frame position left
(add-to-list 'default-frame-alist '(top . 5)); Default frame position top
(add-to-list 'default-frame-alist '(height . 45)); Default frame window height
(add-to-list 'default-frame-alist '(width . 174)); Default frame window width
(setq echo-keystrokes 0.1)
(setq visible-bell t); Flashes on error
(setq column-number-mode t)

;; Splash Screen
(setq inhibit-splash-screen t); Disable splash screen
(setq initial-scratch-message nil)

;; Scroll bar, Tool bar, Menu bar
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

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

;; -----------------------------------------------------------------------------
;; KEYBOARD SHORTCUTS FOR COMMENTING REGIONS
;; Default is M-;
;; I do not like the default one because I usually select regions with the mouse
;; so I want to comment only with the left hand C-d / C-S-d seems good choice
;; -----------------------------------------------------------------------------
(global-set-key (kbd "C-d") 'comment-region)
(global-set-key (kbd "C-S-d") 'uncomment-region)
;;(global-set-key (kbd "C-;") 'comment-or-uncomment-region)

;; for some reason the Del (backspace) keyword got comment-region, I
;; set to the wanted one
(global-set-key [delete] 'delete-char)
(global-set-key [M-delete] 'kill-word)

;;Key bindings
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-c C-k") 'compile)
(global-set-key (kbd "C-x g") 'magit-status)

;; -----------------------------------------------------------------------------
;; DEFAUTL ENCODING: utf8
;; -----------------------------------------------------------------------------
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; ------------------------------------------------------------
;; COLOR THEME
;; ------------------------------------------------------------
(if window-system
    (load-theme 'wombat t)
  (load-theme 'wombat t))

;; ------------------------------------------------------------
;; SPELL CHECK
;; ------------------------------------------------------------
(setq ispell-program-name "aspell" ispell-extra-args '("--sug-mode=ultra"))
(setq ispell-list-command "--list")
(setq ispell-dictionary "english")

;; Enables Flyspell in text-modes
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(add-hook 'rst-mode-hook
	  (lambda () (flyspell-mode 1))) ;Flyspell in RST

;flyspell in LaTeX
(add-hook 'LaTeX-mode-hook
	  (lambda () (flyspell-mode 1)))
(add-hook 'LaTeX-mode-hook
	  (lambda () (flyspell-buffer 1)))
(setq flyspell-issue-welcome-flag nil) ;; fix flyspell problem

;;; Use Python mode with LARCH files
(add-to-list 'auto-mode-alist '("\\.lar$" . python-mode))

;; --------------------------------------------------------------------------------
;; #### ELPA: Emacs Lisp Package Archive (http://www.emacswiki.org/emacs/ELPA) ####
;; --------------------------------------------------------------------------------
(load "package")
(package-initialize)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
;; *Additional Repositories*
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ;Org-mode

(defvar my_pkgs '(org
		  org-ref
		  ox-mediawiki
		  ox-rst
		  ob-ipython
		  json-mode
		  sphinx-doc
		  sphinx-mode
		  writegood-mode)
  "My default packages")

;; When Emacs boots, check to make sure all of the packages defined in
;; my_pkgs are installed. If not, have ELPA take care of it.
;; (defun maupackages-installed-p ()
;;   (loop for pkg in my_pkgs
;;         when (not (package-installed-p pkg)) do (return nil)
;;         finally (return t)))

;; (unless (maupackages-installed-p)
;;   (message "%s" "Refreshing package database...")
;;   (package-refresh-contents)
;;   (dolist (pkg my_pkgs)
;;     (when (not (package-installed-p pkg))
;;       (package-install pkg))))

;; ------------------------------------------------------------

;; wraps the lines in org-mode
(setq org-startup-truncated nil)

;; org-babel
(require 'ob)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t)
   (python . t)
   (ipython . t)
   (matlab . t)
   (perl . t)
   (dot . t)
   (css . t)
   (gnuplot . t)
   (shell . t)
   (latex . t))
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (json-mode org-ref sphinx-mode sphinx-doc speck org))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
