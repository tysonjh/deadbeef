(require 'package)
(package-initialize)

;; auto complete search
(require 'ido)

;; undo-tree-visualize
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

