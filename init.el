;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PATH�̐ݒ�

(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/auto-install/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; OS���Ƃɕ��򂷂�ݒ�
(cond
  ;;****************************************** Windows
 ((string-match "mingw" system-configuration)
  ;; �p��
  (set-face-attribute 'default nil
		      :family "Consolas"
		      :height 90)
  ;; ���{��
  (set-fontset-font
   nil 'japanese-jisx0208
   (font-spec :family "MeiryoKe_Console"))
  ;; �����ɂ���
  (setq face-font-rescale-alist '(("MeiryoKe_Console" . 1.08)))

  ;; �R�[�f�B���O
  (set-language-environment 'Japanese)
  (prefer-coding-system 'shift_jis)
  (set-default-coding-systems 'shift_jis)
  (set-terminal-coding-system 'shift_jis)
  (set-keyboard-coding-system 'shift_jis)
  (set-clipboard-coding-system 'shift_jis)
  (setq default-buffer-file-coding-system 'shift_jis)
  (set-buffer-file-coding-system 'shift_jis)

  )

 ;;****************************************** OSX
 ((string-match "apple-darwin" system-configuration)
  ;; �p��
  (set-face-attribute 'default nil
		      :family "Menlo" ;; font
		      :height 120)    ;; font size
  ;; ���{��
  (set-fontset-font
   nil 'japanese-jisx0208
   (font-spec :family "Hiragino Kaku Gothic ProN"))
  ;; �����ɂ���
  (setq face-font-rescale-alist
	'((".*Hiragino_Mincho_pro.*" . 1.2)))

  ;; �R�[�f�B���O
  (set-language-environment 'Japanese)
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-clipboard-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8)
  (set-buffer-file-coding-system 'utf-8)

  ;; �~�}�[�N���o�b�N�X���b�V���ɂ���
  ;;(define-key global-map [?\] [?\\])

  ;; emacs��shell��PATH�����L����
  (defun set-exec-path-from-shell-PATH ()
    ;; "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.
    ;; This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
    (interactive)
    (let ((path-from-shell
	   (replace-regexp-in-string "[ \t\n]*$" ""
				     (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
      (setenv "PATH" path-from-shell)
      (setq exec-path (split-string path-from-shell path-separator))))
  (set-exec-path-from-shell-PATH)

  )

 ;;****************************************** Linux
 ((string-match "linux" system-configuration)
  ;; �p��
  (set-face-attribute 'default nil
		      :family "TakaoGothic" ;; font
		      :height 120)    ;; font size
  ;; ���{��
  (set-fontset-font
   nil 'japanese-jisx0208
   (font-spec :family "Takao�S�V�b�N"))

  ;; �R�[�f�B���O
  (set-language-environment 'Japanese)
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-clipboard-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8)
  (set-buffer-file-coding-system 'utf-8)

  ;; emacs��shell��PATH�����L����
  (defun set-exec-path-from-shell-PATH ()
    ;; "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.
    ;; This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
    (interactive)
    (let ((path-from-shell
	   (replace-regexp-in-string "[ \t\n]*$" ""
				     (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
      (setenv "PATH" path-from-shell)
      (setq exec-path (split-string path-from-shell path-separator))))
  (set-exec-path-from-shell-PATH)

  )

 );

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; �����ڊ֘A

 (setq linum-format "%5d ") ; 5 �����̗̈���m�ۂ��čs�ԍ��̂��ƂɃX�y�[�X������

 ;; �X�^�[�g�A�b�v�y�[�W��\�����Ȃ�
 (setq inhibit-startup-message t)
 (server-start)

 ;;�^�C�g���o�[�Ƀt�@�C������\��
 (setq frame-title-format (format "%%f - Emacs@%s" (system-name)))

 ;; �c�[���o�[������
 (tool-bar-mode 0)

 ;;�����t�@�C���̃o�b�t�@���̎��ʕ������ύX����
 (require 'uniquify)
 (setq uniquify-buffer-name-style 'post-forward-angle-brackets)

 ;;�c�����Ő܂�Ԃ�
 (setq truncate-partial-width-windows nil)
 ;;�܂�Ԃ��L���̐F
 (set-face-foreground 'fringe "gray50")
 ;;�܂�Ԃ��L���̂Ƃ��̔w�i�F
 (set-face-background 'fringe "gray12")

 ;; region �̐F
 (set-face-foreground 'default "white")
 (set-face-background 'default "gray8")
 (setq frame-background-mode 'dark)

 ;;�J�[�\���s�̃n�C���C�g
 (defface hlline-face
   '((((class color)
       (background dark))
      ;;(:background "dark state gray"))
      (:background "gray13"
		   :underline "gray24"))
     (((class color)
       (background light))
      (:background "ForestGreen"
		   :underline nil))
     (t ()))
   "*Face used by hl-line.")
 (setq hl-line-face 'hlline-face)
 ;;(setq hl-line-face 'underline)
 (global-hl-line-mode)
;;; �J�[�\���̓_�ł��~�߂�
 (blink-cursor-mode 0)

 ;;���߂̐ݒ�
 (when window-system
   (progn
     (setq default-frame-alist
	   (append
	    (list
	     '(width  . 80)
	     '(height . 24)
	     '(alpha  . 90))
	    default-frame-alist))))

 ;; ��ʃT�C�Y�̐ݒ�
 (if (boundp 'window-system)
     (setq initial-frame-alist
	   (append (list
		    '(vertical-scroll-bars . nil) ;;�X�N���[���o�[�͂���Ȃ�
		    '(width . 202) ;; �E�B���h�E��
		    '(height . 60) ;; �E�B���h�E�̍���
		    '(top . 0) ;;�\���ʒu
		    '(left . 0) ;;�\���ʒu
		    )
		   initial-frame-alist)))

 ;; ���[�W�����w��C���ʑΉ��ɐF������
 (setq transient-mark-mode t)
 (show-paren-mode)
 (setq show-paren-style 'parenthesis)
 (setq show-paren-delay 0.05) ;; default: 0.125

 ;;�s�C���ԍ�,�o�b�t�@�T�C�Y�̕\��
 (line-number-mode t)
 (column-number-mode t)

 ;; �s���̃X�y�[�X��\��
 (setq-default show-trailing-whitespace t)

 (defun trim-whitespaces ()
   "Trim excess whitespaces."
   (interactive "*")
   (let ((key (read-char "Convert spaces?: (t)abify (u)ntabify (n)o"))
	 (reg (and transient-mark-mode mark-active)))
     (save-excursion
       (save-restriction
	 (if reg
	     (narrow-to-region (region-beginning) (region-end)))
	 (goto-char (point-min))
	 (while (re-search-forward "[ \t]+$" nil t)
	   (replace-match "" nil nil))
	 (if reg nil
	   (goto-char (point-max))
	   (delete-blank-lines))
	 (cond
	  ((= key ?t)
	   (tabify (point-min) (point-max)))
	  ((= key ?u)
	   (untabify (point-min) (point-max)))))))
   (deactivate-mark))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; �V���[�g�J�b�g�L�[

 ;; C-h �őO������
 (keyboard-translate ?\C-h ?\C-?)

 ;; C-k �ōs���̉��s������
 (setq kill-whole-line t)

 ;;C-Tab�ŕʂ̃E�B���h�E�Ɉړ�
 (define-key global-map[C-tab] 'other-window)
 (define-key global-map [S-C-tab] (lambda () (interactive) (other-window -1)))

 ;; �J�[�\���ʒu����s���܂ō폜���� "C-o"
 (defun backward-kill-line (arg)
   "Kill chars backward until encountering the end of a line."
   (interactive "p")
   (kill-line 0))
 (global-set-key (kbd "C-o") 'backward-kill-line)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; auto-install
 ;; M-x auto-install-�Ȃ�Ƃ� �ňˑ��֌W���l�����ĐF�X����Ă����B
 ;; �N�����ɏd���Ȃ�̂ŁA�g��Ȃ����ɂ�OFF�ł�
 ;;(require 'auto-install)
 ;;(auto-install-update-emacswiki-package-name t)
 ;;(auto-install-compatibility-setup)
 ;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; anything http://d.hatena.ne.jp/tomoya/20090423/1240456834
 ;; "C-;"�ŋN�� �t�@�C���X�g���t�@�C������ǂݎ��-�쐬�� $ sudo contribute*.ruby > all.filelist
 (require 'anything-config)
 (define-key global-map (kbd "C-;") 'anything-filelist+)

 (setq anything-sources
       '(anything-c-source-buffers+
	 anything-c-source-colors
	 anything-c-source-recentf
	 anything-c-source-man-pages
	 anything-c-source-emacs-commands
	 anything-c-source-emacs-functions
	 anything-c-source-files-in-current-dir
	 ))
 (setq anything-c-filelist-file-name "~/.emacs.d/all.filelist")
 (setq anything-grep-candidates-fast-directory-regexp "^/.emacs.d")
 (add-to-list 'anything-sources 'anything-c-source-emacs-commands)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; yasnippet

 (require 'cl)
 ;; �₢���킹���ȗ��� yes/no �� y/n
 (fset 'yes-or-no-p 'y-or-n-p)
					; yasnippet��u���Ă���t�H���_�Ƀp�X��ʂ�
 (add-to-list 'load-path
	      (expand-file-name "~/.emacs.d/plugins/yasnippet"))
 (require 'yasnippet)
 (setq yas-snippet-dirs
       '("~/.emacs.d/plugins/yasnippet/snippets"
	 ))
 (yas-global-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; auto-complete

 (require 'auto-complete)
 (require 'auto-complete-config)

 (defvar ac-dir (expand-file-name "~/.emacs.d/plugins/auto-complete"))
 (add-to-list 'load-path ac-dir)

;;; �x�[�X�ƂȂ�\�[�X���w��
 (defvar my-ac-sources
   '(ac-source-yasnippet
     ac-source-abbrev
     ac-source-dictionary
     ac-source-words-in-same-mode-buffers))
 (setq-default ac-sources my-ac-sources)

 (global-auto-complete-mode t)
;;; C-n / C-p �őI��
 (setq ac-use-menu-map t)

;;; yasnippet��binding���w�肷��ƃG���[���o��̂ŉ��������@�B
 (setf (symbol-function 'yas-active-keys)
       (lambda ()
	 (remove-duplicates (mapcan #'yas--table-all-keys (yas--get-snippet-tables)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; �ʂ̌���ݒ�

 ;; cc-mode�̎��O�X�^�C���ݒ�
 (add-hook 'c-mode-common-hook
	   (lambda()
	     (setq completion-mode t)
	     (setq compilation-window-height 10)
	     (setq c-basic-offset 2)
	     ;; cc-mode���Œ�`�����L�[�o�C���h
	     (define-key c-mode-base-map "\C-cc"      'compile)
	     (define-key c-mode-base-map "\C-cg"      'gdb)
	     (define-key c-mode-base-map "\C-ck" 'kill-compilation);��߂�
	     (define-key c-mode-base-map "\C-ce" 'next-error)	;�G���[����
	     (define-key c-mode-base-map "\"" 'electric-pair)
	     (define-key c-mode-base-map "\'" 'electric-pair)
	     (define-key c-mode-base-map "(" 'electric-pair)
	     (define-key c-mode-base-map "[" 'electric-pair)
	     (define-key c-mode-base-map "{" 'electric-pair)
	     ;; ���ʂ�;����͂���Ǝ����ŉ��s
					;(setq c-auto-newline t)
	     ;; TAB �̓X�y�[�X 2 �Ԃ��
	     (setq-default tab-width 2)
	     (setq indent-tabs-mode nil)
	     ;; # ���C���f���g���Ȃ�
	     ;;(setq c-electric-pound-behavior '(alignleft))
	     (c-set-offset 'cpp-macro 0)
	     (c-set-offset 'cpp-macro-cont '+)
	     ))

 ;;c++ mode
 (add-hook 'c++-mode-common-hook
	   (lambda()
	     (setq completion-mode t)
	     (setq compilation-window-height 10)
	     (setq c-basic-offset 2)
	     ;; cc-mode���Œ�`�����L�[�o�C���h
	     (define-key c++-mode-base-map "\C-cc"      'compile)
	     (define-key c++-mode-base-map "\C-cg"      'gdb)
	     (define-key c++-mode-base-map "\C-ck" 'kill-compilation);��߂�
	     (define-key c++-mode-base-map "\C-ce" 'next-error)	;�G���[����
	     (define-key c++-mode-base-map "\"" 'electric-pair)
	     (define-key c++-mode-base-map "\'" 'electric-pair)
	     (define-key c++-mode-base-map "(" 'electric-pair)
	     (define-key c++-mode-base-map "[" 'electric-pair)
	     (define-key c++-mode-base-map "{" 'electric-pair)
	     ;; ���ʂ�;����͂���Ǝ����ŉ��s
					;(setq c-auto-newline t)
	     ;; TAB �̓X�y�[�X 2 �Ԃ��
	     (setq-default tab-width 2)
	     (setq indent-tabs-mode nil)
	     ;; # ���C���f���g���Ȃ�
	     (setq c-electric-pound-behavior '(alignleft))
	     (c-set-offset 'cpp-macro 0)
	     (c-set-offset 'cpp-macro-cont '+)
	     ))

 (global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
 (global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
 (global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
 (global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
 (setq skeleton-pair 1)

 ;; yatex-mode �̋N��
 (setq auto-mode-alist
       (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
 (autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
 ;; yatex��u���Ă���t�H���_�Ƀp�X��ʂ�
 (add-to-list 'load-path
	      (expand-file-name "~/.emacs.d/plugins/yatex1.77"))

 ;; ���͍쐬���̊����R�[�h�̐ݒ�
 ;; 1 = Shift_JIS, 2 = ISO-2022-JP, 3 = EUC-JP, 4 = UTF-8
 ;; �R�[�h���w�肵�Ă��܂��ƁC�ʂ̃R�[�h�̃t�@�C���������
 ;; �����Ŏw�肵���R�[�h�ɕϊ�����Ă��܂��g���u���̂��Ƃ�
 ;; �Ȃ�̂ŁCnil�ɂ��Ă����̂��g�B
 (setq YaTeX-kanji-code nil)

 ;;LaTeX�R�}���h�̐ݒ�
 (setq tex-command "platex")

 ;; OS���Ƃɕ��򂷂�ݒ�
 (cond
  ;;****************************************** OSX
  ((string-match "apple-darwin" system-configuration)
   ;;YaTeX�ł̃v���r���[�A�R�}���h��ݒ肷��
   (setq dvi2-command "open -a Preview")
   )

  ;;****************************************** Linux
  ((string-match "linux" system-configuration)
   ;;YaTeX�ł̃v���r���[�A�R�}���h��ݒ肷��
   (setq dvi2-command "evince")
   )

  ;;****************************************** Windows
  ((string-match "mingw" system-configuration)
   ;;YaTeX�ł̃v���r���[�A�R�}���h��ݒ肷��
   (setq dvi2-command "dviout")
   )
  );

 ;;AMS-LaTeX ���g�p�����ǂ���
 (setq YaTeX-use-AMS-LaTeX t)

 ;; RefTeX��YaTeX�Ŏg����悤�ɂ���
 (add-hook 'yatex-mode-hook '(lambda () (reftex-mode t)))
 ;; RefTeX�Ŏg��bib�t�@�C���̈ʒu���w�肷��
 ;;(setq reftex-default-bibliography '("~/Library/TeX/bib/papers.bib"))

 ;;RefTeX�Ɋւ���ݒ�
 (setq reftex-enable-partial-scans t)
 (setq reftex-save-parse-info t)
 (setq reftex-use-multiple-selection-buffers t)

 ;;RefTeX�ɂ����Đ����̈��p��\eqref�ɂ���
 (setq reftex-label-alist '((nil ?e nil "~\\eqref{%s}" nil nil)))

 ;; [prefix] �p�� �R�}���h��[prefix] C-�p�� �ɕύX����
 (setq YaTeX-inihibit-prefix-letter t)

 ;; �������s��}������
 (add-hook 'yatex-mode-hook'(lambda ()(setq auto-fill-function nill)))

 ;;YaTeX�̓��{���auto-complete���T�������Ƃ��͈ȉ����R�����g�A�E�g����
;;;; Auto Complete LaTeX �̐ݒ�
 (require 'auto-complete-latex)
 (setq ac-l-dict-directory "~/.emacs.d/plugins/yasnippet/snippets/yatex-mode")
 (add-to-list 'ac-modes 'latex-mode)
 (add-hook 'latex-mode-hook 'ac-l-setup)
 ;; for YaTeX
 (when (require 'auto-complete-latex nil t)
   (setq ac-l-dict-directory "~/.emacs.d/plugins/yasnippet/snippets/yatex-mode")
   (add-to-list 'ac-modes 'yatex-mode)
   (add-hook 'yatex-mode-hook 'ac-l-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; gtags �W�����v  http://qiita.com/yewton@github/items/d9e686d2f2a092321e34

 (setq gtags-prefix-key "\C-c")
 (require 'gtags)
 (require 'anything-gtags)
 ;; �L�[�o�C���h
 (setq gtags-mode-hook
       '(lambda ()
	  (define-key gtags-mode-map "\C-cs" 'gtags-find-symbol)
	  (define-key gtags-mode-map "\C-r" 'gtags-find-rtag)
	  (define-key gtags-mode-map "\C-t" 'gtags-find-tag)
	  (define-key gtags-mode-map "\C-cf" 'gtags-parse-file)))
 ;; gtags-mode ���g������ mode �� hook �ɒǉ�����
 (add-hook 'c-mode-common-hook
	   '(lambda()
	      (gtags-mode 1)))

 ;; update GTAGS
 (defun update-gtags (&optional prefix)
   (interactive "P")
   (let ((rootdir (gtags-get-rootpath))
	 (args (if prefix "-v" "-iv")))
     (when rootdir
       (let* ((default-directory rootdir)
	      (buffer (get-buffer-create "*update GTAGS*")))
	 (save-excursion
	   (set-buffer buffer)
	   (erase-buffer)
	   (let ((result (process-file "gtags" nil buffer nil args)))
	     (if (= 0 result)
		 (message "GTAGS successfully updated.")
	       (message "update GTAGS error with exit status %d" result))))))))
 (add-hook 'after-save-hook 'update-gtags)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; R�AESS�̐ݒ�

 ;; �p�X�̒ǉ�
 (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/ess")
 ;; �g���q�� r, R �̏ꍇ�� R-mode ���N��
 (add-to-list 'auto-mode-alist '("\\.[rR]$" . R-mode))
 ;; R-mode ���N�����鎞�� ess-site �����[�h
 (autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t)
 ;; R ���N�����鎞�� ess-site �����[�h
 (autoload 'R "ess-site" "start R" t)
 ;; R-mode, iESS ���N������ۂɌĂяo���������֐�
 (setq ess-loaded-p nil)
 (defun ess-load-hook (&optional from-iess-p)
   ;; �C���f���g�̕���4�ɂ���i�f�t�H���g2�j
   (setq ess-indent-level 4)
   ;; �C���f���g�𒲐�
   (setq ess-arg-function-offset-new-line (list ess-indent-level))
   ;; comment-region �̃R�����g�A�E�g�� # ���g���i�f�t�H���g##�j
   (make-variable-buffer-local 'comment-add)
   (setq comment-add 0)

   ;; �ŏ��� ESS ���Ăяo�������̏���
   (when (not ess-loaded-p)
     ;; �A���_�[�X�R�A�̓��͂� " <- " �ɂȂ�Ȃ��悤�ɂ���
     (ess-toggle-underscore nil)
     ;; C-c r ���������ۂɕ\��������␔�̏���l
     ;; �\�����������Ə������d���Ȃ�
     (setq anything-R-help-limit 40)
     (setq anything-R-local-limit 20)
     ;; C-c r �� R �̊֐���I�u�W�F�N�g�������ł���悤�ɂ���
     (when (require 'anything-R nil t)
       ;; ess-smart-comma ���������ꂽ�̂� repospkg �� localpkg �͂��܂�K�v�Ȃ�����
       (setq anything-for-R-list '(anything-c-source-R-help
				   anything-c-source-R-local))
       (define-key ess-mode-map (kbd "C-c r") 'anything-for-R)
       (define-key inferior-ess-mode-map (kbd "C-c r") 'anything-for-R))
     ;; C-c C-g �� �I�u�W�F�N�g�̓��e���m�F�ł���悤�ɂ���
     (require 'ess-R-object-popup nil t)
     ;; �⊮�@�\��L���ɂ���
     (setq ess-use-auto-complete t)
     ;; anything ���g�������̂� IDO �͎ז�
     (setq ess-use-ido nil)
     ;; �L�����b�g���V���{����ɂ���ꍇ�ɂ��G�R�[�G���A�Ƀw���v��\������
     (setq ess-eldoc-show-on-symbol t)
     ;; �N�����Ƀ��[�L���O�f�B���N�g����q�˂��Ȃ��悤�ɂ���
     (setq ess-ask-for-ess-directory nil)
     ;; # �̐��ɂ���ăR�����g�̃C���f���g�̋������ς��̂𖳌��ɂ���
     (setq ess-fancy-comments nil)
     (setq ess-loaded-p t)
     (unless from-iess-p
       ;; �E�B���h�E��1�̏�Ԃ� *.R ���J�����ꍇ�̓E�B���h�E���c�ɕ������� R ��\������
       (when (one-window-p)
	 (split-window-horizontally)
	 (let ((buf (current-buffer)))
	   (ess-switch-to-ESS nil)
	   (switch-to-buffer-other-window buf)))
       ;; R ���N������O���� auto-complete-mode �� off �ɂȂ�̂Ŏ��O�� on �ɂ���
       ;; cf. ess.el �� ess-load-extras
       (when (and ess-use-auto-complete (require 'auto-complete nil t))
	 (add-to-list 'ac-modes 'ess-mode)
	 (mapcar (lambda (el) (add-to-list 'ac-trigger-commands el))
		 '(ess-smart-comma smart-operator-comma skeleton-pair-insert-maybe))
	 (setq ac-sources '(ac-source-R ac-source-filename)))))

   (if from-iess-p
       ;; R �̃v���Z�X�����ɂȂ���΃E�B���h�E�𕪊�����
       (if (> (length ess-process-name-list) 0)
	   (when (one-window-p)
	     (split-window-horizontally)
	     (other-window 1)))
     ;; *.R �� R �̃v���Z�X�����т���
     ;; ��������Ă����Ȃ��ƕ⊮�Ȃǂ֗̕��ȋ@�\���g���Ȃ�
     (ess-force-buffer-current "Process to load into: ")))

 ;; R-mode �N������̏���
 (add-hook 'R-mode-hook 'ess-load-hook)

 ;; R �N�����O�̏���
 (add-hook 'ess-pre-run-hook (lambda () (ess-load-hook t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; ���̑��̐ݒ�

 ;; �o�b�N�A�b�v�t�@�C�������Ȃ�
 (setq backup-inhibited t)
 (setq make-backup-files nil)
 ;; �I�����ɃI�[�g�Z�[�u�t�@�C��������
 (setq delete-auto-save-files t)

 ;;����炳�Ȃ�
 (setq visible-bell t)
 (setq ring-bell-function 'ignore)

 ;;�o�b�t�@�����ēǂݍ���
 (global-auto-revert-mode 1)

 ;;�X�N���v�g�ۑ����Ɏ����I��chmod+x���s��(�擪��#!)
 (add-hook 'after-save-hook
	   'executable-make-buffer-file-executable-if-script-p)
 ;;�ۑ����ɍs���̋󔒂��폜
 (add-hook 'before-save-hook 'delete-trailing-whitespace)

					;�R���p�C������save���邩�����Ȃ�
 (setq compilation-ask-about-save nil)

 ;; �}�E�X�̃z�C�[���X�N���[���X�s�[�h�𒲐�
 (global-set-key [wheel-up] '(lambda () "" (interactive) (scroll-down 1)))
 (global-set-key [wheel-down] '(lambda () "" (interactive) (scroll-up 1)))
 (global-set-key [double-wheel-up] '(lambda () "" (interactive) (scroll-down 1)))
 (global-set-key [double-wheel-down] '(lambda () "" (interactive) (scroll-up 1)))
 (global-set-key [triple-wheel-up] '(lambda () "" (interactive) (scroll-down 2)))
 (global-set-key [triple-wheel-down] '(lambda () "" (interactive) (scroll-up 2)))

 ;;�Ή����銇�ʂ�}��
 (defun electric-pair ()
   "Insert character pair without sournding spaces"
   (interactive)
   (let (parens-require-spaces)
     (insert-pair)))

 ;; undohist�̐ݒ�
 ;; Undo�̗�����emacs��������ɂ��ێ�����B
 ;; �܂�Ƀo�O��
 ;;(require 'undohist)
 ;;(undohist-initialize)
