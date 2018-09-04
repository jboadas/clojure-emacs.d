;; JESUS BOADAS @jboadas jboadas@gmail.com
;; init.el
;;
;; PAQUETES
;;
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)
;; Instala los paquetes si no han sido instalados
(unless (package-installed-p 'web-mode)
  (package-install 'web-mode))
(unless (package-installed-p 'ido-vertical-mode)
  (package-install 'ido-vertical-mode))
(unless (package-installed-p 'ido-completing-read+)
  (package-install 'ido-completing-read+))
(unless (package-installed-p 'flx-ido)
  (package-install 'flx-ido))
(unless (package-installed-p 'smex)
  (package-install 'smex))
(unless (package-installed-p 'smartparens)
  (package-install 'smartparens))
(unless (package-installed-p 'company)
  (package-install 'company))
(unless (package-installed-p 'hl-todo)
  (package-install 'hl-todo))
(unless (package-installed-p 'highlight-parentheses)
  (package-install 'highlight-parentheses))
(unless (package-installed-p 'cider)
  (package-install 'cider))
(unless (package-installed-p 'clj-refactor)
  (package-install 'clj-refactor))
(unless (package-installed-p 'expand-region)
  (package-install 'expand-region))
(unless (package-installed-p 'clojure-mode-extra-font-locking)
  (package-install 'clojure-mode-extra-font-locking))
;;
;; UI
;;
;;quita el beep
(setq ring-bell-function 'ignore)
;; para que se pueda borrar una region por defecto
(delete-selection-mode t)
;; quita los backups de emacs make-backup-file ? vs plural
(setq make-backup-files nil)
;; evitar guardar automaticamente
(setq auto-save-default nil)
;; ancho del tab a 2 espacios
(setq-default tab-width 2)
;; convertir tabs a espacios
(setq-default indent-tabs-mode nil)
;; quitar los prompt largos
(fset 'yes-or-no-p 'y-or-n-p)
;; solo cuando emacs use gui
(when (window-system)
  ;; elimina el toolbar
  (tool-bar-mode -1)
  ;; elimina el tool-bar
  (scroll-bar-mode -1)
  ;; elimina el menu
  (menu-bar-mode -1)
  ;; quita las barras de los costados
  (fringe-mode 0))
;; Formato de la columna de los numeros de linea
(setq linum-format "%4d")
;; para impedir que emacs trunque las palabras
(global-visual-line-mode -1)
;; impide que las lineas se pasen a la linea de abajo
;;(set-default 'truncate-lines nil)
;; some kind of smooth scroll
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)
;; scroll one line at a time (less "jumpy" than defaults)
 ;; one line at a time
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
 ;; don't accelerate scrolling
(setq mouse-wheel-progressive-speed -1)
 ;; scroll window under mouse
(setq mouse-wheel-follow-mouse 't)
;;nombre del frame en el titulo
(setq frame-title-format
  '(:eval
    (if buffer-file-name
        (replace-regexp-in-string
         "\\\\" "/"
         (replace-regexp-in-string
          (regexp-quote (getenv "HOME")) "~"
          (convert-standard-filename buffer-file-name)))
      (buffer-name))))

;; muestra el numero de columna en la barra de estado
(column-number-mode)
;; quita el splash screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
;; elimina el marcador de fin de buffer
(setq-default indicate-empty-lines nil)
;;carga el tema
(load-theme 'deeper-blue)

;; resalta la linea actual del cursor
(global-hl-line-mode 1)
;; el background del la linea
(set-face-background 'hl-line "gray8")
;; para mantener el resaltado de la sintaxis
(set-face-foreground 'highlight nil)
;;cambia el color del cursor
(set-cursor-color "#ffffff")
;;personaliza el cursor
(setq-default cursor-type '(bar . 2))
;; tamaño inicial de la ventana
(when window-system (set-frame-size (selected-frame) 80 24))

;; en modo de programacion activa los numeros de linea
(add-hook 'prog-mode-hook 'linum-mode)

(ido-mode 1)
(ido-everywhere 1)
(setq ido-auto-merge-work-directories-length -1)
(require 'ido-vertical-mode)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)

(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)

(require 'flx-ido)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
;;(setq ido-use-faces nil)

(setq ido-use-faces t)
(set-face-attribute 'ido-vertical-first-match-face nil
                    :background nil
                    :foreground "orange")
(set-face-attribute 'ido-vertical-only-match-face nil
                    :background nil
                    :foreground nil)
(set-face-attribute 'ido-vertical-match-face nil
                    :foreground nil)
(ido-vertical-mode 1)

;; Not needed if you use package.el
(require 'smex) 
;; Can be omitted. This might cause a (minimal) delay
;; when Smex is auto-initialized on its first run.
(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; M-$ ask for a completion, i to add the word to dictionary
;; some keybindings to easy spell check with flyspell

(global-set-key (kbd "<f8>") 'ispell-word) ;; same as M-$
(global-set-key (kbd "C-S-<f8>") 'flyspell-mode)
(global-set-key (kbd "C-M-<f8>") 'flyspell-buffer)
(global-set-key (kbd "C-<f8>") 'flyspell-check-previous-highlighted-word)
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )
(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)

;; Smartparens
(require 'smartparens-config)
(smartparens-global-mode t)
(mapc (lambda (mode)
        (add-hook (intern (format "%s-hook" (symbol-name mode))) 'smartparens-strict-mode))
      sp--lisp-modes)

;;shorcut para expand region
(global-set-key (kbd "C-=") 'er/expand-region)
;; activar el modo de resaltado de TODO
(global-hl-todo-mode t)
;; autocomplete via company mode
(add-hook 'after-init-hook 'global-company-mode)
;;(global-company-mode)
;; delay de company nil para activarlo manualmente
(setq company-idle-delay nil)
;; set the key for company complete
(global-set-key [C-tab] #'company-complete)
;;highlight-parentheses para todos los buffers
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))

(global-highlight-parentheses-mode t)
;; resalta el parentesis que cierra
(show-paren-mode 1)
;; en modo de programacion activa los parentesis de varios colores
;;(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; colores para los parentesis arcoiris
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-scrollbar-bg ((t (:background "#191919"))))
 '(company-scrollbar-fg ((t (:background "#0C0C0C"))))
 '(company-tooltip ((t (:inherit default :background "gray15"))))
 '(company-tooltip-annotation ((t (:inherit default :foreground "#006400" :background "gray15"))))
 '(company-tooltip-annotation-selection ((t (:inherit default :foreground "#00DD00" :background "brown4"))))
 '(company-tooltip-common ((t (:inherit font-lock-constant-face))))
 '(company-tooltip-selection ((t (:inherit font-lock-function-name-face :background "brown4" :foreground "snow1"))))
 '(highlight ((t (:background "dark slate gray"))))
 '(show-paren-match ((t (:background "black" :foreground "green")))))

;; documentacion de cider
(add-hook 'cider-mode-hook 'eldoc-mode)
;; fuentes extras para clojure
(eval-after-load 'clojure-mode '(require 'clojure-mode-extra-font-locking))

;; Conveniently set keys into the sp-keymap, limiting the keybinding to buffers
;; with SP mode activated
(mapc (lambda (info)
        (let ((key (kbd (car info)))
              (function (car (cdr info))))
          (define-key sp-keymap key function)))
      '(("C-M-f" sp-forward-sexp)
        ("C-M-b" sp-backward-sexp)
        ("C-M-d" sp-down-sexp)
        ("C-M-a" sp-backward-down-sexp)
        ("C-S-a" sp-beginning-of-sexp)
        ("C-S-d" sp-end-of-sexp)
        ("C-M-e" sp-up-sexp)
        ("C-M-u" sp-backward-up-sexp)
        ("C-M-t" sp-transpose-sexp)
        ("C-M-n" sp-next-sexp)
        ("C-M-p" sp-previous-sexp)
        ("C-M-k" sp-kill-sexp)
        ("C-M-w" sp-copy-sexp)
        ("M-<delete>" sp-unwrap-sexp)
        ("M-<backspace>" sp-backward-unwrap-sexp)
        ("M-<right>" sp-forward-slurp-sexp)
        ("M-<left>" sp-forward-barf-sexp)
        ("C-M-<left>" sp-backward-slurp-sexp)
        ("C-M-<right>" sp-backward-barf-sexp)
        ("M-D" sp-splice-sexp)
        ("C-M-<delete>" sp-splice-sexp-killing-forward)
        ("C-M-<backspace>" sp-splice-sexp-killing-backward)
        ("C-S-<backspace>" sp-splice-sexp-killing-around)
        ("C-]" sp-select-next-thing-exchange)
        ("C-<left_bracket>" sp-select-previous-thing)
        ("C-M-]" sp-select-next-thing)
        ("M-F" sp-forward-symbol)
        ("M-B" sp-backward-symbol)
        ("H-t" sp-prefix-tag-object)
        ("H-p" sp-prefix-pair-object)
        ("H-s c" sp-convolute-sexp)
        ("H-s a" sp-absorb-sexp)
        ("H-s e" sp-emit-sexp)
        ("H-s p" sp-add-to-previous-sexp)
        ("H-s n" sp-add-to-next-sexp)
        ("H-s j" sp-join-sexp)
        ("H-s s" sp-split-sexp)))

;; This is from authors config, seems to let you jump to the end of the current
;; sexp with paren?
(define-key emacs-lisp-mode-map (kbd ")") 'sp-up-sexp)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-paren-colors (quote ("firebrick1" "gray80" "gray60" "gray40")))
 '(ispell-program-name "/usr/bin/aspell")
 '(package-selected-packages
   (quote
    (magit projectile smex flx-ido ido-completing-read+ ido-vertical-mode web-mode smartparens markdown-mode hl-todo highlight-parentheses expand-region company clojure-mode-extra-font-locking cljr-helm))))

(require 'clj-refactor)

(defun my-clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1)
    ;; for adding require/use/import statements
    ;; This choice of keybinding leaves cider-macroexpand-1 unbound
    (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)
