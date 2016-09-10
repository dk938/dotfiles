;;
;;for elisp debug
;; %emacs --debug-init
(setq load-path (nconc '("~/elisp") load-path))
(setq load-path (nconc '("/usr/share/emacs24/site-lisp") load-path))
;; title bar にファイル名を表示
(setq frame-title-format "%f")

(setq inhibit-startup-message t)
;;; hide tool bar
(tool-bar-mode 0)
;;;menu bar off
(menu-bar-mode 1)

;backspace
(global-set-key "\C-h" 'delete-backward-char)

;;package
(setq url-proxy-services
	'(("http" . "proxy.*.*.jp:8080")
	  ("https" . "proxy.*.*.jp:8080")))


(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(fset 'package-desc-vers 'package--ac-desc-version)
(package-initialize)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; show-paren-mode
;; 対応する括弧をハイライトする
(show-paren-mode t)

;;(setq show-paren-style 'parenthesis) ;; 対応括弧のみをハイライト (デフォルト)
(setq show-paren-style 'mixed)       ;; 対応括弧が画面外の場合、その間をハイライト
;; (setq show-paren-style 'expression)  ;; 対応括弧が画面内でもその間をハイライト

;; 対応する括弧が画面内になければ、括弧内を強調表示
(setq show-paren-ring-bell-on-mismatch t)

;; ハイライトするまでの遅延時間
(setq show-paren-delay 0.05) ;; default: 0.125

;; show-paren-mode (括弧対応の強調)の背景色
(set-face-background 'show-paren-match-face "light sky blue")
(set-face-background 'show-paren-mismatch-face  "tomato")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Shift + カーソルキーでBuffer間を移動
(windmove-default-keybindings)

;;(global-set-key "\C-o" 'toggle-input-method)
(global-set-key "\M-m" 'rgrep)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-r" 'query-replace)
(global-set-key "\M-R" 'revert-buffer)
(global-set-key "\C-\_" 'advertised-undo)
(global-set-key "\C-c\C-i" 'indent-region)
(global-set-key "\M-e" 'ediff-buffers)

(global-set-key "\M-h" 'hide-ifdef-mode)        ;hide ifdef
(global-set-key "\C-x\C-u" 'untabify)   ;タブをスペースに変換

;カーソルが行頭にあるときに、C-k を1回打つだけで
;その行全体が削除されるようにする
(setq kill-whole-line t)

;; js2-mode
(autoload 'js2-mode "js2-mode" nil t)
(setq js2-idle-timer-delay 10)
(setq js-indent-level 2)
(setq js2-basic-offset 2)

;;; ファイル名でモードを変える
(setq initial-major-mode 'fundamental-mode)
(setq default-major-mode 'fundamental-mode)

(setq auto-mode-alist 
      (append 
              '(
                (".cshrc$" . shell-script-mode)
                ("^.gdb" . gdb-script-mode)
                ("^dot-gdb" . gdb-script-mode)
                (".doc$" . text-mode)
                ("Readme" . text-mode)
                ("README" . text-mode)
                ("makefile" . makefile-mode)
                ("Makefile" . makefile-mode)
                ("^make" . makefile-mode)
                ("^Make" . makefile-mode)
                ("^Make" . makefile-mode)
                ("Doc" . text-mode)
                (".emacs" . emacs-lisp-mode)
                (".el$" . emacs-lisp-mode)
                (".cc$" . c++-mode)
                ("\\.c++$" . c++-mode)
                (".c$" . c++-mode)
                (".cpp$" . c++-mode)
                (".h$" . c++-mode)
                ("\\.c$" . c++-mode)
                (".y$" . c++-mode)
                (".tcl$" . tcl-mode)
                ("\\.pl$" . perl-mode)
                (".cgi$" . perl-mode)
                (".txt$" . fundamental-mode)
                (".ol$" . outline-mode)
                (".lisp$" . lisp-mode)
                (".lsp$" . lisp-mode)
                (".$" . fundamental-mode)
		(".js$" . js2-mode)
		(".jss$" . js2-mode)		
		(".htm$" . html-mode)
		(".html$" . html-mode)
                ("^configure." . fundamental-mode)
                                )))

(add-to-list 'auto-mode-alist '("\\.html\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;;; C-n で最下行より下にカーソル移動しなくなる
(setq next-line-add-newlines nil)

;;; 勝手に auto-fill-mode になる
;;;各行の文字数が揃う
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;;muleを軽くする。
(setq auto-save-interval 1000)

;;;時間表示
(display-time)
(setq display-time-24hr-format t)

;;; リージョンをハイライトする。
(transient-mark-mode t)

;; バッファを変えてもハイライトしたまま
(setq highlight-nonselected-windows t)

(global-set-key "\C-l" 'recenter)   ;; ctrl-l では着色しない(その方が早いから)
                                    ;; 着色するのは、 ctrl-L

(setq column-number-mode t)

; 先頭が #! で始まるファイルは実行権をつけて保存
(add-hook 'after-save-hook
	  'executable-make-buffer-file-executable-if-script-p)


(setq visible-bell nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GNU GLOBAL(gtags)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'gtags-mode "gtags" "" t)
;; (add-hook 'c-mode-common-hook
;;           '(lambda()
;;              (gtags-mode 1)
;;              (gtags-make-complete-list)))
(setq gtags-mode-hook
	  '(lambda ()
		 (local-set-key "\C-c\C-t" 'gtags-find-tag)
		 (local-set-key "\C-c\C-r" 'gtags-find-rtag)
;		 (local-set-key "\C-c\C-s" 'gtags-find-symbol)
		 (local-set-key "\C-c\C-p" 'gtags-pop-stack)
		 ))
;    * Ctrl+t gtagsでジャンプする一つ前の状態に戻る
;    * Alt+s 指定した変数、定義の定義元を探す
;    * Alt+r 指定した関数が参照されている部分を探す
;    * Alt+j 指定した関数が定義されている部分をさがす


;;; occur
; isearch 中にC-oで occur を起動
(defun isearch-occur ()
  "Invoke `occur' from within isearch."
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (occur
     (if isearch-regexp
         isearch-string (regexp-quote isearch-string)))))
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)

;;point のある位置の単語を occur にかける
(defun occur-at-point()
  (interactive)
  (if (thing-at-point 'word)
      (occur (thing-at-point 'word))
    (call-interactively 'occur)))

;;C-x bを便利に
;buffer の選択が i-search のような動作になります。 
(iswitchb-mode)
;同一名の buffer があったとき、 (開いているファイルのパスの一部が表示され) ちょっと見易くなります。 :-) 
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;summarye
;(require 'summarye)

;which-func (display-func)
;(setq which-func-modes (append which-func-modes '(js2-mode)))
(which-func-mode t)
(setq which-func-modes t)
(delete (assoc 'which-func-mode mode-line-format) mode-line-format)
(setq which-func-header-line-format
              '(which-func-mode
                ("" which-func-format)))
(defadvice which-func-ff-hook (after header-line activate)
  (when which-func-mode
    (delete (assoc 'which-func-mode mode-line-format) mode-line-format)
    (setq header-line-format which-func-header-line-format)))

;C-c h:hide/ C-c s:show
;; hideif #ifdef～#elsif～#else～#endif
(autoload 'hide-ifdef-mode "hideif" "Hide #ifdef segments." t nil)
(setq hide-ifdef-mode-hook
      '(lambda ()
	 ;; support #elif by kataoka
	 (setq hif-else-regexp (concat hif-cpp-prefix "el\\(se\\|if\\)"))
	 (setq hif-ifx-else-endif-regexp
	       (concat hif-ifx-regexp "\\|" hif-else-regexp "\\|" hif-endif-regexp))
	 (define-key hide-ifdef-mode-map "\C-ch" 'hide-ifdef-block)
	 (define-key hide-ifdef-mode-map "\C-cs" 'show-ifdef-block)))



;;
;; async byte compile
;;
;(require 'auto-async-byte-compile)
;(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
;(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  git
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'git)

;M-x vc-annotate
;(require 'git-blame)
;(require 'vc-git)
;(add-to-list 'vc-handled-backends 'GIT)
;(require 'git-show)


;; c source tag jump?
;; C-c s d or C-c s s
;(require 'xcscope)
;(cscope-setup)
;(setq cscope-do-not-update-database t)
