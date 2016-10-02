
;; Get the package system setup
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
;; (package-refresh-contents)
(package-initialize)



;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)



;; TODO:
(use-package yaml-mode :ensure t)
(use-package textmate :ensure t)
(use-package helm-swoop :ensure t)
(use-package magit :ensure t)
(use-package smex
  :ensure t
  :config
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  )
(use-package zoom-frm
  :ensure t
  :config
  (define-key ctl-x-map [(control ?+)] 'zoom-in/out)
  (define-key ctl-x-map [(control ?-)] 'zoom-in/out)
  (define-key ctl-x-map [(control ?=)] 'zoom-in/out)
  (define-key ctl-x-map [(control ?0)] 'zoom-in/out)
  )



;; Complete Anything
(use-package company :ensure t)



;; Themes - daylight
(use-package pastelmac-theme :ensure t)

;; Themes - indoor use
(use-package railscasts-theme :ensure t)

(defun outdoors() (interactive) (load-theme 'pastelmac))
(defun indoors() (interactive) (load-theme 'railscasts))



;; Just why would you do anything else? :D
(use-package evil
  :ensure t
  :init (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (defalias #'forward-evil-word #'forward-evil-symbol)
  )



;; Gimme some Erlang!
(use-package erlang
  :ensure t
  :init
  (setq erlang-electric-commands t)
  )
(use-package edts :ensure t)
(use-package lfe-mode :ensure t)
(use-package kerl :ensure t)



;; Other packages
(use-package cider :ensure t)
(use-package terraform-mode :ensure t)
(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  )
(use-package flx-ido :ensure t)
(use-package projectile
  :ensure t
  :init
  (setq projectile-enable-caching t)
  :config
  (projectile-global-mode)
  )
(use-package neotree
  :ensure t
  :init
  ;; ;; Fixed width window is an utterly horrendous idea
  ;; (setq neo-window-fixed-size nil)
  (setq neo-window-fixed-size nil)
  (setq neo-window-width 35)
  ;; When neotree is opened, find the active file and
  ;; highlight it
  (setq neo-smart-open t)
  )
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1)
  )
(use-package ag :ensure t)

(use-package linum-relative
  :ensure t
  :config
  (setq linum-relative-format "%3s ")
  (linum-relative-global-mode)
  )



;; Configure identation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(defvaralias 'erlang-indent-level 'tab-width)
(defvaralias 'js-indent-level 'tab-width)



;; Get EDTS Started
(add-hook 'after-init-hook 'my-after-init-hook)
(defun my-after-init-hook ()
  (require 'edts-start)
  )



;; Random Stuff
(setq confirm-nonexistent-file-or-buffer 1)
(setq-default indicate-empty-lines t)
(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(define-key evil-normal-state-local-map (kbd "C-p") 'projectile-find-file)



;;    ;; Custom toggle for neotree to make the damn thing
;;    ;; follow the project root
;;    (defun my-neotree-toggle ()
;;      "Toggle show the NeoTree window."
;;      (interactive)
;;      (if (neo-global--window-exists-p)
;;          (neotree-hide)
;;        (my-neotree-show)))
;;
;;    (defun my-neotree-show ()
;;      "Show the NeoTree window."
;;      (interactive)
;;      ;;(neo-global--open-dir (projectile-project-root))
;;      (neotree-find)
;;      (neo-buffer--change-root (projectile-project-root))
;;      ;;(neo-global--select-window)
;;      )
(defun neotree-project-dir ()
  (interactive)
  (let ((project-dir (projectile-project-root))
        (file-name (buffer-file-name)))
    (if project-dir
        (progn
          (neotree-dir project-dir)
          (neotree-find file-name))
              (message "Could not find git project root."))))

(define-key evil-normal-state-local-map (kbd "C-n") 'neotree-project-dir)

(add-hook 'neotree-mode-hook
          (lambda ()

            ;; Line numbers are pointless in neovim
            (linum-mode 0)

            ;; Neotree keybindings to override evil mode
            (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "m a") 'neotree-create-node)
            (define-key evil-normal-state-local-map (kbd "m c") 'neotree-copy-node)
            (define-key evil-normal-state-local-map (kbd "m d") 'neotree-delete-node)
            (define-key evil-normal-state-local-map (kbd "m m") 'neotree-rename-node)
            (define-key evil-normal-state-local-map (kbd "r") 'neotree-refresh)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

(add-hook 'erlang-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "C-]") 'edts-find-source-under-point)
            (define-key evil-insert-state-local-map (kbd "C-]") 'edts-find-source-under-point)))

(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist '(("." . "~/.tmp/emacs-saves"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups

(set-face-attribute 'default nil :height 150)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3b0a350918ee819dca209cec62d867678d7dac74f6195f5e3799aa206358a983" "1012cf33e0152751078e9529a915da52ec742dabf22143530e86451ae8378c1a" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
