;;; sane-term-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "sane-term" "sane-term.el" (0 0 0 0))
;;; Generated autoloads from sane-term.el

(autoload 'sane-term-create "sane-term" "\
Create new term buffer.

\(fn)" t nil)

(autoload 'sane-term "sane-term" "\
Cycle through term buffers, creating if necessary.

\(fn)" t nil)

(autoload 'sane-term-mode-toggle "sane-term" "\
Toggles term between line mode and char mode. Nice to have a
   single key so I don't have to remember separate char and line
   mode bindings

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sane-term" '("sane-term-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; sane-term-autoloads.el ends here
