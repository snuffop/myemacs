;;; $doomdir/config.el --- Marty Buchaus' Emacs Config File -*- lexical-binding: t; -*-

;;; Default and initial settings
;;;; Server
(server-start)))

(require 'use-package)

(setq use-package-always-ensure t)

;;;; Garbage Collection

(use-package gcmh
  :config
  (gcmh-mode 1))

(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;;;; Native Compile
  (if (boundp 'comp-deferred-compilation)
      (setq comp-deferred-compilation nil)
      (setq native-comp-deferred-compilation nil))
  (setq load-prefer-newer noninteractive)

;;;  Set Defaults
(setq user-full-name "Marty Buchaus")
(setq user-mail-address "marty@dabuke.com")

(setq-default auth-sources '("~/.authinfo.gpg"))
(setq-default delete-by-moving-to-trash t)
(setq-default display-time-24hr-format t)          ; I wonder what this does
(setq-default display-time-load-average nil)
(setq-default doom-scratch-initial-major-mode 'lisp-interaction-mode)  ; Make the scratch buffer start in lisp mode
(setq-default enable-local-variables t)            ; allow for reading the local variables file
(setq-default epg-gpg-program "/usr/bin/gpg2")
(setq-default evil-want-fine-undo t)               ; by default while in insert all changes are one big blob. be more granular
(setq-default history-length 1000)
(setq-default left-margin-width 1)                 ; Define new widths
(setq-default prescient-history-length 1000)
(setq-default right-margin-width 2)                ; Define new widths.
(setq-default truncate-string-ellipsis "…")        ; unicode ellispis are nicer than "...", and also save /precious/ space
(setq-default warning-minimum-level :emergency)
(setq-default window-combination-resize t)
(setq-default x-stretch-cursor t)
(setq auto-save-default t)                         ; nobody likes to loose work, i certainly don't
(setq confirm-kill-emacs nil)                      ; stop hounding me and quit
(setq inhibit-compacting-font-caches t)
(setq password-cache-expiry nil)                   ; i can trust my computers ... can't i?
(setq read-process-output-max (* 1024 1024))
(setq scroll-margin 2)                             ; it's nice to maintain a little margin
(setq undo-limit 80000000)                         ; raise undo-limit to 80mb

;;; UI
;;;; Fonts
  (set-face-attribute 'default nil
    :font "FiraCode Nerd Font"
    :height 130
    :weight 'medium)
  (set-face-attribute 'variable-pitch nil
    :font "Ubuntu"
    :height 170
    :weight 'medium)
  (set-face-attribute 'fixed-pitch nil
    :font "FiraCode Nerd Font"
    :height 130
    :weight 'medium)
  ;; Makes commented text and keywords italics.
  ;; This is working in emacsclient but not emacs.
  ;; Your font must have an italic face available.
  (set-face-attribute 'font-lock-comment-face nil
    :slant 'italic)
  (set-face-attribute 'font-lock-keyword-face nil
    :slant 'italic)
  ;; Uncomment the following line if line spacing needs adjusting.
  (setq-default line-spacing 0.12)
  ;; Needed if using emacsclient. Otherwise, your fonts will be smaller than expected.
  (set-face-attribute 'default nil :font "FiraCode Nerd Font" :height 130)
  ;; changes certain keywords to symbols, such as lamda!
  (setq global-prettify-symbols-mode t)


;;;; Theme

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t)
  (setq doom-themes-padded-modeline t)
  (setq doom-themes-enable-italic t))
(load-theme 'doom-dracula t)
(doom-themes-org-config)
(doom-themes-visual-bell-config)

;;;; Mode Line
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom (( doom-modeline-height 30)
	   (doom-modeline-mu4e t)
	   (doom-modeline-gnus nil)))

;;;; Line Numbers
(global-display-line-numbers-mode 1)
(global-visual-line-mode t)
;;; Keybindings & Evil
;;;; EVIL
(use-package evil
  :init
  (setq evil-want-integrationt t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  :config
  (evil-mode 1)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))
;;;;  Evil Collection
(use-package evil-collection
  :after evil
  :custom
  (evil-collection-outline-bind-tab-p nil)
  :config
  (evil-collection-init))

;;;;  Evil Tutor
(use-package evil-tutor)
;;; Which-key

(use-package which-key
  :diminish
  :init (which-key-mode)
  :config 
  (setq which-key-side-window-location 'bottom
        which-key-sort-order #'which-key-key-order-alpha
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10
        which-key-side-window-max-height 0.25
        which-key-idle-delay 0.3
        which-key-max-description-length 25
        which-key-allow-imprecise-window-fit nil
        which-key-show-early-on-C-h t
        which-key-separator " → " ))
;;; General-el
;;;; Package 
(use-package general
  :config
  (general-evil-setup t))

;;;; bindings

(nvmap :keymaps 'override :prefix "SPC"
       "SPC"   '(execute-extended-command :which-key "M-x")
       "h r r" '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :which-key "Reload emacs config")
       "t t"   '(toggle-truncate-lines :which-key "Toggle truncate lines"))  

(nvmap :keymaps 'override :prefix "SPC"
  ;; B
       "b b"   '(consult-buffer :which-key "Consult Buffer")
       "b B"   '(ibuffer :which-key "Ibuffer")
       "b c"   '(clone-indirect-buffer-other-window :which-key "Clone indirect buffer other window")
       "b k"   '(kill-current-buffer :which-key "Kill current buffer")
       "b n"   '(next-buffer :which-key "Next buffer")
       "b p"   '(previous-buffer :which-key "Previous buffer")
       "b B"   '(ibuffer-list-buffers :which-key "Ibuffer list buffers")
       "b K"   '(kill-buffer :which-key "Kill buffer")
;; m
       "m *"   '(org-ctrl-c-star :which-key "Org-ctrl-c-star")
       "m +"   '(org-ctrl-c-minus :which-key "Org-ctrl-c-minus")
       "m ."   '(counsel-org-goto :which-key "Counsel org goto")
       "m e"   '(org-export-dispatch :which-key "Org export dispatch")
       "m f"   '(org-footnote-new :which-key "Org footnote new")
       "m h"   '(org-toggle-heading :which-key "Org toggle heading")
       "m i"   '(org-toggle-item :which-key "Org toggle item")
       "m n"   '(org-store-link :which-key "Org store link")
       "m o"   '(org-set-property :which-key "Org set property")
       "m t"   '(org-todo :which-key "Org todo")
       "m x"   '(org-toggle-checkbox :which-key "Org toggle checkbox")
       "m B"   '(org-babel-tangle :which-key "Org babel tangle")
       "m I"   '(org-toggle-inline-images :which-key "Org toggle inline imager")
       "m T"   '(org-todo-list :which-key "Org todo list")
       "o a"   '(org-agenda :which-key "Org agenda")
       )


;;; Global Key Bindings

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; ctl-x
(define-key ctl-x-map  "p" (cons "project" project-prefix-map))
(define-key ctl-x-map  "r" (cons "register" ctl-x-r-map))
(define-key ctl-x-map  "R" '("Reload emacs Config" . (lambda () (interactive) (load-file "~/.emacs.d/init.el"))))

(define-key project-prefix-map "/" '("Project Search RH" . consult-ripgrep))

(define-key evil-normal-state-map "gz" '("zoxide jump" . zoxide-find-file))
(define-key help-map "h"    #'helpful-at-point)

;;; Completion
;;;; Vertico
;;
(use-package vertico
  :init
  (setq vertico-scroll-margin 0)
  (setq vertico-count 20)
  (setq vertico-resize t)
  (setq vertico-cycle t)
  (vertico-mode)
  )

;;;; Save History
(use-package savehist
  :init
  (savehist-mode))

;;;; Emacs Setup
(use-package emacs
  :init
  (setq completion-cycle-threshold 3)
  (setq tab-always-indent 'complete)
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  (setq read-extended-command-predicate
        #'command-completion-default-include-p)
  (setq enable-recursive-minibuffers t))

;;;; Marginalia

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

;;;; Consult

;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ("<help> a" . consult-apropos)            ;; orig. apropos-command
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key (kbd "M-.")
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
  ;; There are multiple reasonable alternatives to chose from.
  ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
  ;;;; 2. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
  ;;;; 3. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
  ;;;; 4. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
)

;;;; Embard
;;;;
(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.

;;;; Embark consult

(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;;;; orderless

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;;;; corfu

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-separator ?\s)          ;; Orderless field separator
  (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  (corfu-preview-current nil)    ;; Disable current candidate preview
  (corfu-preselect-first nil)    ;; Disable candidate preselection
  (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  (corfu-echo-documentation nil) ;; Disable documentation in the echo area
  (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `corfu-excluded-modes'.
  :init
  (global-corfu-mode))

;;;; cape

(use-package cape
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :bind (("C-c p p" . completion-at-point) ;; capf
         ("C-c p t" . complete-tag)        ;; etags
         ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c p h" . cape-history)
         ("C-c p f" . cape-file)
         ("C-c p k" . cape-keyword)
         ("C-c p s" . cape-symbol)
         ("C-c p a" . cape-abbrev)
         ("C-c p i" . cape-ispell)
         ("C-c p l" . cape-line)
         ("C-c p w" . cape-dict)
         ("C-c p \\" . cape-tex)
         ("C-c p _" . cape-tex)
         ("C-c p ^" . cape-tex)
         ("C-c p &" . cape-sgml)
         ("C-c p r" . cape-rfc1345))
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-history)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-tex)
  (add-to-list 'completion-at-point-functions #'cape-sgml)
  (add-to-list 'completion-at-point-functions #'cape-rfc1345)
  (add-to-list 'completion-at-point-functions #'cape-abbrev)
  (add-to-list 'completion-at-point-functions #'cape-ispell)
  (add-to-list 'completion-at-point-functions #'cape-dict)
  (add-to-list 'completion-at-point-functions #'cape-symbol)
  (add-to-list 'completion-at-point-functions #'cape-line)
)


;;; Modules & Packages
;;;; All the Icons

  (use-package all-the-icons)

;;;; AutoInsert
(use-package yasnippet)
(yas-global-mode 1)

(defun marty/autoinsert-yas-expand ()
  "Auto Insert Funtion that works for me."
  (let ((template ( buffer-string)))
    (delete-region (point-min) (point-max))
    (yas-expand-snippet template)
    (evil-insert-state)))

(use-package autoinsert
  :init
  (setq auto-insert-query nil)
  (setq auto-insert-directory (expand-file-name "templates" user-emacs-directory))
  (add-hook 'find-file-hook 'auto-insert)
  (auto-insert-mode 1)
  :config
  (define-auto-insert "\\.html?$" ["default.html" marty/autoinsert-yas-expand])
  (define-auto-insert "\\.org" ["default.org" marty/autoinsert-yas-expand])
  (define-auto-insert "\\.sh" ["default.sh" marty/autoinsert-yas-expand])
  (define-auto-insert "\\.el" ["default.el" marty/autoinsert-yas-expand])
  (define-auto-insert "Roam/.+\\.org?$" ["org-roam-mode/defaultRoam.org" marty/autoinsert-yas-expand])
  (define-auto-insert "masons/[^/].+\\.org?$" ["org-mode/masonsMeetingMinuets.org" marty/autoinsert-yas-expand])
  (define-auto-insert "daily/[^/].+\\.org?$" ["org-roam-mode/defaultRoamDaily.org" marty/autoinsert-yas-expand]))

;;;; Dired

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h"  'dired-single-up-directory
    "l"  'dired-single-buffer

;;;;; Dired Single
(use-package dired-single)

;;;;; All the Dired icons
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

;;;;; Hide dot files
(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

;;;;; Dired-x
(use-package dired-x
  :config
  ;; Make dired-omit-mode hide all "dotfiles"
  (setq dired-omit-files
        (concat dired-omit-files "\\|^\\..*$")))

;;;;; diredfl
;; Addtional syntax highlighting for dired
(use-package diredfl
  :hook
  ((dired-mode . diredfl-mode)
   ;; highlight parent and directory preview as well
   (dirvish-directory-view-mode . diredfl-mode))
  :config
  set-face-attribute 'diredfl-dir-name nil :bold t)

;;;; Eglot
(use-package eglot)


;;;; Files
  (use-package sudo-edit)

;;;; Helpful
(use-package helpful)

;;;; Magit
(use-package magit)
;;;;; forge
(use-package forge
  :after magit)
;;;;; magit todos
(use-package magit-todos
  :after magit)


;;;; Nginx
(use-package nginx-mode
  :command (nginx-mode)
  :defer t)

;;;; Outshine

(use-package outshine
  :hook ((prog-mode . outshine-minor-mode)
	 (outline-minor-mode . outshine-mode))
  :bind (:map emacs-lisp-mode-map
              ("TAB" . #'outshine-cycle))
  :config
  (defvar outline-minor-mode-prefix "\M-#"))

;;;; Paperless
(use-package paperless
  :commands (paperless)
  :init
  (require 'org-paperless)
  (setq paperless-capture-directory "~/Nextcloud/Documents/INBOX")
  (setq paperless-root-directory "~/Nextcloud/Documents"))

;;;; Systemd

(use-package systemd
  :commands (systemd-mode)
  :mode "\\.service\\'")

;;;; wakatime

(defun marty/startwakatime ()
  "Start wakatime mode."
  (interactive)
  (setq wakatime-api-key (auth-source-pass-get 'secret "Application/wakatime/apikey"))
  (global-wakatime-mode))

(use-package wakatime-mode
  :config
  (cond (IS-MAC (setq wakatime-cli-path "/usr/local/bin/wakatime-cli"))
        (IS-LINUX (setq wakatime-cli-path "/usr/bin/wakatime"))))

;;;; Zoxide
(use-package zoxide)

(defun dired-jump-with-zoxide (&optional other-window)
  (interactive "P")
  (zoxide-open-with nil (lambda (file) (dired-jump other-window file)) t))

;;; Languages
;;;; Ansible
(use-package ansible)
(add-hook 'yaml-mode-hook #'(lambda () (ansible 1)))
(global-set-key (kbd "C-c b") 'ansible-decrypt-buffer)
(global-set-key (kbd "C-c g") 'ansible-encrypt-buffer)

;;;; Markdown
(use-package markdown-mode)

;;;; Org
;;;;; Hooks

  (add-hook 'org-mode-hook 'org-indent-mode)

;;;;; Pre and Default

(setq org-directory (expand-file-name "~/Nextcloud/Notes/org/"))
(setq org-contacts-files (expand-file-name "contacts.org" org-directory))
(setq org-default-notes-file (concat org-directory "0mobile.org"))
(setq org-download-image-dir "~/Nextcloud/Notes/images/")
(setq org-id-locations-file "~/Nextcloud/Notes/org-id-locations")
(setq org-persp-startup-org-file "~/Nextcloud/Notes/org/0mobile.org")
(setq org-projectile-file "todo.org")

(setq org-edit-src-content-indentation 0)
(setq org-hide-emphasis-markers t)
(setq org-id-link-to-org-use-id t)
(setq org-image-actual-width nil)
(setq org-src-preserve-indentation nil)
(setq org-src-tab-acts-natively t)
(setq org-startup-with-inline-images t)


;;;;; Clocking

  (setq org-clock-into-drawer "CLOCKING")
  (setq org-clock-out-remove-zero-time-clocks t)
  (setq org-clock-sound "~/Nextcloud/Music/sounds/shipsBell.wav")

;;;;; Logging
  (setq org-log-done t)
  (setq org-log-into-drawer t)
  (setq org-icalendar-store-UID t)
  (setq org-id-track-globally t)

;;;;; Refile Targets
(setq org-refile-targets '((nil :maxlevel . 3)
                           (org-agenda-files :maxlevel . 5)))

(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)
;;;;; Tag List

  (setq org-tag-alist (quote
                       ((:startgroup)
                        ("@ASITS"     . ?A)
                        ("@BillPay"   . ?B)
                        ("@RedEarth"  . ?D)
                        ("@Email"     . ?E)
                        ("@Joyent"    . ?J)
                        ("@Jazney"    . ?j)
                        ("@Outside"   . ?o)
                        ("@PhoneCall" . ?p)
                        ("@Personal"  . ?P)
                        ("@Reading"   . ?r)
                        ("@Shopping"  . ?s)
                        ("@errand"    . ?e)
                        ("@home"      . ?h)
                        ("@inside"    . ?i)
                        ("@masons"    . ?M)
                        ("@music"     . ?m)
                        ("@office"    . ?O)
                        ("@system"    . ?x)
                        ("2637E20th")
                        (:endgroup)
                        ("CANCELLED"  . ?C)
                        ("DRAFT"      . ?D)
                        ("FLAGGED"    . ?F)
                        ("HOLD"       . ?H)
                        ("IDEA"       . ?I)
                        ("NOTE"       . ?N)
                        ("PROJECT"    . ?P)
                        ("WAITING"    . ?w)
                        ("WORK"       . ?W))))

;;;;; Org Agenda


(setq  marty/org-agenda-files (list
                               (expand-file-name "Tasks.org" org-directory)
                               (expand-file-name "Habits.org" org-directory)
                               (expand-file-name "contacts.org" org-directory)
                               (expand-file-name "Projects.org" org-directory)
                               (expand-file-name "Someday.org" org-directory)
                               (expand-file-name "0mobile.org" org-directory)
                               (expand-file-name "joyent-calendar.org" org-directory)
                               (expand-file-name "snuffop-calendar.org" org-directory)
                               (expand-file-name "Joyent/Joyent_Tasks.org" org-directory)
                               (expand-file-name "SHOffice.org" org-directory)))

;;;;; Org Bullets
  (use-package org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;;;;; Todo Keywords

  (setq org-todo-keywords
        '((sequence "TODO(t)"
           "NEXT(n!)"
           "STARTED(s!)"
           "BLOCKED(b@/!)"
           "TODELEGATE(g@/!)"
           "DELEGATED(D@/!)"
           "FOLLOWUP(f@/!)"
           "TICKLE(T!)"
           "|"
           "CANCELLED(c@)"
           "DONE(d@)")))


;;;;; Capture Templates
;;;;;; **** Doct
(use-package doct
  :after org
  :commands (doct))

  (defun +doct-icon-declaration-to-icon (declaration)
    "Convert :icon declaration to icon"
    (let ((name (pop declaration))
          (set  (intern (concat "all-the-icons-" (plist-get declaration :set))))
          (face (intern (concat "all-the-icons-" (plist-get declaration :color))))
          (v-adjust (or (plist-get declaration :v-adjust) 0.01)))
      (apply set `(,name :face ,face :v-adjust ,v-adjust))))

  (defun +doct-iconify-capture-templates (groups)
    "Add declaration's :icon to each template group in GROUPS."
    (let ((templates (doct-flatten-lists-in groups)))
      (setq doct-templates (mapcar (lambda (template)
                                     (when-let* ((props (nthcdr (if (= (length template) 4) 2 5) template))
                                                 (spec (plist-get (plist-get props :doct) :icon)))
                                       (setf (nth 1 template) (concat (+doct-icon-declaration-to-icon spec)
                                                                      "\t"
                                                                      (nth 1 template))))
                                     template)
                                   templates))))

  (setq doct-after-conversion-functions '(+doct-iconify-capture-templates))

;;;;;; **** Template Definition
  (setq org-capture-templates
        (doct `(("Task"
                 :keys "t"
                 :icon ("tag" :set "octicon" :color "cyan")
                 :file "~/Nextcloud/Notes/org/0mobile.org"
                 :prepend t
                 :headline "Inbox"
                 :template-file "~/.config/myemacs/templates/org-mode/todo.org")

                ("Contact"
                 :keys "c"
                 :icon ("male" :set "faicon" :color "yellow")
                 :file "~/Nextcloud/Notes/org/contacts.org"
                 :headline "General"
                 :template-file "~/.config/myemacs/templates/org-mode/contact.org")

                ("Bullets"
                 :keys "b"
                 :icon ("sticky-note" :set "faicon" :color "blue")
                 :children (("Bullets"
                             :keys "b"
                             :icon ("sticky-note" :set "faicon" :color "blue")
                             :file "~/Nextcloud/Notes/org/Joyent/Bullets.org"
                             ;; :datetree t
                             :function org-reverse-datetree-goto-date-in-file)
                            ("Gage"
                             :keys "g"
                             :icon ("sticky-note" :set "faicon" :color "green")
                             :file "~/Nextcloud/Notes/org/Joyent/joyent_gage_project.org"
                             :function org-reverse-datetree-goto-date-in-file)
                            ("Backup-Service"
                             :keys "k"
                             :icon ("sticky-note" :set "faicon" :color "yellow")
                             :file "~/Nextcloud/Notes/org/Joyent/joyent_database_backup_service.org"
                             :function org-reverse-datetree-goto-date-in-file)
                            ))

                ("Simple org-popup"
                 :keys "s"
                 :icon ("sticky-note" :set "faicon" :color "red")
                 :file "~/Nextcloud/Notes/org/0mobile.org"
                 :immediate-finish t
                 :prepend t
                 :headline "Inbox"
                 :template-file "~/.config/myemacs/templates/org-mode/simple.org")

                ("Remember-mutt"
                 :keys "R"
                 :icon ("home" :set "octicon" :color "cyan")
                 :file "~/Nextcloud/Notes/org/0mobile.org"
                 :headline "Mail"
                 :template-file "~/.config/myemacs/templates/org-mode/mail.org")

                ("Protocol"
                 :keys "P"
                 :file "~/Nextcloud/Notes/org/0mobile.org"
                 :icon ("tag" :set "octicon" :color "cyan")
                 :headline "Inbox"
                 :children (("Read"
                             :keys "r"
                             :headline "Read Later"
                             :immediate-finish t
                             :template-file "~/.config/myemacs/templates/org-mode/protocol-read-later.org")
                            ("Today"
                             :keys "t"
                             :template-file "~/.config/myemacs/templates/org-mode/protocol-today.org")
                            ("Important"
                             :keys "i"
                             :template-file "~/.config/myemacs/templates/org-mode/protocol-important.org")))

                ("Email Workflow"
                 :keys "m"
                 :icon ("mail" :set "octicon" :color "yellow")
                 :file "~/Nextcloud/Notes/org/0mobile.org"
                 :children (("Follow Up"
                             :keys "f"
                             :headline "Follow Up"
                             :template ("* TODO Follow up with %:fromname on %:subject"
                                        "SCHEDULED:%t"
                                        "%a"
                                        "%i"))
                            ("Auto Follow Up"
                             :keys "a"
                             :immediate-finish t
                             :headline "Follow Up"
                             :template ("* TODO Follow up with %:fromname on %:subject"
                                        "%a"

                                        "%i"))
                            ("Follow Up With Deadline"
                             :keys "F"
                             :headline "Follow Up"
                             :template ("* TODO Follow up with %:fromname on %:subject"
                                        "SCHEDULED:%t"
                                        "DEADLINE:%(org-insert-time-stamp (org-read-date nil t \"+2d\"))"
                                        "%a"
                                        "%i"))
                            ("Read Later"
                             :keys "r"
                             :headline "Read Later"
                             :immediate-finish t
                             :tetmplate ("* TODO Read Later on %:subject"
                                         "SCHEDULED:%t"
                                         "%a"
                                         "%i")
                             ))))))

  (setq org-protocol-default-template-key "t")

;;;;; Roam
;;;;;; **** emacsSQL
(use-package emacsql-sqlite3)

;;;;;; **** Roam

(use-package org-roam
  :after org
  :custom
  (setq org-roam-directory (expand-file-name "~/Nextcloud/Notes/org/"))
  (setq org-roam-dailies/directory "daily/")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n n" . transient-roam-jump)
         ;; Dailies
         ("C-c n d t" . org-roam-dailies-goto-today)
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (setq org-roam-mode-selections
        (list #'org-roam-backlinks-insert-section
              #'org-roam-reflinks-insert-section
              #'org-roam-unlinked-references-insert-section))

  (setq org-id-extra-files (org-roam-list-files))
  (setq org-roam-completion-everywhere t)
  (setq org-roam-database-connector 'sqlite3)
  (setq org-roam-db-gc-threshold most-positive-fixnum)

;;;;;;; Org-roam popup rules

;;  (setq +org-roam-open-buffer-on-find-file nil)

;;;;;;; org-roam hooks

  ;; hook to be run whenever an org-roam capture completes
  (add-hook 'org-roam-capture-new-node-hook #'marty/add-other-auto-props-to-org-roam-properties)

;;;;;;; Org-roam capture templates

  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :target (file+olp "%<%Y-%m-%d>.org" ("Journal"))
           :empty-lines-after 1 )
          ("t" "Tasks" entry
           "** TODO %? "
           :target (file+olp "%<%Y-%m-%d>.org" ("Tasks"))
           :empty-lines-after 1 )
          ("y" "Joyent" entry
           "** %<%H:%M> %?"
           :target (file+olp "%<%Y-%m-%d>.org" ("Joyent"))
           :empty-lines-after 1)
          ("j" "Journal" entry
           "** %<%H:%M> %?"
           :target (file+olp "%<%Y-%m-%d>.org" ("Journal"))
           :empty-lines-after 1)))

  (setq org-roam-capture-templates
        '(("d" "default" plain
           (file "~/.config/doom/templates/org-roam-mode/default-capture-entry.org")
           :target (file+head "${slug}.org" "#+TITLE: ${title}\n#+category: ${title}")
           :immediate-finish t
           :unnarrowed t)
          ("j" "Joyent" plain
           (file "~/.config/doom/templates/org-roam-mode/joyent-entry.org")
           :target (file+head "Joyent/${slug}.org" "#+TITLE: ${title}\n#+filetags: Joyent\n#+category: Joyent\n")
           :unnarrowed t)
          ("t" "tipjar" plain
           (file "~/.config/doom/templates/org-roam-mode/tipjar-entry.org")
           :target (file+head "TipJar/${slug}.org" "#+TITLE: ${title}\n#+filetags: tipjar\n#+category: tipjar\n")
           :unnarrowed t)
          ("p" "People" plain
           (file "~/.config/doom/templates/org-roam-mode/people-entry.org")
           :target (file+head "People/${slug}.org" "#+TITLE: ${title}\n#+category: people\n#+filetags: :people:\n")
           :unnarrowed t)))

  (require 'org-roam-protocol)
  (setq org-roam-capture-ref-templates
        '(("r" "ref" plain (function org-roam-capture--get-point)
           "%?"
           :file-name "${slug}"
           :head "#+TITLE: ${title}
,#+ROAM_KEY: ${ref}"
           :unnarrowed t)))

;;;;;;; Add aditional properties

  (defun marty/add-other-auto-props-to-org-roam-properties ()
    ;; if the file already exists, don't do anything, otherwise...
    (unless (file-exists-p (buffer-file-name))
      ;; if there's also a CREATION_TIME property, don't modify it
      (unless (org-find-property "CREATION_TIME")
        ;; otherwise, add a Unix epoch timestamp for CREATION_TIME prop
        ;; (this is what "%s" does - see http://doc.endlessparentheses.com/Fun/format-time-string )
        (org-roam-property-add
         (format-time-string "%s"
                             (nth 5
                                  (file-attributes (buffer-file-name))))
         "CREATION_TIME"))
      (unless (org-find-property "ORG_CREATION_TIME")
        (org-roam-property-add
         (format-time-string "[%Y-%m-%d %a %H:%M:%S]"
                             (nth 5
                                  (file-attributes (buffer-file-name))))
         "ORG_CREATION_TIME"))
      ;; similarly for AUTHOR and MAIL properties
      (unless (org-find-property "AUTHOR")
        (org-roam-property-add user-full-name "AUTHOR"))
      (unless (org-find-property "MAIL")
        (org-roam-property-add user-mail-address "MAIL"))))

;;;;;;; Dailies agenda

  (defun my/org-roam-filter-by-tag (tag-name)
    (lambda (node)
      (member tag-name (org-roam-node-tags node))))

  (defun my/org-roam-list-notes-by-tag (tag-name)
    (mapcar #'org-roam-node-file
            (seq-filter
             (my/org-roam-filter-by-tag tag-name)
             (org-roam-node-list))))

  (defun my/org-roam-recent (days)
    "Return list of files modified in the last DAYS."
    (let ((mins (round (* 60 24 days))))
      (split-string
       (shell-command-to-string
        (format
         "find %s -name \"*.org\" -mmin -%s"
         org-roam-directory mins)))))

  (defun my/org-roam-refresh-agenda-list ()
    (interactive)
    (setq org-agenda-files nil)
    ;; (setq org-agenda-files (delete-dups (append (my/org-roam-list-notes-by-tag "Project") (my/org-roam-recent 30) marty/org-agenda-files ))))
    (setq org-agenda-files (delete-dups (append (my/org-roam-list-notes-by-tag "Project") marty/org-agenda-files ))))


  (my/org-roam-refresh-agenda-list)

  (advice-add 'org-roam-db-update-file :after #'my/org-roam-refresh-agenda-list)
  (advice-add 'org-roam-db-sync :after #'my/org-roam-refresh-agenda-list)

;;;;;;; Dailies graphics link

  (defun marty/org-roam-dailies-graphicslink ()
    " Set the Graphics Link to Today in the Pictures folder that maid pushes to."
    (interactive)
    (let* ((year  (string-to-number (substring (buffer-name) 0 4)))
           (month (string-to-number (substring (buffer-name) 5 7)))
           (day   (string-to-number (substring (buffer-name) 8 10)))
           (datim (encode-time 0 0 0 day month year)))
      (format-time-string "[[/home/marty/Nextcloud/Pictures/2020 - 2029/%Y/%0m/Daily/%d][Graphics Link]]" datim)))

;;;;;;; Dailies title

  (defun marty/org-roam-dailies-title ()
    (interactive)
    (let* ((year  (string-to-number (substring (buffer-name) 0 4)))
           (month (string-to-number (substring (buffer-name) 5 7)))
           (day   (string-to-number (substring (buffer-name) 8 10)))
           (datim (encode-time 0 0 0 day month year)))
      (format-time-string "%A, %B %d %Y" datim)))

;;;;;;; Dailies todo schedule

  (defun marty/org-roam-dailies-todo-schedule ()
    " Set the Date for the todo's in the dailies template "
    (interactive)
    (let* ((year  (string-to-number (substring (buffer-name) 0 4)))
           (month (string-to-number (substring (buffer-name) 5 7)))
           (day   (string-to-number (substring (buffer-name) 8 10)))
           (datim (encode-time 0 0 0 day month year)))
      (format-time-string "SCHEDULED: [%Y-%m-%d %a 10:00]" datim)))

;;;;;;; Dailies todo deadline

  (defun marty/org-roam-dailies-todo-deadline ()
    " Set the Date for the todo's in the dailies template "
    (interactive)
    (let* ((year  (string-to-number (substring (buffer-name) 0 4)))
           (month (string-to-number (substring (buffer-name) 5 7)))
           (day   (string-to-number (substring (buffer-name) 8 10)))
           (datim (encode-time 0 0 0 day month year)))
      (format-time-string "DEADLINE: [%Y-%m-%d %a 20:00]" datim)))

;;;;;;; Insert immediate
  ;; https://systemcrafters.net/build-a-second-brain-in-emacs/5-org-roam-hacks/

  (defun org-roam-node-insert-immediate (arg &rest args)
    (interactive "P")
    (let ((args (cons arg args))
          (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                    '(:immediate-finish t)))))
      (apply #'org-roam-node-insert args)))

;;;;;; Move to today (Archive)

  ;; Move Todo's to dailies when done
  (defun marty/org-roam-move-todo-to-today ()
    (interactive)
    (let ((org-refile-keep nil) ;; Set this to t to copy the original!
          (org-roam-dailies-capture-templates
           '(("t" "tasks" entry "%?"
              :if-new (file+olp "%<%Y-%m-%d>.org" ("Tasks")))))
          (org-after-refile-insert-hook #'save-buffer)
          today-file
          pos)
      (save-window-excursion
        (org-roam-dailies--capture (current-time) t)
        (setq today-file (buffer-file-name))
        (setq pos (point)))

      ;; Only refile if the target file is different than the current file
      (unless (equal (file-truename today-file)
                     (file-truename (buffer-file-name)))
        (org-refile nil nil (list "Tasks" today-file nil pos)))))



;;;;;;; END Package after org-roam
  )


;;;;; consult-org-roam

(use-package consult-org-roam
  :after org-roam
  :init
  (require 'consult-org-roam)
  ;; Activate the minor-mode
  (consult-org-roam-mode 1)
  :custom
  (consult-org-roam-grep-func #'consult-ripgrep)
  :config
  ;; Eventually suppress previewing for certain functions
  (consult-customize
   consult-org-roam-forward-links
   :preview-key (kbd "M-.")))


;;;;; transient roam jump

(defun transient-roam-jump ()
  "Load the Transient menu for roam."
  (interactive)
  (roam-jump))

(with-eval-after-load 'transient
  (transient-define-prefix roam-jump ()
    " Roam Sub Menu"
    ["Roam Transient"
     ["Roam Base"
      ("/" "RG Search"           consult-org-roam-search)
      ("F" "Find Reference"      org-roam-ref-find )
      ("I" "Insert (orig)"       org-roam-node-insert )
      ("M" "Buffer dedicated"    org-roam-buffer-display-dedicated )
      ("a" "Archive to daily"    marty/org-roam-move-todo-to-today )
      ("b" "Show Buffer"         org-roam-buffer )
      ("g" "Roam graph"          org-roam-graph )
      ("i" "Insert immediate"    org-roam-node-insert-immediate )
      ("j" "Capture today"       org-roam-dailies-capture-today)
      ("m" "Buffer toggle"       org-roam-buffer-toggle)
      ("n" "Find Node"           org-roam-node-find)
      ("r" "Roam refile"         org-roam-refile)
      ("s" "Sync DB"             org-roam-db-sync)]
     ["Roam Dailies"
      ("d-" "Find Directory"     org-roam-dailies-find-directory)
      ("dT" "Tomorrow"           org-roam-dailies-goto-tomorrow)
      ("dd" "Date"               org-roam-dailies-goto-date)
      ("dn" "Next note"          org-roam-dailies-goto-next-note)
      ("dp" "Previous note"      org-roam-dailies-goto-previous-note)
      ("dt" "Today"              org-roam-dailies-goto-today)
      ("dy" "Yesterday"          org-roam-dailies-goto-yesterday)]
     ["Consult Capture"
      ("cf" "Consult Find File"  consult-org-roam-file-find)
      ("cb" "Consult Backlinks"  consult-org-roam-backlinks)
      ("cT" "Capture tomorrow"   org-roam-dailies-capture-tomorrow)
      ("cc" "Capture"            org-roam-capture)
      ("cd" "Capture by date"    org-roam-dailies-capture-date)
      ("cy" "Capture yesterday"  org-roam-dailies-capture-yesterday)]
     ["Database"
      ("DD" "Daignose"           org-roam-db-diagnose-node)
      ("Dc" "Clear all"          org-roam-db-clear-all)]
     ["Object"
      ("oA" "Remove alias"       org-roam-alias-remove)
      ("oR" "Remove reference"   org-roam-ref-remove)
      ("oT" "Remove tag"         org-roam-tag-remove)
      ("oa" "Add alias"          org-roam-alias-add)
      ("or" "Add reference"      org-roam-ref-add)
      ("ot" "Add tag"            org-roam-tag-add)]]))

;;;;; Org-roam-ui
(use-package websocket
  :after org-roam)

(use-package org-roam-ui
  :after org-roam
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))
;;;;; Delve
(use-package delve
  :after org-roam
  :init
  (setq delve-minor-mode-prefix-key (kbd "C-c d"))
  :config
  (setq delve-dashboard-tags '("Joyent" "tipjar" "Jazney"))
  (setq delve-storage-paths "~/Nextcloud/Notes/Delve")
  (evil-define-key* '(normal insert) delve-mode-map
    (kbd "<return>") #'lister-key-action
    (kbd "<tab>") #'delve--key--tab
    (kbd "gr") #'delve--refresh-nodes
    (kbd "sm") #'delve-sort-buffer-by-mtime
    (kbd "sa") #'delve-sort-buffer-by-atime
    (kbd "sc") #'delve-sort-buffer-by-ctime
    (kbd "c") #'delve-collect
    (kbd "q") #'delve-kill-buffer))

;;; Functions


;;;  RUNTIME PERFORMANCE
;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
