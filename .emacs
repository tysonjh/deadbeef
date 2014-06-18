(require 'package)
(package-initialize)

;;
;; golang specific stuffs
;;
(require 'go-eldoc) ;; Don't need to require, if you install by package.el
(add-hook 'go-mode-hook 'go-eldoc-setup)

(add-to-list 'load-path "~/Development/go/src/github.com/dougm/goflymake")
(require 'go-flymake)

;;
;; end golang specific stuffs
;;

;; auto complete search
(require 'ido)

;; undo-tree-visualize
(require 'undo-tree)
(global-set-key (kbd "C-+") 'undo-tree-visualize)

;; kill current buffer
(global-set-key (kbd "C-c k") 'kill-this-buffer)

;; window cycling keys (instead of just C-x o)
(global-set-key (kbd "C-.") 'other-window)
(global-set-key (kbd "C-,") 'prev-window)

(defun prev-window ()
  (interactive)
  (other-window -1))

(add-hook 'ido-setup-hook 'ido-consistent-select-text)
(defun ido-consistent-select-text ()
  "Make C-Return work in XEmacs as C-RET works in console"
  (define-key ido-common-completion-map (kbd "<C-return>") 'ido-select-text))

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; smex for meta
(global-set-key [(meta x)] (lambda ()
                             (interactive)
                             (or (boundp 'smex-cache)
                                 (smex-initialize))
                             (global-set-key [(meta x)] 'smex)
                             (smex)))

(global-set-key [(shift meta x)] (lambda ()
                                   (interactive)
                                   (or (boundp 'smex-cache)
                                       (smex-initialize))
                                   (global-set-key [(shift meta x)] 'smex-major-mode-commands)
                                   (smex-major-mode-commands)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes (quote ("146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" default)))
 '(package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/") ("melpa" . "http://melpa.milkbox.net/packages/") ("marmalade" . "http://marmalade-repo.org/packages/")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
