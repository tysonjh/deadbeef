;;
;; Look and Feel stuff
;;
;; disable unsightly things
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)

;; window cycling keys (instead of just C-x o)
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)

(defun prev-window ()
  (interactive)
  (other-window -1))

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

;; dirtree for that sweet file explorer buffer
(require 'dirtree)

;; interactively do things for the C-x auto-complete
(require 'ido)

(add-hook 'ido-setup-hook 'ido-consistent-select-text)
(defun ido-consistent-select-text ()
  "Make C-Return work in XEmacs as C-RET works in console"
  (define-key ido-common-completion-map (kbd "<C-return>") 'ido-select-text))

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;; Smex the Smart M-x auto-complete
(autoload 'smex "smex"
  "Smex is a M-x enhancement for Emacs, it provides a convenient interface to
your recently and most frequently used commands.")

(global-set-key (kbd "M-x") 'smex)

;; undo-tree to replace global undo
(require 'undo-tree)
(global-undo-tree-mode)

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
