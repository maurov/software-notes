;; ================================================
;; Mauro's Emacs configuration for Python & friends
;; ================================================

;; CHANGELOG
;; ---------
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
    elpy
    flycheck
    magit
    material-theme
    py-autopep8
    yaml-mode))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; -------------------

;; set working conda environment
(setenv "WORKON_HOME" "/home/mauro/local/conda/envs")
(pyvenv-mode 1)
(pyvenv-workon "sloth-lab")

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally
(elpy-enable) ;; Python IDE

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")

(global-set-key (kbd "C-x g") 'magit-status)

;; YAML
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
