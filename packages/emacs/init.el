;; Get the package system setup
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-refresh-contents)
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
(use-package hamburg-theme :ensure t)
(use-package yoshi-theme :ensure t)
(use-package monokai-theme :ensure t)
(use-package doom-themes :ensure t)

;; Global settings (defaults)
(setq doom-themes-enable-bold nil
      doom-themes-enable-italic nil
      )

;; Enable custom neotree theme
(doom-themes-neotree-config)  ; all-the-icons fonts must be installed!

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

(defun outdoors() (interactive) (load-theme 'pastelmac))
(defun indoors() (interactive) (load-theme 'monokai))


;;
;; Ensure that the background isn't set, let that come from the console
;;
;; (defun on-frame-open (frame)
;;   (if (not (display-graphic-p frame))
;;     (set-face-background 'default "unspecified-bg" frame)))

;; (defun on-after-init ()
;;   (on-frame-open (selected-frame)))
;;
;; (add-hook 'window-setup-hook 'on-after-init)
;;(add-hook 'after-make-frame-functions 'on-frame-open)

;; (on-frame-open (selected-frame))

;; Just why would you do anything else? :D
(use-package evil
  :ensure t
  :init (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (defalias #'forward-evil-word #'forward-evil-symbol)
  )


;; Gimme Haskell
(package-install 'intero)
(add-hook 'haskell-mode-hook 'intero-mode)

;; Gimme some Erlang!
(use-package erlang
  :ensure t
  :init
  (setq erlang-electric-commands t)
  )
(use-package edts :ensure t)
(use-package lfe-mode :ensure t)
(use-package kerl :ensure t)


;; Elm
(use-package elm-mode :ensure t)
(add-to-list 'company-backends 'company-elm)
(setq elm-format-on-save t)


;; Typescript
(use-package typescript-mode :ensure t)


;; Rust
(use-package rust-mode :ensure t)
(use-package cargo :ensure t)
(use-package toml-mode :ensure t)

(use-package purescript-mode :ensure t)
(use-package psc-ide :ensure t)

(add-hook 'purescript-mode-hook
          (lambda ()
            (psc-ide-mode)
            (company-mode)
            ;;(flycheck-mode)
            (turn-on-purescript-indentation)))


;; Multiple Major Modes for web content
(use-package web-mode :ensure t)
;; (use-package multi-web-mode :ensure t)
;; (setq mweb-default-major-mode 'html-mode)
;; (setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
;;                   (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
;;                   (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
;; (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
;; (multi-web-global-mode 1)


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

;; (set-face-attribute 'default nil :height 150)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a566448baba25f48e1833d86807b77876a899fc0c3d33394094cf267c970749f" "9d9fda57c476672acd8c6efeb9dc801abea906634575ad2c7688d055878e69d6" "3a3de615f80a0e8706208f0a71bbcc7cc3816988f971b6d237223b6731f91605" "8891c81848a6cf203c7ac816436ea1a859c34038c39e3cf9f48292d8b1c86528" "f78de13274781fbb6b01afd43327a4535438ebaeec91d93ebdbba1e3fba34d3c" "9d4787fa4d9e06acb0e5c51499bff7ea827983b8bcc7d7545ca41db521bd9261" "f81a9aabc6a70441e4a742dfd6d10b2bae1088830dc7aba9c9922f4b1bd2ba50" "715fdcd387af7e963abca6765bd7c2b37e76154e65401cd8d86104f22dd88404" "3b0a350918ee819dca209cec62d867678d7dac74f6195f5e3799aa206358a983" "1012cf33e0152751078e9529a915da52ec742dabf22143530e86451ae8378c1a" default)))
 '(package-selected-packages
   (quote
    (zoom-frm yoshi-theme yaml-mode web-mode use-package typescript-mode toml-mode textmate terraform-mode smex scion rainbow-delimiters railscasts-theme purescript-mode psc-ide projectile pastelmac-theme neotree multi-web-mode monokai-theme magit linum-relative lfe-mode kerl intero helm-swoop hamburg-theme flx-ido evil eproject elm-mode edts editorconfig doom-themes cider cargo ag)))
 '(safe-local-variable-values (quote ((allout-layout . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file)
(define-key evil-normal-state-map (kbd "C-n") 'neotree-project-dir)
