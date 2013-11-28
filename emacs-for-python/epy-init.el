;; This file is a great big shortcut for all the features contained in emacs-for-python

;; Trick to get the filename of the installation directory
(defconst epy-install-dir
  (file-name-directory (or load-file-name
                           (when (boundp 'bytecomp-filename) bytecomp-filename)
                           buffer-file-name))
  "Installation directory of emacs-for-python"
)

(autoload 'python-pep8 "python-pep8")
(autoload 'pep8 "python-pep8")
(add-to-list 'load-path epy-install-dir)
(require 'epy-setup)
(require 'epy-python)
(require 'epy-completion)
(require 'epy-editing)
(require 'epy-nose)
(require 'epy-bindings)
;;(require 'python-pep8.el)

(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)  interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)


(provide 'epy-init)
