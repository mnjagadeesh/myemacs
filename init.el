'(recentf-mode t)
'(transient-mark-mode t)
(load-file "/home/local/PALYAM/njagadeesh/.emacs.d/emacs-for-python/epy-init.el")

(load-file "~/.emacs.d/plugins/minimap/minimap.el")
(require 'minimap)


;(set-default-font "Bitstream Vera Sans Mono-10")
;(set-fontset-font (frame-parameter nil 'font)
;  'han '("cwTeXHeiBold" . "unicode-bmp"))
;;; ================= uptime ============================
(setq-default 
 mode-line-format
 (list " " 'mode-line-modified
       "--" 'mode-line-buffer-identification
       "--" 'mode-line-modes
       'mode-line-position
       "--[uptime: " '(:eval (shell-command-to-string "uptime |awk -F' '  '{print $3 $4}'"))
       "]-%-"))
(add-to-list 'load-path "~/.emacs.d/plugins/magit")
;;;(add-to-list 'load-path "~/.emacs.d/plugins/magit/contrib")
(require 'magit)

;;; =====================================================
(setq make-backup-files nil)
(setq query-replace-highlight t)
(setq search-highlight t)
(setq font-lock-maximum-decoration t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq require-final-newline t)
(setq major-mode 'text-mode)

;; turn on paren matching
(show-paren-mode t)
(setq show-paren-style 'mixed)

;; Get rid of the startup screen
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
;;;;DejaVu Sans
(setq default-frame-alist '((font . "inconsolata")))

;; Get back font antialiasing
(push '(font-backend xft x) default-frame-alist)

;(global-font-lock-mode t t)
(setq font-lock-maximum-decoration t)

(setq default-directory "~/")

;; Get rid of toolbar, scrollbar, menubar
(progn
  (linum-mode 1)  
  (tool-bar-mode -1)
;  (menu-bar-mode)
  (scroll-bar-mode))

(add-to-list 'load-path "~/.emacs.d/plugins/textmate")
(require 'textmate)
(textmate-mode)

;; redo
(add-to-list  'load-path "~/.emacs.d/plugins/redo")
(require 'redo)
(global-set-key [(control -)] 'redo)

;; show ascii table
(defun ascii-table ()
  "Print the ascii table. Based on a defun by Alex Schroeder <asc@bsiag.com>"
  (interactive)
  (switch-to-buffer "*ASCII*")
  (erase-buffer)
  (insert (format "ASCII characters up to number %d.\n" 254))
  (let ((i 0))
    (while (< i 254)
      (setq i (+ i 1))
      (insert (format "%4d %c\n" i i))))
  (beginning-of-buffer))


;; insert date into buffer at point
(defun insert-date ()
  "Insert date at point."
  (interactive)
  (insert (format-time-string "%a %Y-%m-%d - %l:%M %p")))


;; centers the screen around a line...
(global-set-key [(control l)]  'centerer)
(defun centerer ()
   "Repositions current line: once middle, twice top, thrice bottom"
   (interactive)
   (cond ((eq last-command 'centerer2)  ; 3 times pressed = bottom
          (recenter -1))
         ((eq last-command 'centerer1)  ; 2 times pressed = top
          (recenter 0)
          (setq this-command 'centerer2))
         (t                             ; 1 time pressed = middle
          (recenter)
          (setq this-command 'centerer1))))


;; Kills live buffers, leaves some emacs work buffers
(defun nuke-some-buffers (&optional list)
  "For each buffer in LIST, kill it silently if unmodified. Otherwise ask.
LIST defaults to all existing live buffers."
  (interactive)
  (if (null list)
      (setq list (buffer-list)))
  (while list
    (let* ((buffer (car list))
           (name (buffer-name buffer)))
      (and (not (string-equal name ""))
           ;(not (string-equal name "*Messages*"))
          ;; (not (string-equal name "*Buffer List*"))
           ;(not (string-equal name "*buffer-selection*"))
           ;(not (string-equal name "*Shell Command Output*"))
           (not (string-equal name "*scratch*"))
           (/= (aref name 0) ? )
           (if (buffer-modified-p buffer)
               (if (yes-or-no-p
                    (format "Buffer %s has been edited. Kill? " name))
                   (kill-buffer buffer))
             (kill-buffer buffer))))
    (setq list (cdr list))))

;; maxframe
(add-to-list  'load-path "~/.emacs.d/plugins/maxframe")
(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)
(add-hook 'window-setup-hook 'ecb-redraw-layout t)

(set-background-color "#2b2b2b")
(set-foreground-color "white")
(set-face-background 'modeline "DarkRed")
(set-face-foreground 'modeline "white")
;; color-theme
;(add-to-list  'load-path "~/.emacs.d/plugins/color-theme")
;(require 'color-theme)
;    (color-theme-initialize)
;    (color-theme-arjen)


(mouse-wheel-mode t)
;; wheel mouse
;(defun up-slightly () (interactive) (scroll-up 5))
;(defun down-slightly () (interactive) (scroll-down 5))
;(global-set-key [mouse-4] 'down-slightly)
;(global-set-key [mouse-5] 'up-slightly)
;(defun up-one () (interactive) (scroll-up 1))
;(defun down-one () (interactive) (scroll-down 1))
;(global-set-key [S-mouse-4] 'down-one)
;(global-set-key [S-mouse-5] 'up-one)
;(defun up-a-lot () (interactive) (scroll-up))
;(defun down-a-lot () (interactive) (scroll-down))
;(global-set-key [C-mouse-4] 'down-a-lot)
;(global-set-key [C-mouse-5] 'up-a-lot)


;; cedet
;; See cedet/common/cedet.info for configuration details.
(load-file "~/.emacs.d/plugins/cedet/common/cedet.el")
; Enable EDE (Project Management) features
(global-ede-mode 1)
;; * This enables the database and idle reparse engines
;(semantic-load-enable-minimum-features)
;(setq semantic-load-turn-everything-on t)


;; ecb
(add-to-list 'load-path "~/.emacs.d/plugins/ecb")
(require 'ecb)
(setq ecb-tip-of-the-day nil)
(setq ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
(ecb-activate)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-layout-window-sizes (quote (("left8" (ecb-directories-buffer-name 0.23671497584541062 . 0.29310344827586204) (ecb-sources-buffer-name 0.23671497584541062 . 0.22413793103448276) (ecb-methods-buffer-name 0.23671497584541062 . 0.25862068965517243) (ecb-history-buffer-name 0.23671497584541062 . 0.20689655172413793)))))
 '(ecb-options-version "2.40")
 '(org-agenda-files (quote ("~/Documents/logging-exim/todo.org")))
 '(py-pychecker-command "/home/local/PALYAM/njagadeesh/bin/pychecker.sh")
 '(py-pychecker-command-args (quote ("")))
 '(python-check-command "/home/local/PALYAM/njagadeesh/bin/pychecker.sh"))
;; resize the windows on emacs and run ecb-store-window-sizes
; '(show-paren-mode t))


;; find-recursive
(add-to-list 'load-path "~/.emacs.d/plugins/find-recursive")
(require 'find-recursive)


;; anything
(add-to-list 'load-path "~/.emacs.d/plugins/anything")
(require 'anything)

;; anything-rcodetools
(add-to-list 'load-path "~/.emacs.d/plugins/rcodetools")
;(require 'rcodetools)
;(require 'icicles-rcodetools)
;(require 'anything)
(require 'anything-rcodetools)
;;       ;; Command to get all RI entries.
(setq rct-get-all-methods-command "PAGER=cat fri -l -L")
;;       (setq rct-get-all-methods-command "PAGER=cat fri -l")
;(setq rct-get-all-methods-command "PAGER=cat ri -l")
;;       ;; See docs
;; (define-key ruby-mode-map "\M-\C-i" 'rct-complete-symbol)
(define-key anything-map "\C-z" 'anything-execute-persistent-action)
;(rct-get-all-methods)


;; Interactively Do Things (highly recommended, but not strictly required)
(require 'ido)
(ido-mode t)


;; tabkey2
;(load "~/.emacs.d/plugins/nxhtml/util/tabkey2.el")



;; DTD mode
(autoload 'dtd-mode "tdtd" "Major mode for SGML and XML DTDs." t)
(autoload 'dtd-etags "tdtd" "Execute etags on FILESPEC and match on DTD-specific regular expressions." t)
(autoload 'dtd-grep "tdtd" "Grep for PATTERN in files matching FILESPEC." t)
(setq auto-mode-alist (append (list
    '("\\.dcl$" . dtd-mode)
    '("\\.dec$" . dtd-mode)
    '("\\.dtd$" . dtd-mode)
    '("\\.ele$" . dtd-mode)
    '("\\.ent$" . dtd-mode)
    '("\\.mod$" . etd-mode))
  auto-mode-alist))


;; css
;(add-to-list  'load-path "~/.emacs.d/plugins/css-mode")
;(autoload 'css-mode "css-mode" "Mode for editing CSS files" t)
;(setq auto-mode-alist (append '(("\\.css$" . css-mode)) auto-mode-alist))
(add-hook 'css-mode-hook
         (lambda()
           (local-set-key (kbd "<return>") 'newline-and-indent)
))


;; javascript
(add-to-list  'load-path "~/.emacs.d/plugins/javascript")
(add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)

(defvar javascript-identifier-regexp "[a-zA-Z0-9.$_]+")

(defun javascript-imenu-create-method-index-1 (class bound)
  (let (result)
    (while (re-search-forward (format "^ +\\(\%s\\): *function" javascript-identifier-regexp) bound t)
      (push (cons (format "%s.%s" class (match-string 1)) (match-beginning 1)) result))
    (nreverse result)))

(defun javascript-imenu-create-method-index()
  (cons "Methods"
        (let (result)
          (dolist (pattern (list (format "\\b\\(%s\\) *= *Class\.create" javascript-identifier-regexp)
                                 (format "\\b\\([A-Z]%s\\) *= *Object.extend(%s"
                                         javascript-identifier-regexp
                                         javascript-identifier-regexp)
                                 (format "^ *Object.extend(\\([A-Z]%s\\)" javascript-identifier-regexp)
                                 (format "\\b\\([A-Z]%s\\) *= *{" javascript-identifier-regexp)))
            (goto-char (point-min))
            (while (re-search-forward pattern (point-max) t)
              (save-excursion
                (condition-case nil
                    (let ((class (replace-regexp-in-string "\.prototype$" "" (match-string 1)))
                          (try 3))
                      (if (eq (char-after) ?\()
                          (down-list))
                      (if (eq (char-before) ?{)
                          (backward-up-list))
                      (forward-list)
                      (while (and (> try 0) (not (eq (char-before) ?})))
                        (forward-list)
                        (decf try))
                      (if (eq (char-before) ?})
                          (let ((bound (point)))
                            (backward-list)
                            (setq result (append result (javascript-imenu-create-method-index-1 class bound))))))
                  (error nil)))))
          (delete-duplicates result :test (lambda (a b) (= (cdr a) (cdr b)))))))

(defun javascript-imenu-create-function-index ()
  (cons "Functions"
         (let (result)
           (dolist (pattern '("\\b\\([[:alnum:].$]+\\) *= *function" "function \\([[:alnum:].]+\\)"))
             (goto-char (point-min))
             (while (re-search-forward pattern (point-max) t)
               (push (cons (match-string 1) (match-beginning 1)) result)))
           (nreverse result))))

(defun javascript-imenu-create-index ()
  (list
   (javascript-imenu-create-function-index)
   (javascript-imenu-create-method-index)))

(add-hook 'javascript-mode-hook
  (lambda ()
    (setq imenu-create-index-function 'javascript-imenu-create-index)
    (local-set-key (kbd "<return>") 'newline-and-indent)
  )
t)

;; ruby electric
(defun try-complete-abbrev (old)
  (if (expand-abbrev) t nil))
(setq hippie-expand-try-functions-list
     '(try-complete-abbrev
   try-complete-file-name
   try-expand-dabbrev))


;; yaml
(add-to-list 'load-path "~/.emacs.d/plugins/yaml-mode")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))


;; rdebug
(add-to-list 'load-path "~/.emacs.d/plugins/rdebug")
(require 'rdebug)
(setq rdebug-short-key-mode t)

;; flymake
;;(add-to-list  'load-path "~/.emacs.d/plugins/flymake")
;;(require 'flymake)

;; I don't like the default colors :)
;;(set-face-background 'flymake-errline "red4")
;;(set-face-background 'flymake-warnline "dark slate blue")

;; Feature request: have flymake create its temp files in the system temp file directory instead of in the same directory as the file. When using it with Ruby on Rails and autotest, autotest sees the temp file and tries to do something with it and dies, forcing me to restart it, thus killing the magic of autotest. Putting flymake’s temp files elsewhere seems like the easiest way to dodge this.
;;
;; I second the above request. I know there are workarounds for autotest, but it seems like we don’t want to find work arounds for every new web framework, we want to get flymake working in a way that won’t conflict with any other tools.
;;
;; It is easy to patch your autotest to ignore flymake files. I have submitted a patch which hopefully will be included in future releases. For more info see: Emacs, flymake and autotest: the fix
;;
;; Here is a suggestion for a solution (100% untested). Replace flymake-create-temp-inplace above with

(defun flymake-create-temp-intemp (file-name prefix)
  "Return file name in temporary directory for checking FILE-NAME.
This is a replacement for `flymake-create-temp-inplace'. The
difference is that it gives a file name in
`temporary-file-directory' instead of the same directory as
FILE-NAME.

For the use of PREFIX see that function.

Note that not making the temporary file in another directory
\(like here) will not if the file you are checking depends on
relative paths to other files \(for the type of checks flymake
makes)."
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or prefix
      (setq prefix "flymake"))
  (let* ((name (concat
                (file-name-nondirectory
                 (file-name-sans-extension file-name))
                "_" prefix))
         (ext  (concat "." (file-name-extension file-name)))
         (temp-name (make-temp-file name nil ext))
         )
    (flymake-log 3 "create-temp-intemp: file=%s temp=%s" file-name temp-name)
    temp-name))

;;(require 'flymake-jslint)
(add-hook 'javascript-mode-hook
          '(lambda ()
             ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
             (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
                 (flymake-mode))
             ))


;; yasnippet
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")
(setq require-final-newline nil)

;; yasnippet rails
(load "~/.emacs.d/plugins/yasnippets-rails/setup.el")

(add-to-list 'load-path "~/.emacs.d/plugins/autotest")
;;(require 'autotest)

;; rhtml-mode
(add-to-list 'load-path "~/.emacs.d/plugins/rhtml")
;;(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
  (lambda () (rinari-launch)))


(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
(require 'auto-complete-config)

   (global-auto-complete-mode t)           ;enable global-mode
   (setq ac-auto-start t)                  ;automatically start
   (setq ac-dwim 3)                        ;Do what i mean
   (set-default 'ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer))

   (setq ac-modes
         (append ac-modes
                 '(eshell-mode
                   ;org-mode
                   )))
   (add-hook 'emacs-lisp-mode-hook
             (lambda ()
               (setq ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer ac-source-symbols))))

   (add-hook 'eshell-mode-hook
             (lambda ()
               (setq ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-files-in-current-dir ac-source-words-in-buffer))))

   (add-hook 'ruby-mode-hook
             (lambda ()
               (setq ac-omni-completion-sources '(("\\.\\=" ac-source-rcodetools)))));)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; Emacs TRAMP setup
(require 'tramp nil t)
(setq tramp-default-method "ssh")
(add-to-list 'backup-directory-alist
             (cons tramp-file-name-regexp nil))

(load "~/.emacs.d/plugins/undo-tree.el")
(require 'undo-tree)

'(show-trailing-whitespace t)
'(ecb-source-file-regexps (quote ((".*" ("\\(^\\(\\.\\|#\\)\\|\\(~$\\|\\.\\(pyc\\|elc\\|obj\\|o\\|class\\|lib\\|dll\\|a\\|so\\|cache\\)$\\)\\)")))))
(savehist-mode 1)
;;;(load-file "/home/local/PALYAM/njagadeesh/.emacs.d/emacs-for-python/epy-init.el")

(defun python-add-breakpoint ()
  "Add a break point"
  (interactive)
  (newline-and-indent)
  (insert "import pdb; pdb.set_trace()")
  (highlight-lines-matching-regexp "^[ ]*import pdb; pdb.set_trace()"))

(define-key python-mode-map (kbd "C-c C-b") 'python-add-breakpoint)

; Set cursor color to white
(set-cursor-color "#ffffff") 

(add-to-list 'load-path "/home/local/PALYAM/njagadeesh/.emacs.d/emacs-for-python") ;; tell where to load the various files
(require 'epy-setup)      ;; It will setup other loads, it is required!
(require 'epy-python)     ;; If you want the python facilities [optional]
(require 'epy-completion) ;; If you want the autocompletion settings [optional]
(require 'epy-editing)    ;; For configurations related to editing [optional]
(require 'epy-bindings)   ;; For my suggested keybindings [optional]
(require 'epy-nose)       ;; For nose integration

(add-to-list 'load-path "/home/local/PALYAM/njagadeesh/.emacs.d/emacs-for-python/extensions")
(require 'virtualenv)
(virtualenv-activate "/home/local/PALYAM/njagadeesh/virtualenvs")

(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pyflakes" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))

(add-hook 'find-file-hook 'flymake-find-file-hook)

;; inserts IP at the cursor
(defun insertip()
       (interactive)
       (insert (eval (shell-command-to-string "hostname -I"))))
;; This function is taken from 
;; http://emacsredux.com/
(defun font-lock-comment-annotations ()
  "Highlight a bunch of well known comment annotations.This functions should be added to the hooks of major modes for programming."
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):"
          1 font-lock-warning-face t))))
(add-hook 'python-mode 'font-lock-comment-annotations)

;; psgml for dtml

(add-to-list 'load-path "/home/local/PALYAM/njagadeesh/.emacs.d/plugins/psgml/share/emacs/site-lisp")
(require 'psgml)
;;(autoload 'xml-mode "psgml" "Major mode to edit XML files." t)
(setq auto-mode-alist
       (nconc
         '(("\\.html$" . xml-mode))
         '(("\\.dtml$" . xml-mode))
         '(("\\.xml$" . xml-mode))
         auto-mode-alist))
(add-hook 'xml-mode-hook   ; XML-specific settings
        (function (lambda()

; faces creation
(make-face 'sgml-comment-face)
(make-face 'sgml-start-tag-face)
(make-face 'sgml-end-tag-face)
(make-face 'sgml-doctype-face)

; faces definitions
(set-face-foreground 'sgml-comment-face "SeaGreen")
(set-face-foreground 'sgml-start-tag-face "OrangeRed")
(set-face-foreground 'sgml-end-tag-face "OrangeRed")
(set-face-foreground 'sgml-doctype-face "MintCream")

; markup to face mappings
; (see http://www.lysator.liu.se/~lenst/about_psgml/psgml.html#Highlight for details)
(setq sgml-markup-faces
      '((comment . sgml-comment-face)
        (start-tag . sgml-start-tag-face)
        (end-tag . sgml-end-tag-face)
        (doctype . sgml-doctype-face)
        )
      )

; turn faces on
(setq sgml-set-face t))))

(add-to-list 'load-path "/home/local/PALYAM/njagadeesh/.emacs.d/plugins/")
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\.dtml$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.dtml$" . js2-mode))

; Must have org-mode loaded before we can configure org-babel
(require 'org-install)

; Some initial langauges we want org-babel to support
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (R . t)
   (ruby . t)
   (ditaa . t)
   (dot . t)
   (octave . t)
   (sqlite . t)
   (perl . t)
   ))


(when (load "flymake" t)
 (defun flymake-pylint-init ()
   (let* ((temp-file (flymake-init-create-temp-buffer-copy
                      'flymake-create-temp-inplace))
          (local-file (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
         (list "/home/local/PALYAM/njagadeesh/virtualenvs/py2.7/bin/pep8" (list "--repeat" local-file))))

 (add-to-list 'flymake-allowed-file-name-masks
              '("\\.py\\'" flymake-pylint-init)))