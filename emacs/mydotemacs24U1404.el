;; -*- emacs-lisp -*-
;; ------------------------------------------------------------
;; Mauro Rovezzi's EMACS config file <mauro.rovezzi@gmail.com>
;; MIT License
;; Current version: optimized for XUbuntu 14.04 (ubox1404)
;; Previous version: mydotemacs (mydotemacs24U1204)
;; ~/.emacs -> ~/utils/software-notes/mydotemacs24U1404
;; ------------------------------------------------------------
;; System packages required:
;; emacs
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

;; DOCONCE
(load-file "~/local/emacs/.doconce-mode.el")

;; Start-up options // MISC
(global-visual-line-mode 1); Proper line wrapping
;;(global-hl-line-mode 1); Highlight current row
(show-paren-mode 1); Matches parentheses and such in every mode
(setq calendar-week-start-day 1); Calender should start on Monday
(add-to-list 'default-frame-alist '(height . 50)); Default frame height.
(add-to-list 'default-frame-alist '(width . 200)); Default frame height.
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

;; Frame title
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


;; disable file changed on disk
;; http://stackoverflow.com/questions/2284703/emacs-how-to-disable-file-changed-on-disk-checking
;; (defun ask-user-about-supersession-threat (fn)
;;   "blatantly ignore files that changed on disk"
;;   )
;; (defun ask-user-about-lock (file opponent)
;;   "always grab lock"
;;    t)
;; this workaround does not work!!! the problem is related to VirtualBox, as here:
;; http://stackoverflow.com/questions/34417400/eliminating-file-changed-on-disk-warning-in-emacs-on-virtualbox

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

;;VISUAL-LINE MODE
;;(setq visual-line-mode t)
(global-visual-line-mode 0)
(setq adaptive-wrap-prefix-mode t)

