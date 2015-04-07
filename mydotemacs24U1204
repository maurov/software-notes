;; -*- emacs-lisp -*-
;; ------------------------------------------------------------
;; Mauro Rovezzi's EMACS config file <mauro.rovezzi@gmail.com>
;; MIT License
;; Current version: optimized for XUbuntu 12.04 (annarella)
;; Previous version: mydotemacs (ubumaus1204)
;; ~/.emacs -> ~/utils/software-notes/mydotemacs24U1204
;; ------------------------------------------------------------
;; System packages required:
;; emacs24 emacs24-el emacs24-common-non-dfsg (Damien Cassou PPA)
;; fonts-inconsolata
;; aspell-*
;; ------------------------------------------------------------
;; Local packages/repositories required:
;; naquadah-theme (http://git.naquadah.org/git/naquadah-theme.git)
;; ------------------------------------------------------------

;; ------------------------------------------------------------
;; SEE ALSO:
;; http://www.aaronbedra.com/emacs.d/
;; ------------------------------------------------------------

;; me
(setq user-full-name "Mauro Rovezzi")
(setq user-mail-address "mauro.rovezzi@gmail.com")

;; add current local dir
(add-to-list 'load-path "~/local/emacs/") ;; 

;; Start-up options
;; Splash Screen
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; Scroll bar, Tool bar, Menu bar
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;;Marking text
(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)

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

;; Misc
(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)
(show-paren-mode t)
(setq column-number-mode t)

;; -----------------------------------------------------------------------------
;; DEFAUTL ENCODING: utf8
;; -----------------------------------------------------------------------------
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; ------------------------------------------------------------
;; COLOR THEME
;; ------------------------------------------------------------
(add-to-list 'load-path "~/local/emacs/naquadah-theme/") ; color theme
(if window-system
    ;;(load-theme 'solarized-dark t)
    ;;(load-theme 'wombat t)
    (load-library "naquadah-theme")
  (load-theme 'wombat t))

;; FONT
(set-frame-font "Inconsolata-12") ;set default font

;; CUA-mode and rectagular editing (C-RET)
;;(setq cua-enable-cua-keys nil) ;only for rectangles
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

;; SPELL CHECK
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

;; WORD WRAP AT SPECIFIC COLUMN NUMBER
;; from: http://stackoverflow.com/questions/8772488/emacs-word-wrap-at-specific-column-number
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook
	  '(lambda() (set-fill-column 80)))
(add-hook 'latex-mode-hook 'turn-on-auto-fill)
(add-hook 'latex-mode-hook
	  '(lambda() (set-fill-column 80)))

;;; Use Python mode with LARCH files
(add-to-list 'auto-mode-alist '("\\.lar$" . python-mode))

;; ------------------------------------------------------------
;; LATEX-AUCTEX
;; http://emacswiki.org/emacs/AUCTeX
;; ------------------------------------------------------------
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
;;(setq TeX-PDF-mode t)
(setq-default TeX-master nil)

;;(add-hook 'LaTeX-mode-hook 'visual-line-mode)
;;(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;;(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;;(setq reftex-plug-into-AUCTeX t)

;; ------------------------------------------------------------
;; ORG-MODE
;; ------------------------------------------------------------
;; spell check
(add-hook 'org-mode-hook
          (lambda ()
            (flyspell-mode)))

; error in emacs23
;(add-hook 'org-mode-hook
;          (lambda ()
;            (writegood-mode)))

(setq org-CUA-compatible t) ;just if CUA-mode enabled!

(add-to-list 'auto-mode-alist '("\\.\\(org\\|txt\\)$" . org-mode))
(add-to-list 'auto-mode-alist '("README$" . org-mode))

;; minor modes in non-org buffers
(add-hook 'mail-mode-hook 'turn-on-orgtbl)    ;instead M-x orgtbl-mode
(add-hook 'mail-mode-hook 'turn-on-orgstruct) ;instead M-x orgstruct-mode


;; ------------------------------------------------------------
;; MARKDOWN
;; ------------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-hook 'markdown-mode-hook
          (lambda ()
            (visual-line-mode t)
            (writegood-mode t)
            (flyspell-mode t)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ------------------------------------------------------------
;; #### EMACS24 ####
;; ------------------------------------------------------------

(if (>= emacs-major-version 24)
    (progn
      ;; Do something for Emacs 24 or later
      
      ;; ------------------------------------------------------------
      ;; ELPA : Emacs Lisp Package Archive
      ;; http://www.emacswiki.org/emacs/ELPA
      (load "package")
      (package-initialize)
      ;; *Additional Repositories*
      ;; Marmalade 
      (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
      ;; MELPA
      (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
      ;; Org-mode
      (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
      
      (setq package-archive-enable-alist '(("melpa" deft magit)))
      
      (defvar mauro/packages '(ac-math
			       ac-octave
			       ac-python
			       auctex
			       auto-complete
			       autopair
			       color-theme
			       flycheck
			       gist
			       htmlize
			       magit
			       markdown-mode
			       matlab-mode
			       mmm-mode
			       org
			       python
			       sphinx-doc
			       web-mode
			       writegood-mode
			       yaml-mode)
	"Default packages")
      
      
      
      ;; When Emacs boots, check to make sure all of the packages defined in
      ;; mauro/packages are installed. If not, have ELPA take care of it.
      ;; (defun mauro/packages-installed-p ()
      ;;   (loop for pkg in mauro/packages
      ;;         when (not (package-installed-p pkg)) do (return nil)
      ;;         finally (return t)))
      
      ;; (unless (mauro/packages-installed-p)
      ;;   (message "%s" "Refreshing package database...")
      ;;   (package-refresh-contents)
      ;;   (dolist (pkg mauro/packages)
      ;;     (when (not (package-installed-p pkg))
      ;;       (package-install pkg))))
      
      ;; ------------------------------------------------------------


      ;; This makes sure that brace structures (), [], {}, etc. are closed
      ;; as soon as the opening character is typed.
      (require 'autopair)
      ;; turn on auto complete
      (require 'auto-complete-config)
      (ac-config-default)
      
      ;; ALLOW MULTIPLE MAJOR MODES
      ;; From: http://stackoverflow.com/questions/15493342/have-emacs-edit-python-docstrings-using-rst-mode
      ;; NOTE: not using it yet... not really helpful!!!
      ;; (require 'mmm-mode)
      ;; (setq mmm-global-mode 'maybe)
      ;; (mmm-add-classes
      ;;  '((python-rst
      ;;     :submode sphinx-doc-mode
      ;;     :front "^ *[ru]?\"\"\"[^\"]*$"
      ;;     :back "^ *\"\"\""
      ;;     :include-front t
      ;;     :include-back t
      ;;     :end-not-begin t)))
      ;; (mmm-add-mode-ext-class 'python-mode nil 'python-rst)


      ;; org-babel
      (require 'ob)
      
      (org-babel-do-load-languages
       'org-babel-load-languages
       '((sh . t)
	 (ditaa . t)
	 (python . t)
	 (matlab . t)
	 (perl . t)
	 (dot . t)
	 (css . t)
	 (gnuplot . t)
	 (sh . t)
	 (latex . t))
       )
      
      
      )
  ;; Do something else for Emacs 23 or less

;; ------------------------------------------------------------
;; #### EMACS23 ####
;; ------------------------------------------------------------
)
