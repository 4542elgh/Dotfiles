(defvar bootstrap-version)
(let (
  (bootstrap-file (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
  (bootstrap-version 5)
  )
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el" 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)
    )
  )
  (load bootstrap-file nil 'nomessage)
)

;; For emacs 27 and above
(setq package-enable-at-startup nil)

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(use-package esup
  :config (setq esup-depth 0)
)

;; Use a hook so the message doesn't get clobbered by other messages.
(add-hook 'emacs-startup-hook
  (lambda ()
    (message "Emacs ready in %s with %d garbage collections."
      (format "%.2f seconds"
        (float-time
          (time-subtract after-init-time before-init-time)
        )
      )
      gcs-done
    )
  )
)

(tool-bar-mode -1)

(scroll-bar-mode -1)

(blink-cursor-mode 0)

(setq byte-compile-warnings '(cl-functions))

(setq ad-redefinition-action 'accept)

(setq epa-pinentry-mode 'loopback)

(winner-mode 1)
(desktop-save-mode 1)

(setq default-directory "~/")
(setq command-line-default-directory "~/")

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(setq x-select-enable-primary t)

(add-hook 'emacs-startup-hook 'toggle-frame-maximized)

(setq global-auto-revert-mode t)

;; (setq backup-directory-alist
;;   `((".*" . ,temporary-file-directory))
;; )
;; (setq auto-save-file-name-transforms
;;   `((".*" ,temporary-file-directory t))
;; )

(electric-pair-mode)
(add-hook 'prog-mode-hook 'show-paren-mode)
(custom-set-faces
 '(show-paren-match ((t (:background "DeepSkyBlue2" :foreground "yellow" :weight bold)))))

(use-package exec-path-from-shell
  :config (setq exec-path-from-shell-arguments nil)
)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)
)

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(setq load-prefer-newer t)

(setq display-time-24hr-format t)            ; 24 hours 
(setq display-time-format "%H:%M:%S")        ; add seconds
(setq display-time-default-load-average nil) ; 
(setq display-time-interval 1)               ; update every second
(display-time-mode 1)                        ; show time in mode line on startup

(setq gc-cons-threshold (* 128 1024 1024)) ;; 128MB
(setq garbage-collection-messages t)

;; (setq dired-listing-switches "-aBhl  --group-directories-first")

(set-frame-font "DejaVu Sans Mono 16" nil t)

(use-package emojify
  :defer 2
  :config (global-emojify-mode 1)
)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(col-highlight ((t (:background "#313335"))))
  '(show-paren-match ((t (:background "DeepSkyBlue2" :foreground "yellow" :weight bold))))
)

(use-package vterm
  :defer 2
)

(use-package all-the-icons)

(use-package jetbrains-darcula-theme
  :config (load-theme 'jetbrains-darcula t)
)

(use-package spaceline
  :config (spaceline-emacs-theme)
)

(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
)

(use-package smart-tabs-mode)

(use-package rainbow-delimiters
  :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
)

(use-package workgroups)

(use-package col-highlight
  :config (column-highlight-mode)
)

(global-hl-line-mode 1)

(use-package golden-ratio-scroll-screen)

(use-package gse-number-rect
  :straight (gse-number-rect :type git :host github :repo "4542elgh/gse-number-rect")
)

(use-package ace-jump-mode)

(use-package ivy
  :defer 0.1
  :diminish
  :config
    (ivy-mode)
    (define-key ivy-mode-map          (kbd "C-c b") #'nil)
    (define-key ivy-minibuffer-map    (kbd "C-j")   #'ivy-next-line)
    (define-key ivy-minibuffer-map    (kbd "C-k")   #'ivy-previous-line)
    ; Swiper mapped C-K to kill buffer, need to remap that to previous line
    (define-key ivy-switch-buffer-map (kbd "C-k")   #'ivy-previous-line)
    (define-key ivy-switch-buffer-map (kbd "C-x")   #'ivy-switch-buffer-kill)
)

;; (use-package ivy-rich
;;   :init (ivy-rich-mode 1)
;; )

(use-package ivy-prescient
  :config (ivy-prescient-mode)
)

(use-package ivy-posframe
  :config
    (ivy-posframe-mode 1)

    (setq ivy-posframe-parameters '(
      (left-fringe  . 8)
      (right-fringe . 8)
      )
    )

    (setq ivy-posframe-height-alist '(
      (swiper                 . 15)
      (find-file              . 20)
      (counsel-ag             . 15)
      (counsel-projectile-ag  . 30)
      (counsel-evil-registers . 30)
      (t                      . 25)
      )
    )

    (setq ivy-posframe-display-functions-alist '(
      (complete-symbol . ivy-posframe-display-at-point)
      (counsel-M-x     . ivy-posframe-display-at-frame-center)
      (t               . ivy-posframe-display-at-frame-center))
    )

    (defun ivy-posframe-get-size () 
      "The default functon used by `ivy-posframe-size-function'."
      (list
        :height 30
        :width 100
        :min-height (or ivy-posframe-min-height (round (* (frame-height) 0.6)))
        :min-width  (or ivy-posframe-min-width  (round (* (frame-width) 0.62)))
      )
    )
)

(use-package counsel
  :after ivy
  :config
    (setq ivy-initial-inputs-alist nil)
)

(use-package swiper
  :after ivy
  :bind (("C-p" . swiper))
)

(use-package spotify
  :commands spotify-play
  :config
    (setq counsel-spotify-client-secret
      (auth-source-pick-first-password
        :host "spotifySecret"
        :user "4542elgh"
      )
    )
    (setq counsel-spotify-client-id
      (auth-source-pick-first-password
        :host "spotifyId"
        :user "4542elgh"
      )
    )
)

(use-package ivy-youtube
  :commands ivy-youtube
  :config
    (setq ivy-youtube-key
      (auth-source-pick-first-password
        :host "youtubeAPIKey"
        :user "4542elgh"
      )
    )
    (setq ivy-youtube-play-at "~/scripts/mpvSingle.sh")
)

(use-package pdf-tools
  :defer 2
)

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
    ;; unbind from evil
    (define-key evil-normal-state-map (kbd "C-p") nil)
    (define-key evil-normal-state-map (kbd "C-n") nil)
    (define-key evil-emacs-state-map  (kbd "C-z") nil)
    (define-key evil-normal-state-map (kbd "<SPC>") nil)
    (define-key evil-normal-state-map (kbd "C-b") 'bookmark-jump)
    (define-key evil-normal-state-map (kbd "C-m") 'counsel-evil-marks)
    (define-key evil-normal-state-map (kbd "\"")  'counsel-evil-registers)
    (define-key evil-normal-state-map (kbd "C-d") 'golden-ratio-scroll-screen-up)
    (define-key evil-normal-state-map (kbd "C-u") 'golden-ratio-scroll-screen-down)
    (define-key evil-emacs-state-map  (kbd "C-I") 'gse-number-rectangle)
    (evil-mode) 
)

(use-package evil-leader
  :config
    (global-evil-leader-mode)
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
      "b" 'switch-to-buffer
      "t" 'vterm
      "w" 'ace-jump-char-mode
      "x" 'counsel-M-x
    )
)

(use-package evil-multiedit
  :config
    ;; Highlights all matches of the selection in the buffer.
    (define-key evil-visual-state-map "R" 'evil-multiedit-match-all)

    ;; Match the word under cursor (i.e. make it an edit region). Consecutive presses will
    ;; incrementally add the next unmatched match.
    (define-key evil-normal-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
    ;; Match selected region.
    (define-key evil-visual-state-map (kbd "M-d") 'evil-multiedit-match-and-next)

    ;; Same as M-d but in reverse.
    (define-key evil-normal-state-map (kbd "M-D") 'evil-multiedit-match-symbol-and-next)
    (define-key evil-visual-state-map (kbd "M-D") 'evil-multiedit-match-symbol-and-next)

    ;; OPTIONAL: If you prefer to grab symbols rather than words, use
    ;; `evil-multiedit-match-symbol-and-next` (or prev).

    ;; Restore the last group of multiedit regions.
    (define-key evil-visual-state-map (kbd "C-M-D") 'evil-multiedit-restore)

    ;; RET will toggle the region under the cursor
    (define-key evil-multiedit-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

    ;; ...and in visual mode, RET will disable all fields outside the selected region
    (define-key evil-motion-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

    ;; For moving between edit regions
    (define-key evil-multiedit-state-map (kbd "C-n") 'evil-multiedit-next)
    (define-key evil-multiedit-state-map (kbd "C-p") 'evil-multiedit-prev)
    (define-key evil-multiedit-insert-state-map (kbd "C-n") 'evil-multiedit-next)
    (define-key evil-multiedit-insert-state-map (kbd "C-p") 'evil-multiedit-prev)

    ;; Ex command that allows you to invoke evil-multiedit with a regular expression, e.g.
    (evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)
)

(use-package evil-collection
  :defer 2
  :after evil
  :config
    (evil-collection-init)
    (evil-collection-define-key 'normal 'dired-mode-map
      "S" 'dired-do-symlink
      "s" 'hydra-dired-quick-sort/body
      "C" 'dired-do-compress
      "c" 'dired-do-copy
      "h" 'dired-up-directory
      "l" 'dired-find-file
    )
)

(use-package evil-commentary
  :config (evil-commentary-mode)
)

(use-package evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
    (require 'evil-org-agenda)
    (evil-org-agenda-set-keys)
    (define-key org-mode-map (kbd "C-c C-a") nil)
)

(use-package undo-fu)

(use-package lsp-mode
  :hook (
    (mhtml-mode . lsp)
    (js-mode    . lsp)
    (lsp-mode   . lsp-enable-which-key-integration)
  )
  :commands (lsp lsp-deferred)
  :custom   (lsp-headerline-breadcrumb-enable t)
  :config 
    ;; Tuning lsp for better performance
    (setq gc-cons-threshold       100000000)
    (setq read-process-output-max (* 1024 1024)) ;; 1mb
    (setq lsp-idle-delay          0.500)
    (setq lsp-log-io              nil) 
)

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
)

(use-package flycheck
  :config
    (global-flycheck-mode)
    (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc emacs-lisp))
)

(use-package yasnippet
  :after lsp-mode
  :config
    (yas-global-mode 1)
    ;; (define-key yas-minor-mode-map (kbd "C-c y") #'yas-expand)
)

(use-package yasnippet-snippets
  :after yasnippet
)

(use-package yafolding
  :hook (prog-mode . yafolding-mode)
)

(use-package treemacs
  :after treemacs-all-the-icons
  :hook (treemacs-mode . (lambda() (display-line-numbers-mode -1)))
  :config
    (treemacs-follow-mode    t)
    (treemacs-filewatch-mode t)
    (treemacs-load-theme     "all-the-icons")
)

(use-package treemacs-evil
  :after treemacs evil
)

(use-package treemacs-all-the-icons)

(use-package treemacs-projectile
  :after treemacs projectile
)

(use-package lsp-treemacs
  :defer 2
  :after treemacs
  :config (lsp-treemacs-sync-mode 1)
)

(use-package js
  :mode ("\\.js\\'" "\\.jsx\\'" "\\.ts\\'")
  :config (setq js-indent-level 2)
)

(use-package json-mode
  :mode "\\.json\\'"
  ;; :config (add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
)

(use-package flutter)
(use-package dart-mode
  :hook (dart-mode . (lambda () (add-hook 'after-save-hook 'flutter-run-or-hot-reload nil)))
)

(use-package lsp-dart
  :hook (dart-mode . lsp)
)

;; (add-hook 'dart-mode-hook
;; (lambda ()
;;     (add-hook 'after-save-hook 'flutter-run-or-hot-reload nil)
;; )
;; )

(use-package csharp-mode
  :defer 2
  :mode "\\.cs\\'"
)

(use-package yaml-mode)

(use-package docker
	:bind ("C-c d" . docker)
)

(use-package dockerfile-mode
  :config (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
)

(use-package undo-tree
  :config (global-undo-tree-mode)
)

(use-package magit
  :defer 2
)

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(global-set-key (kbd "C-c a")   'counsel-linux-app)
(global-set-key (kbd "C-c C-a") 'org-agenda)
(global-set-key (kbd "C-c b")   'switch-to-buffer)
(global-set-key (kbd "C-c n")   'treemacs)
(global-set-key (kbd "C-c x")   'counsel-M-x)
(global-set-key (kbd "C-c C-p") 'counsel-projectile-rg)

(use-package projectile
  :diminish projectile-mode
  :init
    (when (file-directory-p "~/Dev")
      (setq projectile-project-search-path  '("~/Dev"))
    )
    (setq projectile-indexing-method        'native)
    (setq projectile-switch-project-action #'projectile-dired)
  :config 
    (projectile-mode)
    (add-to-list 'projectile-globally-ignored-directories "node_modules")
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap ("C-c p" . projectile-command-map)
)

(use-package counsel-projectile
  :defer 2
  :after (counsel projectile)
  :config (counsel-projectile-mode)
)

(use-package org 
    :init (add-hook 'org-mode-hook (lambda () (setq-local display-line-numbers-type nil))) 
    :hook 
      (org-mode . efs/org-mode-setup) 
      (org-mode . (lambda () (require 'org-tempo))) 
      (org-mode . (lambda () (setq display-line-numbers-mode nil))) 
      (emacs-lisp-mode-hook . (lambda() 
        (setq-default indent-tabs-mode nil) 
        (setq-default tab-width 2) 
        (setq indent-line-function 'insert-tab)
      )) 
    :config 
        (setq org-ellipsis "▼") 
        (setq org-src-tab-acts-natively nil) 
        (add-to-list 'org-emphasis-alist           '("*" (:foreground "black" :background "yellow"))) 
        (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp")) 
        (add-to-list 'org-structure-template-alist '("javascript" . "src javascript")) 
        (add-to-list 'org-structure-template-alist '("bash" . "src bash")) 
        (add-to-list 'org-structure-template-alist '("conf" . "src conf"))) 
(defun efs/org-mode-visual-fill () 
    (setq visual-fill-column-width 100 visual-fill-column-center-text t) 
    (visual-fill-column-mode 1)
) 

(use-package visual-fill-column 
  :hook (org-mode . efs/org-mode-visual-fill)
)

(defun efs/org-mode-setup () (org-indent-mode))

(use-package org-super-agenda
  :defer 2
)

; It needs more configuration, see https://github.com/alphapapa/org-super-agenda

(use-package calfw
  :defer 2
)

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
)

;; (use-package org-roam
;;       :after org
;;       :hook (org-mode . org-roam-mode)
;;       :custom (org-roam-directory "~/.config/emacs/roam")
;;       ;; :bind (:map org-roam-mode-map
;;       ;;         (("C-c n l" . org-roam)
;;       ;;          ("C-c n f" . org-roam-find-file)
;;       ;;          ("C-c n g" . org-roam-graph))
;;       ;;         :map org-mode-map
;;       ;;         (("C-c n i" . org-roam-insert))
;;       ;;         (("C-c n I" . org-roam-insert-immediate)))
;; )

(use-package org-journal
  :defer 2
  :config
    (setq org-journal-file-format "%A %F")
    (setq org-journal-dir         "~/.config/emacs/journal")
)

(use-package calendar
  :config (define-key calendar-mode-map (kbd "C-c j") #'org-journal-read-entry)
)

(setq org-agenda-files '("/Volumes/4542elgh/org/agenda"))
(setq org-agenda-show-inherited-tags t)

;; (use-package calfw
;;   :after org
;;   :config (require 'calfw-org)
;; )

(use-package ts
  :defer 2
  :straight (ts :type git :host github :repo "alphapapa/ts.el")
)

(use-package org-ql
  :defer 2
  :straight (org-ql :type git :host github :repo "alphapapa/org-ql")
)

(use-package alert
  :defer (org-ql ts)
  :straight (alert :type git :host github :repo "jwiegley/alert")
  :config
    (defcustom alerter-notifier-command (executable-find "alerter")
    "Path to the terminal-notifier command.
    From https://github.com/julienXX/terminal-notifier."
    :type 'file 
    :group 'alert)

    (defun alerter-notifier-notify (info)
      (if alerter-notifier-command
        (let ((args
               (list
                 "-sound"   "default"
                 "-title"   (alert-encode-string (plist-get info :title))
                 "-message" (concat "\"" (alert-encode-string (plist-get info :message)) "\"")
               )
             ))
            (start-process-shell-command "alerter-process" "test_buffer" (concat "alerter " (mapconcat 'identity args " "))))

        (alert-message-notify info)))

    (alert-define-style 'alerter
      :title "Notify using terminal-notifier"
      :notifier #'alerter-notifier-notify
    )

  (setq alert-default-style 'alerter)
)

(use-package org-timed-alerts
  :straight (org-timed-alerts :type git :host github :repo "legalnonsense/org-timed-alerts")
  :after (org alert)
  :custom
  (org-timed-alerts-alert-function #'alert)
  (org-timed-alerts-tag-exclusions nil)
  (org-timed-alerts-warning-times '(-10 -5))
  (org-timed-alerts-agenda-hook-p t)
  (org-timed-alert-final-alert-string "IT IS %alert-time\n\n%todo %headline")
  (org-timed-alert-warning-string (concat "%todo %headline\n at %alert-time\n "
                                          "it is now %current-time\n "
                                          "*THIS IS YOUR %warning-time MINUTE WARNING*"))
  :config
  (add-hook 'org-mode-hook #'org-timed-alerts-mode)
)

(use-package which-key
  :config (which-key-mode)
)

(use-package helpful
  :custom
    (counsel-describe-function-function #'helpful-callable)
    (counsel-describe-variable-function #'helpful-variable)
  :bind
    ([remap describe-function] . counsel-describe-function)
    ([remap describe-command]  . helpful-command)
    ([remap describe-variable] . counsel-describe-variable)
    ([remap describe-key]      . helpful-key) 
)

(use-package no-littering
  :config
    (setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
)

(defun align-pipe (start end)
  "Align columns by pipe"
  (interactive "r")
  (align-regexp start end "\\(\\s-*\\)|" 1 1 t)
)
