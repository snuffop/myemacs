;;; $doomdir/config.el --- Marty Buchaus' Emacs Config File -*- lexical-binding: t; -*-
;;;
;;; Commentary:
;;;
;;; Code:

(load (expand-file-name "myconfig.el" user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(workgroups dired-x dirvish delve org-roam-ui systemd zoxide yasnippet which-key websocket wakatime-mode vertico sudo-edit quelpa-use-package peep-dired paperless outshine org-bullets orderless marginalia magit-todos helpful gcmh forge evil-tutor evil-collection embark-consult emacsql-sqlite3 eglot doom-themes doom-modeline doct dired-open dashboard corfu consult-org-roam cape ansible all-the-icons-dired))
 '(safe-local-variable-values '((pyvenv-activate . ~/Source/Joyent/EngOps/\.venv))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
