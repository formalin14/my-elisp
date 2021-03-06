;;;;;; perl best practice
                                        ;############################################################################
                                        ;#   Emacs config (Recommended) from Appendix C of "Perl Best Practices"    #
                                        ;#     Copyright (c) O'Reilly & Associates, 2005. All Rights Reserved.      #
                                        ;#  See: http://www.oreilly.com/pub/a/oreilly/ask_tim/2001/codepolicy.html  #
                                        ;############################################################################

;; Use cperl mode instead of the default perl mode
(defalias 'perl-mode 'cperl-mode)
 
;; turn autoindenting on
(global-set-key "\r" 'newline-and-indent)
 
;; Use 4 space indents via cperl mode
(custom-set-variables
 '(cperl-close-paren-offset -4)
 '(cperl-continued-statement-offset 4)
 '(cperl-indent-level 4)
 '(cperl-indent-parens-as-block t)
 '(cperl-tab-always-indent t))
 
;; Insert spaces instead of tabs
(setq-default indent-tabs-mode nil)
 
;; Set line width to 78 columns...
(setq fill-column 78)
(setq auto-fill-mode t)
 
;; Use % to match various kinds of brackets...
;; See: http://www.lifl.fr/~hodique/uploads/Perso/patches.el
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (let ((prev-char (char-to-string (preceding-char)))
        (next-char (char-to-string (following-char))))
    (cond ((string-match "[[{(<]" next-char) (forward-sexp 1))
          ((string-match "[\]})>]" prev-char) (backward-sexp 1))
          (t (self-insert-command (or arg 1))))))
 
;; Load an applicationtemplate in a new unattached buffer...
(defun application-template-pm ()
  "Inserts the standard Perl application template"  ; For help and info.
  (interactive "*")                                 ; Make this user accessible.
  (switch-to-buffer "application-template-pm")
  (insert-file "~/.myel/perl_application.pl"))
;; Set to a specific key combination...
(global-set-key "\C-ca" 'application-template-pm)
 
;; Load a module template in a new unattached buffer...
(defun module-template-pm ()
  "Inserts the standard Perl module template"       ; For help and info.
  (interactive "*")                                 ; Make this user accessible.
  (switch-to-buffer "module-template-pm")
  (insert-file "~/.myel/perl_module.pl"))
;; Set to a specific key combination...
(global-set-key "\C-cm" 'module-template-pm)
 
;; Expand the following abbreviations while typing in text files...
(abbrev-mode 1)
 
(define-abbrev-table 'global-abbrev-table '(
    ("pdbg"   "use Data::Dumper qw( Dumper );\nwarn Dumper[];"   nil 1)
    ("phbp"   "#! /usr/bin/perl -w"                              nil 1)
    ("pbmk"   "use Benchmark qw( cmpthese );\ncmpthese -10, {};" nil 1)
    ("pusc"   "use Smart::Comments;\n\n### "                     nil 1)
    ("putm"   "use Test::More 'no_plan';"                        nil 1)
    ))
 
(add-hook 'text-mode-hook (lambda () (abbrev-mode 1)))



;;;;;; custom
;; virtual mark
(transient-mark-mode   t)

;; duplicate line
(defun duplicate-line ()
  "Duplicate a line"
  (interactive)
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (move-end-of-line nil)
  (kill-ring-save (mark) (point))
  (newline)
  (yank)
  )
(global-set-key "\C-cd" 'duplicate-line)
;; goto-line
(global-set-key "\C-cg" 'goto-line)
;; no backup
(setq make-backup-files nil)
(setq-default make-backup-files nil)

;;;;;; for multi-web-mode
(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((javascript-mode "<script[^>]*?>" "</script>") (css-mode "<style[^>]*?>" "</style>") (php-mode "<\?php" "\?>")))
(setq mweb-filename-extensions '("html"))
(multi-web-global-mode 1)

;;;;;; for less-css-mode
(require 'less-css-mode)
;;(setq less-css-compile-at-save t)

;; auto mode
(setq auto-mode-alist (cons '("\\.t$" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.psgi$" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.less$" . less-css-mode) auto-mode-alist))

;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.myel//ac-dict")
(ac-config-default)
(ac-set-trigger-key "TAB")

;; for jade-mode
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; for livescript-mode
;(require 'livescript-mode)

;; for perl-lisp
(add-to-list 'auto-mode-alist '("\\.plp$" . lisp-mode))

;; for markdown
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; for sass
(require 'sass-mode)
(require 'scss-mode)
(setq scss-compile-at-save nil)

;; for yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; for php
(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))


;; for xslate
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tx$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tt$" . web-mode))
(require 'xslate)
(add-hook 'web-mode-hook
          '(lambda ()
             (cond
              ((extension-match "tx")
               (xslate-mode t)))))
