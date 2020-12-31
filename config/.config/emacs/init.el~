;;; init.el --- Initialization file for Emacs
;;; Commentary: Emacs Startup File --- initialization for Emacs
(require 'package)

;;; Add source so we can install use-package
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))

(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(package-initialize)

;;; Set font
(set-frame-font "DejaVu Sans Mono 11" nil t)
(global-display-line-numbers-mode)
(setq load-prefer-newer t)
(setq display-line-numbers-type 'relative)
(setq evil-want-C-u-scroll t)
(setq x-select-enable-primary t)
(setq nyan-mode t)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc emacs-lisp))
(scroll-bar-mode -1)
(blink-cursor-mode 0)

;; mode line time stamp
(setq display-time-24hr-format t)
(setq display-time-format "%H:%M:%S")        ; add seconds
(setq display-time-default-load-average nil)
(setq display-time-interval 1)               ; update every second
(display-time-mode 1)                 ; show time in mode line on startup

(setq evil-normal-state-tag "NORMAL")
(setq evil-insert-state-tag "INSERT")
(setq evil-visual-state-tag "VISUAL")

;;; If use-pacakge is not installed, instll it first before requiring
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;;; Install Darcula theme, download it if not presented
(use-package jetbrains-darcula-theme
  :ensure t
  :config (load-theme 'jetbrains-darcula t)
)

;;; Install evil mode, VIM KEY BIND LETS GOOOOOO
(use-package evil
  :ensure t
  :config (evil-mode) 
)

(define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)

;;; unbind Evil Mode Ctrl-P to swiper (this needs to be at least after Evil Mode loaded)
(define-key evil-normal-state-map (kbd "C-p") nil)

;;; Auto complete commands
(use-package ivy
  :defer 0.1
  :ensure t
  :diminish
  :config (ivy-mode)
)

(use-package counsel
  :after ivy
  :ensure t
  :config
  (setcdr (assoc 'counsel-M-x ivy-initial-inputs-alist) "")
)

(use-package swiper
  :after ivy
  :ensure t
  :bind (
    ("C-p" . swiper)
  )
)

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode)
)

(use-package rainbow-delimiters
  :ensure t
  :init (
    add-hook 'prog-mode-hook #'rainbow-delimiters-mode
  )
)

(use-package key-chord
  :ensure t
  :config (key-chord-mode 1)
  (key-chord-define-global "xx" 'counsel-M-x)
  (key-chord-define-global "xa" 'counsel-linux-app)
  (key-chord-define-global "xb" 'kill-buffer)
  (key-chord-define-global "zb" 'list-buffer)
  (key-chord-define-global "cc" 'comment-line)
  (key-chord-define-global "ss" 'sr-speedbar-toggle)
)

;; (use-package sr-speedbar
;;   :ensure t
;;   :init
;;     (setq sr-speedbar-right-side nil)
;;     (setq speedbar-show-unknown-files t)
;;     (setq sr-speedbar-width 25)
;;     (setq speedbar-use-images nil)
;; )

(use-package neotree
  :ensure t
)

(use-package spaceline
  :ensure t
  :config (spaceline-emacs-theme)
)

(use-package nyan-mode
  :ensure t
  ;; :config (spaceline-spacemacs-theme)
)

(use-package web-mode
  :ensure t
)

;; (use-package exwm
;;   :ensure t
;;   :config
;;     (require 'exwm-config)
;;     (exwm-config-default)
;;     (server-start)
;; )

; Define shortcuts
(global-set-key (kbd "<f1>") (lambda() (interactive)(find-file "~/.config/emacs/init.el")))
(global-set-key (kbd "<f2>") (lambda() (interactive)(find-file "~/.config/emacs/elpa/spaceline-20201016.1043/spaceline.el")))


(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

; Define Evil mode binding to Vim-Like behavior
(define-key evil-motion-state-map ";" #'evil-ex)
(define-key evil-motion-state-map ":" #'evil-repeat-find-char)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(key-chord swiper ivy use-package jetbrains-darcula-theme evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