;; WORD WRAP AT SPECIFIC COLUMN NUMBER
;; NO! THIS IS A PAIN!!!
;; from: http://stackoverflow.com/questions/8772488/emacs-word-wrap-at-specific-column-number
;; (add-hook 'text-mode-hook 'turn-on-auto-fill)
;; (add-hook 'text-mode-hook
;; 	  '(lambda() (set-fill-column 80)))
;; (add-hook 'latex-mode-hook 'turn-on-auto-fill)
;; (add-hook 'latex-mode-hook
;; 	  '(lambda() (set-fill-column 80)))

;;; Use Python mode with LARCH files
(add-to-list 'auto-mode-alist '("\\.lar$" . python-mode))

;; ------------------------------------------------------------
;; LATEX-AUCTEX
;; http://emacswiki.org/emacs/AUCTeX
;; ------------------------------------------------------------
;; Customary Customization, p. 1 and 16 in the manual, and http://www.emacswiki.org/emacs/AUCTeX#toc2
(setq TeX-auto-save t); Enable parse on save
(setq TeX-parse-self t); Enable parse on load
(setq TeX-save-query nil)
;;(setq TeX-PDF-mode t); PDF mode (rather than DVI-mode)
(setq-default TeX-master nil)

(add-hook 'TeX-mode-hook 'flyspell-mode); Enable Flyspell mode for TeX modes such as AUCTeX. Highlights all misspelled words.
(add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode); Enable Flyspell program mode for emacs lisp mode, which highlights all misspelled words in comments and strings.
(setq ispell-dictionary "english"); Default dictionary. To change do M-x ispell-change-dictionary RET.
(add-hook 'TeX-mode-hook
          (lambda () (TeX-fold-mode 1))); Automatically activate TeX-fold-mode.
(setq LaTeX-babel-hyphen nil); Disable language-specific hyphen insertion.

;; " expands into csquotes macros (for this to work babel must be loaded after csquotes).
(setq LaTeX-csquotes-close-quote "}"
      LaTeX-csquotes-open-quote "\\enquote{")

;; LaTeX-math-mode http://www.gnu.org/s/auctex/manual/auctex/Mathematics.html
(add-hook 'TeX-mode-hook 'LaTeX-math-mode)

;;; RefTeX
;; Turn on RefTeX for AUCTeX http://www.gnu.org/s/auctex/manual/reftex/reftex_5.html
(add-hook 'TeX-mode-hook 'turn-on-reftex)

;; Fontification (remove unnecessary entries as you notice them) http://lists.gnu.org/archive/html/emacs-orgmode/2009-05/msg00236.html http://www.gnu.org/software/auctex/manual/auctex/Fontification-of-macros.html
(setq font-latex-match-reference-keywords
      '(
        ;; biblatex
        ("printbibliography" "[{")
        ("addbibresource" "[{")
        ;; Standard commands
        ;; ("cite" "[{")
        ("Cite" "[{")
        ("parencite" "[{")
        ("Parencite" "[{")
        ("footcite" "[{")
        ("footcitetext" "[{")
        ;; ;; Style-specific commands
        ("textcite" "[{")
        ("Textcite" "[{")
        ("smartcite" "[{")
        ("Smartcite" "[{")
        ("cite*" "[{")
        ("parencite*" "[{")
        ("supercite" "[{")
        ; Qualified citation lists
        ("cites" "[{")
        ("Cites" "[{")
        ("parencites" "[{")
        ("Parencites" "[{")
        ("footcites" "[{")
        ("footcitetexts" "[{")
        ("smartcites" "[{")
        ("Smartcites" "[{")
        ("textcites" "[{")
        ("Textcites" "[{")
        ("supercites" "[{")
        ;; Style-independent commands
        ("autocite" "[{")
        ("Autocite" "[{")
        ("autocite*" "[{")
        ("Autocite*" "[{")
        ("autocites" "[{")
        ("Autocites" "[{")
        ;; Text commands
        ("citeauthor" "[{")
        ("Citeauthor" "[{")
        ("citetitle" "[{")
        ("citetitle*" "[{")
        ("citeyear" "[{")
        ("citedate" "[{")
        ("citeurl" "[{")
        ;; Special commands
        ("fullcite" "[{")))

(setq font-latex-match-textual-keywords
      '(
        ;; biblatex brackets
        ("parentext" "{")
        ("brackettext" "{")
        ("hybridblockquote" "[{")
        ;; Auxiliary Commands
        ("textelp" "{")
        ("textelp*" "{")
        ("textins" "{")
        ("textins*" "{")
        ;; supcaption
        ("subcaption" "[{")))

(setq font-latex-match-variable-keywords
      '(
        ;; amsmath
        ("numberwithin" "{")
        ;; enumitem
        ("setlist" "[{")
        ("setlist*" "[{")
        ("newlist" "{")
        ("renewlist" "{")
        ("setlistdepth" "{")
        ("restartlist" "{")))

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

;(add-to-list 'auto-mode-alist '("\\.\\(org\\|txt\\)$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.org" . org-mode))
;(add-to-list 'auto-mode-alist '("README$" . org-mode))

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
      (add-to-list 'package-archives
		   '("marmalade" . "http://marmalade-repo.org/packages/") t)
      ;; MELPA
      (add-to-list 'package-archives
		   '("melpa" . "http://melpa.milkbox.net/packages/") t)
      ;; Org-mode
      (add-to-list 'package-archives
		   '("org" . "http://orgmode.org/elpa/") t)
      
      ;; (setq package-archive-enable-alist '(("melpa" deft magit)))
      
      (defvar mau_packages '(ac-math
			     ac-octave
			     ac-python
			     adaptive-wrap
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
	"My default packages")
      
      
      
      ;; When Emacs boots, check to make sure all of the packages defined in
      ;; mau_packages are installed. If not, have ELPA take care of it.
      ;; (defun maupackages-installed-p ()
      ;;   (loop for pkg in mau_packages
      ;;         when (not (package-installed-p pkg)) do (return nil)
      ;;         finally (return t)))
      
      ;; (unless (maupackages-installed-p)
      ;;   (message "%s" "Refreshing package database...")
      ;;   (package-refresh-contents)
      ;;   (dolist (pkg mau_packages)
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
