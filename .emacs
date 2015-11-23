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

;; ergonomic meta key
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; kill current buffer
(global-set-key (kbd "C-c k") 'kill-this-buffer)

;; use google chrome
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

;;
;; Package Stuff
;;
(require 'package)
(add-to-list 'package-archives
         '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; org-mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-tag-alist '(("@meeting" . ?m) ("@development" . ?d) ("@review" . ?r) ("@design" . ?n) ("@process" . ?p) ("@misc" . ?x)))
(setq org-log-done t)

(setq org-journal-dir "~/Documents/journals")
(add-to-list 'org-agenda-files (expand-file-name org-journal-dir))

(defun get-journal-file-this-month ()
  "Return filename for this month's journal."
  (let ((monthly-name (concat (format-time-string "%Y-%m-%V") ".org")))
  (expand-file-name (concat org-journal-dir "/" monthly-name))))

(defun journal-file-today ()
  "Create and load a journal file based on today's date."
  (interactive)
  (find-file (get-journal-file-this-month)))

(global-set-key (kbd "C-c f j") 'journal-file-today)

;; rainbow-parenthesis
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; projectile for projects
(require 'helm-projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-switch-project-action 'helm-projectile)

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
(global-set-key (kbd "C-x g") 'magit-status)

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
(setenv "PATH" (concat "/usr/bin/sbt:" (getenv "PATH")))
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)


;; XML
(defun bf-pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
      (nxml-mode)
      (goto-char begin)
      (while (search-forward-regexp "\>[ \\t]*\<" nil t)
        (backward-char) (insert "\n"))
      (indent-region begin end))
    (message "Ah, much better!"))
