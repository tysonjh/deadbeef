;;
;; Look and Feel stuff
;;
;; disable unsightly things
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tooltip-mode) (tooltip-mode -1))

;; line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; matching parens
(show-paren-mode 1)

;; auto refresh log files (ala tail -f)
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

;; window cycling keys (instead of just C-x o)
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)

(defun prev-window ()
  (interactive)
  (other-window -1))

;; ergonomic meta key
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; kill current buffer
(global-set-key (kbd "C-c k") 'kill-this-buffer)

;;
;; Package Stuff
;;
(require 'package)
(add-to-list 'package-archives
         '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; projectile for projects
(require 'helm-projectile)
(projectile-global-mode)
(global-set-key (kbd "C-c h") 'helm-projectile)
(define-key projectile-mode-map (kbd "C-c p p") 'helm-projectile-switch-project)

;; helm for incremental completion
(require 'helm)
(require 'helm-config)
(require 'helm-files)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
(helm-mode 1)

;; undo-tree to replace global undo
(require 'undo-tree)
(global-undo-tree-mode)

;; magit
(require 'magit)
(global-set-key (kbd "M-s M-s") 'magit-status)

;;
;; Coding Style
;;

;; always end a file with a newline
(setq require-final-newline t)

;; automatic reload from disk on stale buffer
(global-auto-revert-mode t)

;; elisp
;; use spaces instead of tabs
(add-hook 'emacs-lisp-mode-hook
              (lambda ()
                ;; Use spaces, not tabs.
                (setq indent-tabs-mode nil)))

;; Scala
;; ensime is awesome
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
