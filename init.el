;;  emacs settings

(setq user-full-name "Morgan")
(setq user-mail-address "morganzhang@juniper.net")

;; =========================================================
;; ================== Coding Settings ======================
(set-language-environment "UTF-8")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)

(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; shell path
(setq exec-path (append exec-path '("/usr/local/bin")))

;; elpa
(package-initialize)
;(elpy-enable)

;;=====================themes=========================
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'zenburn t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
;;=====================themes=========================

;;==========cmake
(require 'cmake-mode)

(setq auto-mode-alist  
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))  
              auto-mode-alist))


(defun my-cmake-mode-hook()
  (company-mode)
 )
(add-hook 'cmake-mode-hook 'my-cmake-mode-hook)

;;==========cmake

;; repo
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") )
(add-to-list 'package-archives 
	     '("marmalade" . "http://marmalade-repo.org/packages/"))

;; hightlight symbol
(require 'highlight-symbol)
(global-set-key [(f4)] 'highlight-symbol-at-point)

;; ido mode
(ido-mode t)

;; bookmarks file
(setq bookmark-default-file "~/.emacs.d/emacs.bmk")

;; 高亮配对括号的方式
;; (setq show-paren-style 'mixed)
(setq show-paren-style 'parenthesis)
(show-paren-mode t)

;; turn off startup message
(setq inhibit-startup-message t)

;; text-mode as default mode
(setq default-major-mode 'text-mode)

;; not add newline at the end of file
(setq mode-require-final-newline nil)

;; backspace for delete
(delete-selection-mode t)

;; line number
;; (global-linum-mode t)

;;column number
(setq column-number-mode t)

;; always use y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; space tab
(setq-default indent-tabs-mode nil)

;; tab width
(setq-default tab-width 4)

;; smooth scroll
(setq scroll-step 10)
(setq scroll-conservatively 10000)

;;=================tramp===============
;; tramp
(require 'tramp)
(setq tramp-default-method "ssh")

(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
(add-to-list 'tramp-remote-process-environment "SHELL=/bin/bash")
(setq explicit-shell-file-name "/bin/bash")
(setq shell-file-name "/bin/bash")

;;(custom-set-variables '(tramp-verbose 8))
;;(setq tramp-chunksize 500)
(setq tramp-shell-prompt-pattern "\\(?:^\\|\r\\)[^]#$%>\n]*#?[]#$%>].* *\\(^[\\[[0-9;]*[a-zA-Z] *\\)*")

(setq shell-prompt-pattern "[A-Za-z]* \[1\]: ")

(setq tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")



;;(setq tramp-debug-buffer t)
;;(setq tramp-verbose 10)
;;=================tramp===============


;; scrolling with trackpad
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
;; xterm mouse
(xterm-mouse-mode t)


;; =========================================================
;; ===================== Key Binding =======================
(global-set-key (kbd "<f5>")  'goto-line)
(global-set-key (kbd "<f9>")  'revert-buffer)
(global-set-key (kbd "<f10>") 'bookmark-set)
(global-set-key (kbd "<f11>") 'list-bookmarks)
(global-set-key (kbd "<f12>") 'ibuffer)
(global-set-key [(control .)] 'flyspell-auto-correct-word)
(global-set-key [(meta o)] 'other-window)
(global-set-key [(control tab)] 'other-window)
(global-set-key (kbd "C-/") 'rgrep)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-mode))
(require 'protobuf-mode)

;;================================yang mode=============================
(autoload 'yang-mode "yang-mode" "Major mode for editing YANG modules."
          t)
(add-to-list 'auto-mode-alist '("\\.yang$" . yang-mode))

(setq blink-matching-paren-distance nil)

(defun show-onelevel ()
  "show entry and children in outline mode"
  (interactive)
  (show-entry)
  (show-children))

(defun my-outline-bindings ()
  "sets shortcut bindings for outline minor mode"
  (interactive)
  (local-set-key [M-up] 'outline-backward-same-level)
  (local-set-key [M-down] 'outline-forward-same-level)
  (local-set-key [M-left] 'hide-subtree)
  (local-set-key [M-right] 'show-subtree))

(add-hook
 'outline-minor-mode-hook
 'my-outline-bindings)

(defconst sort-of-yang-identifier-regexp "[-a-zA-Z0-9_\\.:]*")

(add-hook
 'yang-mode-hook
 '(lambda ()
    (outline-minor-mode)
    (setq outline-regexp
      (concat "^ *" sort-of-yang-identifier-regexp " *"
              sort-of-yang-identifier-regexp
              " *{"))))

;;======================================================================


;;===============semantic=============
;;(semantic-load-enable-minimum-features)
(require 'cedet)

;; Semantic
(custom-set-variables
 '(semantic-default-submodes
   (quote (;;global-semantic-decoration-mode
;;           global-semantic-idle-completions-mode
           global-semantic-idle-scheduler-mode
;;           global-semantic-highlight-func-mode
           global-semanticdb-minor-mode
           global-semantic-idle-summary-mode
           global-semantic-stickyfunc-mode
           global-semantic-tag-folding-mode
           global-semantic-idle-local-symbol-highlight-mode
           global-semantic-mru-bookmark-mode)))
 '(semantic-idle-scheduler-idle-time 1))

(semantic-mode)

(setq semanticdb-default-save-directory
      (expand-file-name "~/.emacs.d/semanticdb"))
(setq semanticdb-project-roots (list "~/code/7000"))

(require 'semantic/db-global)
(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)

(require 'semantic/ia)
(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))

(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)
(setq max-lisp-eval-depth 10000)
;;===============semantic=============


;;=============code folding===========
(require 'hideshow-org)
;;end


;;===============================helm=================================
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; Enable helm-gtags-mode

(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(custom-set-variables
 '(helm-gtags-prefix-key "C-c t")
 '(helm-gtags-suggested-key-mapping t))

;; Set key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-resume)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))


;; helm list buffer
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

;;find sympol
(global-set-key (kbd "<f8>")  'helm-semantic-or-imenu)


;; ;;helm projectile
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-enable-caching t)

(global-set-key (kbd "C-o")  'helm-projectile-find-file)
;;helm find file
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(add-to-list 'projectile-other-file-alist '("cc".("hh" "h"))) ;; switch from cc  -> h
(add-to-list 'projectile-other-file-alist '("h" "cc")) ;; switch from h   -> c

;;(add-to-list 'projectile-other-file-alist '("cc" "hh")) ;; switch from cc  -> hh
(add-to-list 'projectile-other-file-alist '("hh" "cc")) ;; switch from hh   -> c
(defun myhook ()
  (message "morgan's hook"))
(setq projectile-find-dir-hook 'myhook)

;; (setq helm-prevent-escaping-from-minibuffe nil)
;;(advice-add #'helm--remap-mouse-mode :override #'ignore)

;;===============================helm=================================


;;===============================psvn=================================
(require 'psvn)
;;(eval-after-load "vc-hooks"
;;  '(define-key vc-prefix-map "=" 'ediff-revision))
;;===============================psvn=================================

;; c-mode
(defun my-c-mode-common-hook()
  (c-set-style "BSD")
  (setq c-basic-offset 4)
  (c-toggle-hungry-state t)
  ;; (c-toggle-auto-newline t)
  (which-func-mode t)
  ;; (define-key c-mode-base-map [(return)] 'newline-and-indent)
  (define-key c-mode-base-map (kbd "C-c C-c") 'align)
  (setq ac-sources '(ac-source-gtags
                     ac-source-words-in-same-mode-buffers
                     ac-source-dictionary
                     ))
;;  (gtags-mode 1)
  (auto-revert-mode t)
  (subword-mode 1)
  ;; (fci-mode 1)
  ;; (flyspell-prog-mode)
  (linum-mode 1)
  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; python-mode
(defun my-python-mode-hook()
  (flyspell-prog-mode)
  (setq ac-sources '(ac-source-words-in-same-mode-buffers
                     ac-source-dictionary))
  )
(add-hook 'python-mode-hook 'my-python-mode-hook)

;; shell-mode
(defun my-shell-mode-hook()
  (linum-mode 0)
  )
(add-hook 'shell-mode-hook 'my-shell-mode-hook)


(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))
(global-set-key (kbd "C-c ;") 'comment-or-uncomment-region-or-line)


(defun textmate-shift-right (&optional arg)
  "Shift the line or region to the ARG places to the right.
   A place is considered `tab-width' character columns."
  (interactive)
  (let ((deactivate-mark nil)
        (beg (or (and mark-active (region-beginning))
                 (line-beginning-position)))
        (end (or (and mark-active (region-end)) (line-end-position))))
    (indent-rigidly beg end (* (or arg 1) tab-width))))
(global-set-key (kbd "M-]") 'textmate-shift-right)

(defun textmate-shift-left (&optional arg)
  "Shift the line or region to the ARG places to the left."
  (interactive)
  (textmate-shift-right (* -1 (or arg 1))))
(global-set-key (kbd "C-M-]") 'textmate-shift-left)


(require 'server)
(or (server-running-p)
    (server-start))
