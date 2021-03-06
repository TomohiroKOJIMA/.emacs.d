;;; vc-auto-commit-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "vc-auto-commit" "vc-auto-commit.el" (21819
;;;;;;  23240 0 0))
;;; Generated autoloads from vc-auto-commit.el

(defvar vc-auto-commit nil "\
Buffer local variable that controls whether corresponding file
is in a auto-committed repository.")

(make-variable-buffer-local 'vc-auto-commit)

(put 'vc-auto-commit 'safe-local-variable 'booleanp)

(autoload 'vc-auto-commit "vc-auto-commit" "\
Commit all changes of REPOSITORY. If used with
\\[prefix-argument], the user is asked for a commit message.
Otherwise, `vc-<BACKEND>-commit-msg-function' is called to
generate a commit message.

\(fn REPOSITORY &optional ARG)" t nil)

(autoload 'vc-auto-commit-all "vc-auto-commit" "\
Auto-commit all repositories marked for auto-committing.

\(fn)" nil nil)

(autoload 'vc-auto-commit-activate "vc-auto-commit" "\


\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("vc-auto-commit-pkg.el" "vc-git-auto-commit.el")
;;;;;;  (21819 23240 961612 800000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; vc-auto-commit-autoloads.el ends here
