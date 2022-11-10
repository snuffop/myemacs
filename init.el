;;; init.el --- Initial file

(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(delve websocket consult-org-roam yasnippet zoxide helpful wakatime-mode paperless cape corfu emacsql-sqlite3 org-roam doct org-bullets magit doom-modeline peep-dired dired-open all-the-icons-dired dashboard all-the-icons which-key vertico quelpa-use-package outshine orderless marginalia general gcmh evil-tutor evil-collection embark-consult dracula-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
