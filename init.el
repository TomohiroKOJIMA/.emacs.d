;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PATHの設定
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/auto-install/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; OSごとに分岐する設定
(cond
 ;;****************************************** Windows
 ((string-match "mingw" system-configuration)
  ;; 英語
  (set-face-attribute 'default nil
		      :family "Consolas"
		      :height 90)
  ;; 日本語
  (set-fontset-font
   nil 'japanese-jisx0208
   (font-spec :family "MeiryoKe_Console"))
  ;; 等幅にする
  (setq face-font-rescale-alist '(("MeiryoKe_Console" . 1.08)))

  ;; コーディング
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
  ;; 英語
  (set-face-attribute 'default nil
		      :family "Menlo" ;; font
		      :height 120)    ;; font size
  ;; 日本語
  (set-fontset-font
   nil 'japanese-jisx0208
   (font-spec :family "Hiragino Kaku Gothic ProN"))
  ;; 等幅にする
  (setq face-font-rescale-alist
	'((".*Hiragino_Mincho_pro.*" . 1.2)))

  ;; コーディング
  (set-language-environment 'Japanese)
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-clipboard-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8)
  (set-buffer-file-coding-system 'utf-8)

  ;; 円マークをバックスラッシュにする
  (define-key global-map [?¥] [?\\])

  ;; emacsとshellのPATHを共有する
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
  ;; 英語
  (set-face-attribute 'default nil
		      :family "monospace" ;; font
		      :height 120)    ;; font size
  ;; 日本語
  (set-fontset-font
   nil 'japanese-jisx0208
   (font-spec :family "monospacex"))

  ;; コーディング
  (set-language-environment 'Japanese)
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-clipboard-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8)
  (set-buffer-file-coding-system 'utf-8)

  ;; emacsとshellのPATHを共有する
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
;; 見た目関連

(global-linum-mode t)
(setq linum-format "%5d ") ; 5 桁分の領域を確保して行番号のあとにスペースを入れる

;; スタートアップページを表示しない
(setq inhibit-startup-message t)
(server-start)

;;タイトルバーにファイル名を表示
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))

;; ツールバーを消す
(tool-bar-mode 0)

;;同名ファイルのバッファ名の識別文字列を変更する
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;縦分割で折り返す
(setq truncate-partial-width-windows nil)
;;折り返し記号の色
(set-face-foreground 'fringe "gray50")
;;折り返し記号のとこの背景色
(set-face-background 'fringe "gray12")

;; region の色
(set-face-foreground 'default "white")
(set-face-background 'default "gray8")
(setq frame-background-mode 'dark)

;;カーソル行のハイライト
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
;;; カーソルの点滅を止める
(blink-cursor-mode 0)

;;透過の設定
(when window-system
  (progn
    (setq default-frame-alist
	  (append
	   (list
	    '(width  . 80)
	    '(height . 24)
	    '(alpha  . 90))
	   default-frame-alist))))

;; 画面サイズの設定
(if (boundp 'window-system)
    (setq initial-frame-alist
	  (append (list
		   '(vertical-scroll-bars . nil) ;;スクロールバーはいらない
		   '(width . 202) ;; ウィンドウ幅
		   '(height . 60) ;; ウィンドウの高さ
		   '(top . 0) ;;表示位置
		   '(left . 0) ;;表示位置
		   )
		  initial-frame-alist)))

;; リージョン指定，括弧対応に色をつける
(setq transient-mark-mode t)
(show-paren-mode)
(setq show-paren-style 'parenthesis)
(setq show-paren-delay 0.05) ;; default: 0.125

;;行，桁番号,バッファサイズの表示
(line-number-mode t)
(column-number-mode t)

;; 行末のスペースを表示
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
;; ショートカットキー

;; C-h で前方消去
(keyboard-translate ?\C-h ?\C-?)

;; C-k で行末の改行も消去
(setq kill-whole-line t)

;;C-Tabで別のウィンドウに移動
(define-key global-map[C-tab] 'other-window)
(define-key global-map [S-C-tab] (lambda () (interactive) (other-window -1)))

;; カーソル位置から行頭まで削除する "C-o"
(defun backward-kill-line (arg)
  "Kill chars backward until encountering the end of a line."
  (interactive "p")
  (kill-line 0))
(global-set-key (kbd "C-o") 'backward-kill-line)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-install
;; M-x auto-install-なんとか で依存関係を考慮して色々入れてくれる。
;; 起動時に重くなるので、使わない時にはOFFでも
(require 'auto-install)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; package elpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; anything http://d.hatena.ne.jp/tomoya/20090423/1240456834
;; "C-;"で起動 ファイリストをファイルから読み取り-作成は $ sudo contribute*.ruby > all.filelist
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
;; 問い合わせを簡略化 yes/no を y/n
(fset 'yes-or-no-p 'y-or-n-p)
					; yasnippetを置いているフォルダにパスを通す
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

;;; ベースとなるソースを指定
(defvar my-ac-sources
  '(ac-source-yasnippet
    ac-source-abbrev
    ac-source-dictionary
    ac-source-words-in-same-mode-buffers))
(setq-default ac-sources my-ac-sources)

(global-auto-complete-mode t)
;;; C-n / C-p で選択
(setq ac-use-menu-map t)

;;; yasnippetのbindingを指定するとエラーが出るので回避する方法。
(setf (symbol-function 'yas-active-keys)
      (lambda ()
	(remove-duplicates (mapcan #'yas--table-all-keys (yas--get-snippet-tables)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 個別の言語設定

;; cc-modeの自前スタイル設定
(add-hook 'c-mode-common-hook
	  (lambda()
	    (setq completion-mode t)
	    (setq compilation-window-height 10)
	    (setq c-basic-offset 2)
	    ;; cc-mode内で定義されるキーバインド
	    (define-key c-mode-base-map "\C-cc"      'compile)
	    (define-key c-mode-base-map "\C-cg"      'gdb)
	    (define-key c-mode-base-map "\C-ck" 'kill-compilation);やめる
	    (define-key c-mode-base-map "\C-ce" 'next-error)	;エラー検索
	    (define-key c-mode-base-map "\"" 'electric-pair)
	    (define-key c-mode-base-map "\'" 'electric-pair)
	    (define-key c-mode-base-map "(" 'electric-pair)
	    (define-key c-mode-base-map "[" 'electric-pair)
	    (define-key c-mode-base-map "{" 'electric-pair)
	    ;; 括弧や;を入力すると自動で改行
					;(setq c-auto-newline t)
	    ;; TAB はスペース 2 個ぶんで
	    (setq-default tab-width 2)
	    (setq indent-tabs-mode nil)
	    ;; # をインデントしない
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
	    ;; cc-mode内で定義されるキーバインド
	    (define-key c++-mode-base-map "\C-cc"      'compile)
	    (define-key c++-mode-base-map "\C-cg"      'gdb)
	    (define-key c++-mode-base-map "\C-ck" 'kill-compilation);やめる
	    (define-key c++-mode-base-map "\C-ce" 'next-error)	;エラー検索
	    (define-key c++-mode-base-map "\"" 'electric-pair)
	    (define-key c++-mode-base-map "\'" 'electric-pair)
	    (define-key c++-mode-base-map "(" 'electric-pair)
	    (define-key c++-mode-base-map "[" 'electric-pair)
	    (define-key c++-mode-base-map "{" 'electric-pair)
	    ;; 括弧や;を入力すると自動で改行
					;(setq c-auto-newline t)
	    ;; TAB はスペース 2 個ぶんで
	    (setq-default tab-width 2)
	    (setq indent-tabs-mode nil)
	    ;; # をインデントしない
	    (setq c-electric-pound-behavior '(alignleft))
	    (c-set-offset 'cpp-macro 0)
	    (c-set-offset 'cpp-macro-cont '+)
	    ))

(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(setq skeleton-pair 1)

;; markdownのコマンドのパス追加
(setq markdown-command "perl C:/strawberry/perl/site/bin/Markdown.pl")

;; markdown-mode の起動
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.txt\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; yatex-mode の起動
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;; yatexを置いているフォルダにパスを通す
(add-to-list 'load-path
	     (expand-file-name "~/.emacs.d/plugins/yatex1.77"))

;; 文章作成時の漢字コードの設定
;; 1 = Shift_JIS, 2 = ISO-2022-JP, 3 = EUC-JP, 4 = UTF-8
;; コードを指定してしまうと，別のコードのファイルも勝手に
;; ここで指定したコードに変換されてしまいトラブルのもとに
;; なるので，nilにしておくのが吉。
(setq YaTeX-kanji-code nil)

;;LaTeXコマンドの設定
(setq tex-command "platex")

;; OSごとに分岐する設定
(cond
 ;;****************************************** OSX
 ((string-match "apple-darwin" system-configuration)
  ;;YaTeXでのプレビューアコマンドを設定する
  (setq dvi2-command "open -a Preview")
  )

 ;;****************************************** Linux
 ((string-match "linux" system-configuration)
  ;;YaTeXでのプレビューアコマンドを設定する
  (setq dvi2-command "evince")
  )

 ;;****************************************** Windows
 ((string-match "mingw" system-configuration)
  ;;YaTeXでのプレビューアコマンドを設定する
  (setq dvi2-command "dviout")
  )
 );

;;AMS-LaTeX を使用すかどうか
(setq YaTeX-use-AMS-LaTeX t)

;; RefTeXをYaTeXで使えるようにする
(add-hook 'yatex-mode-hook '(lambda () (reftex-mode t)))
;; RefTeXで使うbibファイルの位置を指定する
;;(setq reftex-default-bibliography '("~/Library/TeX/bib/papers.bib"))

;;RefTeXに関する設定
(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)

;;RefTeXにおいて数式の引用を\eqrefにする
(setq reftex-label-alist '((nil ?e nil "~\\eqref{%s}" nil nil)))

;; [prefix] 英字 コマンドを[prefix] C-英字 に変更する
(setq YaTeX-inihibit-prefix-letter t)

;; 自動改行を抑制する
(add-hook 'yatex-mode-hook'(lambda ()(setq auto-fill-function nill)))

;;YaTeXの日本語のauto-completeが鬱陶しいときは以下をコメントアウトする
;; Auto Complete LaTeX の設定
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
;; gtags ジャンプ  http://qiita.com/yewton@github/items/d9e686d2f2a092321e34

(setq gtags-prefix-key "\C-c")
(require 'gtags)
(require 'anything-gtags)
;; キーバインド
(setq gtags-mode-hook
      '(lambda ()
	 (define-key gtags-mode-map "\C-cs" 'gtags-find-symbol)
	 (define-key gtags-mode-map "\C-r" 'gtags-find-rtag)
	 (define-key gtags-mode-map "\C-t" 'gtags-find-tag)
	 (define-key gtags-mode-map "\C-cf" 'gtags-parse-file)))
;; gtags-mode を使いたい mode の hook に追加する
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
;; R、ESSの設定

;; パスの追加
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/ess")
;; 拡張子が r, R の場合に R-mode を起動
(add-to-list 'auto-mode-alist '("\\.[rR]$" . R-mode))
;; R-mode を起動する時に ess-site をロード
(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t)
;; R を起動する時に ess-site をロード
(autoload 'R "ess-site" "start R" t)
;; R-mode, iESS を起動する際に呼び出す初期化関数
(setq ess-loaded-p nil)
(defun ess-load-hook (&optional from-iess-p)
  ;; インデントの幅を4にする（デフォルト2）
  (setq ess-indent-level 4)
  ;; インデントを調整
  (setq ess-arg-function-offset-new-line (list ess-indent-level))
  ;; comment-region のコメントアウトに # を使う（デフォルト##）
  (make-variable-buffer-local 'comment-add)
  (setq comment-add 0)

  ;; 最初に ESS を呼び出した時の処理
  (when (not ess-loaded-p)
    ;; アンダースコアの入力が " <- " にならないようにする
    (ess-toggle-underscore nil)
    ;; C-c r を押した際に表示される候補数の上限値
    ;; 表示数が多いと処理が重くなる
    (setq anything-R-help-limit 40)
    (setq anything-R-local-limit 20)
    ;; C-c r で R の関数やオブジェクトを検索できるようにする
    (when (require 'anything-R nil t)
      ;; ess-smart-comma が導入されたので repospkg と localpkg はあまり必要なさそう
      (setq anything-for-R-list '(anything-c-source-R-help
				  anything-c-source-R-local))
      (define-key ess-mode-map (kbd "C-c r") 'anything-for-R)
      (define-key inferior-ess-mode-map (kbd "C-c r") 'anything-for-R))
    ;; C-c C-g で オブジェクトの内容を確認できるようにする
    (require 'ess-R-object-popup nil t)
    ;; 補完機能を有効にする
    (setq ess-use-auto-complete t)
    ;; anything を使いたいので IDO は邪魔
    (setq ess-use-ido nil)
    ;; キャレットがシンボル上にある場合にもエコーエリアにヘルプを表示する
    (setq ess-eldoc-show-on-symbol t)
    ;; 起動時にワーキングディレクトリを尋ねられないようにする
    (setq ess-ask-for-ess-directory nil)
    ;; # の数によってコメントのインデントの挙動が変わるのを無効にする
    (setq ess-fancy-comments nil)
    (setq ess-loaded-p t)
    (unless from-iess-p
      ;; ウィンドウが1つの状態で *.R を開いた場合はウィンドウを縦に分割して R を表示する
      (when (one-window-p)
	(split-window-horizontally)
	(let ((buf (current-buffer)))
	  (ess-switch-to-ESS nil)
	  (switch-to-buffer-other-window buf)))
      ;; R を起動する前だと auto-complete-mode が off になるので自前で on にする
      ;; cf. ess.el の ess-load-extras
      (when (and ess-use-auto-complete (require 'auto-complete nil t))
	(add-to-list 'ac-modes 'ess-mode)
	(mapcar (lambda (el) (add-to-list 'ac-trigger-commands el))
		'(ess-smart-comma smart-operator-comma skeleton-pair-insert-maybe))
	(setq ac-sources '(ac-source-R ac-source-filename)))))

  (if from-iess-p
      ;; R のプロセスが他になければウィンドウを分割する
      (if (> (length ess-process-name-list) 0)
	  (when (one-window-p)
	    (split-window-horizontally)
	    (other-window 1)))
    ;; *.R と R のプロセスを結びつける
    ;; これをしておかないと補完などの便利な機能が使えない
    (ess-force-buffer-current "Process to load into: ")))

;; R-mode 起動直後の処理
(add-hook 'R-mode-hook 'ess-load-hook)

;; R 起動直前の処理
(add-hook 'ess-pre-run-hook (lambda () (ess-load-hook t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; その他の設定

;; バックアップファイルを作らない
(setq backup-inhibited t)
(setq make-backup-files nil)
;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;;音を鳴らさない
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;;バッファ自動再読み込み
(global-auto-revert-mode 1)

;;スクリプト保存時に自動的にchmod+xを行う(先頭に#!)
(add-hook 'after-save-hook
	  'executable-make-buffer-file-executable-if-script-p)
;;保存時に行末の空白を削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)

					;コンパイル時にsaveするか聞かない
(setq compilation-ask-about-save nil)

;; マウスのホイールスクロールスピードを調節
(global-set-key [wheel-up] '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [wheel-down] '(lambda () "" (interactive) (scroll-up 1)))
(global-set-key [double-wheel-up] '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [double-wheel-down] '(lambda () "" (interactive) (scroll-up 1)))
(global-set-key [triple-wheel-up] '(lambda () "" (interactive) (scroll-down 2)))
(global-set-key [triple-wheel-down] '(lambda () "" (interactive) (scroll-up 2)))

;;対応する括弧を挿入
(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

;; undohistの設定
;; Undoの履歴をemacsを閉じた時にも保持する。
;; まれにバグる
;;(require 'undohist)
;;(undohist-initialize)
