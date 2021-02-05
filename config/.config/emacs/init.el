(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

(package-initialize)

;;; If use-pacakge is not installed, instll it first before requiring
(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

(setq x-select-enable-primary t)

(setq global-auto-revert-mode t)

(desktop-save-mode 1)

(setq default-directory "~/")
(setq command-line-default-directory "~/")

(use-package exec-path-from-shell)

(when (memq window-system '(mac))
  (exec-path-from-shell-initialize)
)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-projects-backend 'projectile)
  (add-to-list 'dashboard-items '(projects . 5))
)

(use-package jetbrains-darcula-theme
    :config (load-theme 'jetbrains-darcula t)
)

(set-frame-font "DejaVu Sans Mono 11" nil t)

(use-package all-the-icons)

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(add-hook 'prog-mode-hook #'hs-minor-mode)

(setq company-idle-delay 0)
(setq company-minimum-prefix-length 2)

(use-package eshell
    :init (add-hook 'eshell-mode-hook
        (lambda () (setq-local display-line-numbers-type nil))
    )
)

(setq dired-listing-switches "-lXGh --group-directories-first")

(setq load-prefer-newer t)

(scroll-bar-mode -1)

(menu-bar-mode -1)

(tool-bar-mode -1) 

(blink-cursor-mode 0)

(use-package spaceline
    :config (spaceline-emacs-theme)
)

(setq display-time-24hr-format t) 
(setq display-time-format "%H:%M:%S")        ; add seconds
(setq display-time-default-load-average nil)
(setq display-time-interval 1)               ; update every second
(display-time-mode 1)                 ; show time in mode line on startup

(use-package centaur-tabs
    :demand
    :config
        (centaur-tabs-mode t)
        (setq centaur-tabs-set-modified-marker t)
        (setq centaur-tabs-set-icons t)
        (setq centaur-tabs-style "bar")
        (setq centaur-tabs-set-bar 'left)
        (centaur-tabs-change-fonts "DejaVu Sans Mono" 120)
        (centaur-tabs-group-by-projectile-project)
)

(use-package nyan-mode
    :config (setq nyan-mode t)
)

(use-package ivy
  :defer 0.1
  :diminish
  :config (ivy-mode)
  (define-key ivy-minibuffer-map (kbd "C-j") #'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-k") #'ivy-previous-line)
  ; Swiper mapped C-K to kill buffer, need to remap that to previous line
  (define-key ivy-switch-buffer-map (kbd "C-k") #'ivy-previous-line)
  (define-key ivy-switch-buffer-map (kbd "C-x") #'ivy-switch-buffer-kill)
)

(use-package ivy-prescient)

(use-package ivy-rich
  :init (ivy-rich-mode 1)
)

(use-package counsel
    :after ivy
    :config
        (setcdr (assoc 'counsel-M-x ivy-initial-inputs-alist) "")
)

(use-package counsel-projectile
  :bind (
	("C-P" . counsel-projectile-rg)
	)
  :config (counsel-projectile-mode)
)

(use-package swiper
  :after ivy
  :bind (
    ("C-p" . swiper)
  )
)

(setq auth-sources '((:source "~/.authinfo.gpg")))

(use-package evil
  :init
    ; Need this for evil-collection to work properly
    (setq evil-want-keybinding nil)
    ; Evil mode set Ctrl-U to scroll up.
    (setq evil-want-C-u-scroll t)
    (setq evil-want-C-i-jump nil)
    (setq evil-normal-state-tag "NORMAL")
    (setq evil-insert-state-tag "INSERT")
    (setq evil-visual-state-tag "VISUAL")
    ; Define undo-redo system, otherwise redo wont work
    (setq evil-undo-system 'undo-fu)
  :config
    ; Remap colon and semicolon
    (define-key evil-motion-state-map ";" #'evil-ex)
    (define-key evil-motion-state-map ":" #'evil-repeat-find-char)
    ;; C-p is used for Swiper, so we need to unbind it from evil
    (define-key evil-normal-state-map (kbd "C-p") nil)
    (define-key evil-emacs-state-map (kbd "C-z") nil)
    ;; (define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
    ;; (define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
    ;; (define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
    ;; (define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)

    (evil-mode) 
)

(use-package evil-collection
    :after evil
    :config (evil-collection-init)
)

(use-package evil-commentary
    :config (evil-commentary-mode)
)

(use-package evil-easymotion
  :config
  (evilem-default-keybindings "SPC")
  (evilem-define (kbd "SPC w") 'evil-forward-WORD-begin)
  (evilem-define (kbd "SPC W") 'evil-backward-WORD-begin)
)

(use-package undo-fu)

(use-package mu4e
    :ensure nil
    :config

    ;; This is set to 't' to avoid mail syncing issues when using mbsync
    (setq mu4e-change-filenames-when-moving t)

    ;; Refresh mail using isync every 1 minutes
    (setq mu4e-update-interval (* 1 60))
    (setq mu4e-get-mail-command "mbsync -a")
    (setq mu4e-maildir "~/Mail")

    (setq mu4e-drafts-folder "/[Gmail]/Drafts")
    (setq mu4e-sent-folder   "/[Gmail]/Sent Mail")
    (setq mu4e-refile-folder "/[Gmail]/All Mail")
    (setq mu4e-trash-folder  "/[Gmail]/Trash")

    (setq mu4e-maildir-shortcuts
        '(("/Inbox"             . ?i)
          ("/[Gmail]/Sent Mail" . ?s)
          ("/[Gmail]/Trash"     . ?t)
          ("/[Gmail]/Drafts"    . ?d)
          ("/[Gmail]/All Mail"  . ?a))
    )
)

(use-package mu4e-alert
    :config
    (mu4e-alert-set-default-style 'libnotify)
    (add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
)

(use-package counsel-spotify
    :config
    (setq counsel-spotify-client-id (auth-source-pick-first-password :host "client.spotify.com" :user "4542elgh@gmail.com"))	
    (setq counsel-spotify-client-secret (auth-source-pick-first-password :host "secret.spotify.com" :user "4542elgh@gmail.com"))
)

(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

(use-package dockerfile-mode)

(use-package markdown-mode 
    :commands (markdown-mode gfm-mode) 
    :mode (("README\\.md\\'" . gfm-mode) ("\\.md\\'" . markdown-mode) ("\\.markdown\\'" . markdown-mode)) 
    :init (setq markdown-command "multimarkdown") 
    :config (custom-set-variables '(markdown-command "/usr/bin/pandoc"))
)

(use-package json-mode)

(use-package js2-mode
  
:config
    (setq js2-mode-show-parse-errors nil)
    (setq js2-mode-show-strict-warnings nil)  
)

(use-package lsp-mode
    :hook (
        (mhtml-mode . lsp)
        (js-mode . lsp)
        (lsp-mode . lsp-enable-which-key-integration)
    )
    :commands (lsp lsp-deferred)
    :custom (lsp-headerline-breadcrumb-enable t)
)

(use-package lsp-ui
    :ensure t
    :after lsp-mode
    :commands lsp-ui-mode
)

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(use-package ivy-posframe
  :diminish ivy-posframe-mode
  :hook (ivy-mode . ivy-posframe-mode)
  :config
  (setq ivy-posframe-height-alist '(
				    (swiper . 15)
                                    (find-file . 20)
                                    (counsel-ag . 15)
                                    (counsel-projectile-ag . 30)
                                    (t      . 25)
				    )
   )

  (setq ivy-posframe-display-functions-alist
        '(
	  ;; (swiper          . ivy-posframe-display-at-window-center)
          (complete-symbol . ivy-posframe-display-at-point)
          ;;(counsel-M-x     . ivy-posframe-display-at-window-bottom-left)
          (counsel-M-x     . ivy-posframe-display-at-frame-center)
          (t               . ivy-posframe-display-at-frame-center)))

    (defun ivy-posframe-get-size ()
    "The default functon used by `ivy-posframe-size-function'."
    (list
    :height 30
    :width 100
    :min-height (or ivy-posframe-min-height (round (* (frame-height) 0.6)))
    :min-width (or ivy-posframe-min-width (round (* (frame-width) 0.62)))
    )
    )
  (ivy-posframe-mode 1)
)

; --- LSP tuning starts 
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq lsp-idle-delay 0.500)
(setq lsp-log-io nil) 
; --- LSP tuning ends

(use-package flycheck
    :config
        (global-flycheck-mode)
        (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc emacs-lisp))
)

(use-package company
  :init
  (setq company-backends
   '(company-files company-bbdb company-semantic company-cmake company-capf company-clang company-files
		   (company-dabbrev-code company-gtags company-etags company-keywords)
		   company-oddmuse company-dabbrev))
)

(use-package yasnippet
    :after lsp-mode
    :config (yas-global-mode 1)
    (define-key yas-minor-mode-map (kbd "C-c y") #'yas-expand)
)

(use-package yasnippet-snippets
    :after yasnippet
)

(use-package prettier-js
  :config
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'json-mode-hook 'prettier-js-mode)
)

(use-package treemacs
    :config
        (treemacs-follow-mode t)
        (treemacs-filewatch-mode t)
)

(use-package treemacs-evil
    :after treemacs evil
)

(use-package treemacs-projectile
    :after treemacs projectile
)

(use-package lsp-treemacs
    :after treemacs
    :config (lsp-treemacs-sync-mode 1)
)

(use-package treemacs-all-the-icons)

(use-package evil-multiedit
  :config
    ;; Highlights all matches of the selection in the buffer.
    (define-key evil-visual-state-map "R" 'evil-multiedit-match-all)

    ;; Match the word under cursor (i.e. make it an edit region). Consecutive presses will
    ;; incrementally add the next unmatched match.
    (define-key evil-normal-state-map (kbd "M-d") 'evil-multiedit-match-symbol-and-next)
    ;; Match selected region.
    (define-key evil-visual-state-map (kbd "M-d") 'evil-multiedit-match-symbol-and-next)

    ;; Same as M-d but in reverse.
    (define-key evil-normal-state-map (kbd "M-D") 'evil-multiedit-match-symbol-and-prev)
    (define-key evil-visual-state-map (kbd "M-D") 'evil-multiedit-match-symbol-and-prev)

    ;; Ex command that allows you to invoke evil-multiedit with a regular expression, e.g.
    (evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)
)


(use-package autopair
  :config (autopair-global-mode)
  (add-hook 'highlight-parentheses-mode-hook
          '(lambda ()
             (setq autopair-handle-action-fns
                   (append
					(if autopair-handle-action-fns
						autopair-handle-action-fns
					  '(autopair-default-handle-action))
					'((lambda (action pair pos-before)
						(hl-paren-color-update)))))))
)

(use-package indent-guide
  :config (indent-guide-global-mode)
)

(use-package projectile
    :diminish projectile-mode
    :config 
        (projectile-mode)
        (add-to-list 'projectile-globally-ignored-directories "node_modules")
    :custom ((projectile-completion-system 'ivy))
    :bind-keymap ("C-c p" . projectile-command-map)
    :init
        (when (file-directory-p "~/Dev")
        (setq projectile-project-search-path '("~/Dev")))
        (setq projectile-indexing-method 'native)
        (setq projectile-switch-project-action #'projectile-dired)
)

(use-package counsel-projectile
    :config (counsel-projectile-mode)
)

(use-package magit)

(use-package rainbow-delimiters
    :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
)

(use-package eyebrowse
    :config (eyebrowse-mode t)
)

;; (use-package elcord
;;   :config (elcord-mode)
;; )

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

; Define shortcuts
(global-set-key (kbd "<f1>") (lambda() (interactive)(find-file "~/.config/emacs/init.org")))
(global-set-key (kbd "<f2>") (lambda() (interactive)(find-file "~/.config/emacs/init.el")))

(global-set-key (kbd "C-c t") 'eshell)
(global-set-key (kbd "C-c a") 'counsel-linux-app)
(global-set-key (kbd "C-c b") 'counsel-switch-buffer)
(global-set-key (kbd "C-c C-b") 'counsel-projectile-switch-to-buffer)
(global-set-key (kbd "C-c m") 'counsel-evil-marks)
(global-set-key (kbd "C-c n") 'treemacs)
(global-set-key (kbd "C-c C-w") 'persp-switch)
(global-set-key (kbd "C-c x") 'counsel-M-x)

(use-package key-chord
    :ensure t
    :config (key-chord-mode 1)
)

(add-hook 'prog-mode-hook 'hl-line-mode)

(add-hook 'prog-mode-hook 'show-paren-mode)

(add-hook 'markdown-mode-hook 'markdown-live-preview-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(defun efs/org-mode-setup ()
    (org-indent-mode)
    ;; (variable-pitch-mode 1)
    (visual-line-mode 1)
)

(dolist (face 
  '(
    (org-level-1 . 1.2)
    (org-level-2 . 1.1)
    (org-level-3 . 1.05)
    (org-level-4 . 1.0)
    (org-level-5 . 1.1)
    (org-level-6 . 1.1)
    (org-level-7 . 1.1)
    (org-level-8 . 1.1)
  ))
)

(use-package org
    :init (add-hook 'org-mode-hook (lambda () (setq-local display-line-numbers-type nil)))
    :hook 
        (org-mode . efs/org-mode-setup)
        (org-mode . (lambda () (require 'org-tempo)))
    :config
        (setq org-ellipsis " ▾")
        (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
        (add-to-list 'org-structure-template-alist '("js" . "src javascript"))
        (add-to-list 'org-structure-template-alist '("bash" . "src bash"))
        (add-to-list 'org-structure-template-alist '("conf" . "src conf"))
)

(use-package org-roam
      :after org
      :hook (org-mode . org-roam-mode)
      :custom (org-roam-directory "~/.config/emacs/roam")
      ;; :bind (:map org-roam-mode-map
      ;;         (("C-c n l" . org-roam)
      ;;          ("C-c n f" . org-roam-find-file)
      ;;          ("C-c n g" . org-roam-graph))
      ;;         :map org-mode-map
      ;;         (("C-c n i" . org-roam-insert))
      ;;         (("C-c n I" . org-roam-insert-immediate)))
      :config
)

(use-package org-journal
  :config
  (setq org-journal-file-format "%A %F")
  (setq org-journal-dir "~/.config/emacs/journal")
)

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
)

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100 visual-fill-column-center-text t)
  (visual-fill-column-mode 1)
)

(use-package visual-fill-column
    :hook (org-mode . efs/org-mode-visual-fill)
)

(add-hook 'org-mode-hook '(lambda () (setq display-line-numbers-type nil)))

(use-package which-key
    :config (which-key-mode)
)

(use-package helpful
    :custom
        (counsel-describe-function-function #'helpful-callable)
        (counsel-describe-variable-function #'helpful-variable)
    :bind
        ([remap describe-function] . counsel-describe-function)
        ([remap describe-command] . helpful-command)
        ([remap describe-variable] . counsel-describe-variable)
        ([remap describe-key] . helpful-key) 
)

(defun align-pipe (start end)
  "Align columns by pipe"
  (interactive "r")
  (align-regexp start end "\\(\\s-*\\)|" 1 1 t)
)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-command "/usr/bin/pandoc")
 '(package-selected-packages
   '(evil-smartparens smaartparens ivy-posframe evil-surround yasnippet-snippets which-key visual-fill-column use-package undo-fu treemacs-projectile treemacs-evil treemacs-all-the-icons spaceline rainbow-delimiters prettier-js org-roam org-journal org-bullets nyan-mode mu4e-alert magit lsp-ui lsp-treemacs key-chord js2-mode jetbrains-darcula-theme ivy-rich ivy-prescient indent-guide helpful flycheck eyebrowse exec-path-from-shell evil-multiedit evil-mc evil-easymotion evil-commentary evil-collection emojify dockerfile-mode docker dashboard counsel-spotify counsel-projectile company centaur-tabs autopair)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
