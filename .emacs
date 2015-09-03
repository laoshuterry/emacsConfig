;设置用户名和邮件地址
(setq user-full-name    "Rain Tian")
(setq user-mail-address "dictatorterry@gmail.com")
;设置emacs的插件搜索路径 递归搜索
(add-to-list 'load-path "~/.emacs.d/lisp")
;显示行
(setq mouse-yank-at-point t)
(global-linum-mode 1)
;设置TAB默认的宽度
(setq default-tab-width 4)
;在标题栏显示buffer的名字，而不是emacs@wangyin.com这样没用的提示
(auto-image-file-mode)
;光标移动到鼠标下时，鼠标自动弹开
(mouse-avoidance-mode 'animate)
;光标显示为一竖线
(setq-default cursor-type 'bar)
;关闭起动时的那个“开机画面”
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
;使用ibuffer
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
;显示时间
(display-time-mode 1) 
;24小时格式
(setq display-time-24hr-format t) 
;显示日期
(setq display-time-day-and-date t)
;隐藏菜单设置
;(menu-bar-mode -1)
;隐藏工具栏
(tool-bar-mode -1)
;隐藏滚轴
(scroll-bar-mode -1)
;高亮当前行
(global-hl-line-mode 1)
;标题栏显示buffer名字
(setq frame-title-format "%d@emacs")
;防止页面滚动时跳动，scroll-margin 3可以在靠近屏幕边沿3行时就开始滚动，可以很好的看到上下文。
(setq default-major-mode 'text-mode)
;将yes/no替换为y/n
(fset 'yes-or-no-p 'y-or-n-p)
;按下C-x k立即关闭掉当前的buffer
(global-set-key (kbd "C-x k") 'kill-this-buffer)
;自动换行
(global-visual-line-mode 1)
;------------------------------------------------------------------------------
;设置MELPA包管理器
;------------------------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives
	'("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives 
	'("marmalade" . "http://marmalade-repo.org/packages/"))
(when (< emacs-major-version 24)
 	 (add-to-list 'package-archives 
 	'("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
;设置Solarized主题
(load-theme 'sanityinc-tomorrow-night  t)
;设置环境的编码
(require 'unicad)
;(set-language-environment 'UTF-8)
;设置Evil-Mode模式
(require 'evil)
(evil-mode 1)
;设置cscope
(require 'xcscope)
;设置ag搜索(需要下载silversearcher-ag)
(require 'ag)
(setq ag-highlight-search t)
;设置flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
;设置autopair
(require 'autopair)
(autopair-global-mode)
;设置Keyfreq
(require 'keyfreq)
;设置ctyoes,自动识别C文件中的结构体
(require 'ctypes)
(ctypes-auto-parse-mode 1)
;设置session插件，使Emacs可以查看最近打开的文件
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
;------------------------------------------------------------------------------
;设置idle-highlight,自动高亮当前焦点所在的符号
;------------------------------------------------------------------------------
(require 'highlight-symbol)
(global-set-key [(shift f3)] 'highlight-symbol-at-point)
(global-set-key [(control shift f3)] 'highlight-symbol-next)
(global-set-key [(control meta f3)] 'highlight-symbol-prev)
;------------------------------------------------------------------------------
;设置folding,折叠代码
;------------------------------------------------------------------------------
(load-library  "folding")
(declare (special fold-fold-on-startup
		  fold-keys-already-setup
		  ))
    
(setq fold-fold-on-startup t)
(folding-mode-add-find-file-hook)

(setq fold-keys-already-setup nil)
(add-hook 'folding-mode-hook
	  (function (lambda()
		      (unless fold-keys-already-setup
			(setq fold-keys-already-setup t)
			(define-prefix-command 'ctl-f-folding-mode-prefix)
			(define-key 'ctl-f-folding-mode-prefix "f" 'fold-fold-region)
			(define-key  'ctl-f-folding-mode-prefix "e" 'fold-enter)
			(define-key 'ctl-f-folding-mode-prefix "x" 'fold-exit)
			(define-key  'ctl-f-folding-mode-prefix "b" 'fold-whole-buffer)
			(define-key 'ctl-f-folding-mode-prefix "o" 'fold-open-buffer)
			(define-key 'ctl-f-folding-mode-prefix "h" 'fold-hide)
			(define-key 'ctl-f-folding-mode-prefix "s" 'fold-show)
			(define-key 'ctl-f-folding-mode-prefix "t" 'fold-top-level)
			(define-key 'ctl-f-folding-mode-prefix "f" 'fold-fold-region)
			)
		      (local-set-key "\C-f" 'ctl-f-folding-mode-prefix))))

(fold-add-to-marks-list 'sgml-mode
			"<!-- {" 
 			"<!-- } -->" " --> ")
(fold-add-to-marks-list 'c-mode "/* <" "/* > */" "*/")
(fold-add-to-marks-list 'c++-mode
			"//<" "//>" "")
(fold-add-to-marks-list 'LaTeX-mode "%%% {{{" "%%% }}}" " ")
(fold-add-to-marks-list 'latex2e-mode "%%% {{{" "%%% }}}" " ")
(fold-add-to-marks-list 'latex-mode "%%%% {{{" "%%%% }}}" " ")
(fold-add-to-marks-list 'BibTeX-mode "%%% {{{" "%%% }}}" " ")
(fold-add-to-marks-list 'lisp-mode ";;; {" ";;; }" "")
(fold-add-to-marks-list 'lex-mode  " /* {{{ " " /* }}} */ " "*/")
(fold-add-to-marks-list 'html-mode "<!-- { " "<!-- } -->" "-->")
(fold-add-to-marks-list 'shell-script-mode "# {{{" "# }}}" nil)
(fold-add-to-marks-list 'sh-mode "# {{{ " "# }}}" nil)
;------------------------------------------------------------------------------
;YASnippet自动补全设置
;------------------------------------------------------------------------------
(require 'yasnippet)
(yas-global-mode 1)
;------------------------------------------------------------------------------
;Auto Complete自动补全设置
;------------------------------------------------------------------------------
(require 'auto-complete-config)
(ac-config-default)
(auto-complete-mode 1)
(setq ac-use-quick-help nil)
;输入4个字符才开始补全
(setq ac-auto-start 3) 
;补全的快捷键，用于需要提前补全
(global-set-key "\M-/" 'auto-complete)  ;
;0.3秒后显示菜单
(setq ac-auto-show-menu 0.3)
;选择菜单项的快捷键
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
;menu设置为12 lines
(setq ac-menu-height 12)
;------------------------------------------------------------------------------
;C Headers自动补全设置
;------------------------------------------------------------------------------
(defun my:ac-c-headers-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))
(add-hook 'c++-mode-hook 'my:ac-c-headers-init)
(add-hook 'c-mode-hook 'my:ac-c-headers-init)
;------------------------------------------------------------------------------
;CC-MODE设置
;------------------------------------------------------------------------------
;激活cc-mode模式
(require 'cc-mode)
(setq-default indent-tabs-mode  nil)
(setq tab-width 4
      c-basic-offset 4)
(global-set-key (kbd "RET") 'newline-and-indent)
;------------------------------------------------------------------------------
;MARKDOWN MODE设置
;------------------------------------------------------------------------------
(autoload 'markdown-mode "markdown-mode"
"Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;------------------------------------------------------------------------------
;Google C Style设置
;------------------------------------------------------------------------------
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
;------------------------------------------------------------------------------
;Sourcepair设置(类似与Vim下的A.vim)
;------------------------------------------------------------------------------
(require 'sourcepair) ;;头文件导航
(define-key global-map [(control f12)] 'sourcepair-jump-to-headerfile) ;;跳转到头文件的设置
(setq sourcepair-source-path    '( "." "../*" "../../*" ))
(setq sourcepair-header-path    '( "." "include" "../include" "../*" "../../*"))
;------------------------------------------------------------------------------
;doxymacs设置
;------------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/lisp/doxymacs/")
(require 'doxymacs)
;;注释高亮，针对C和C++程序  
(defun my-doxymacs-font-lock-hook ()  
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))  
      (doxymacs-font-lock)))  
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)  
(doxymacs-mode);doxymacs-mode常true  
(add-hook 'c-mode-common-hook 'doxymacs-mode) ;; 启动doxymacs-mode  
(add-hook 'c++-mode-common-hook 'doxymacs-mode) ;; 启动doxymacs-mode
(defconst doxymacs-C++-file-comment-template
 '("/* =================================================================================" > n
   " * " > n
   " * " (doxymacs-doxygen-command-char) "Filename:    "
   (if (buffer-file-name)
       (file-name-nondirectory (buffer-file-name))
     "") > n
   " * " (doxymacs-doxygen-command-char) "Author:      " (user-full-name)
   (doxymacs-user-mail-address)
   > n
   " * " (doxymacs-doxygen-command-char) "Created:     " (current-time-string) > n
   " * " > n
   " * " (doxymacs-doxygen-command-char) "Descrition:  " (p "Brief description of this file: ") > n
   " * " > n
   " * " p > n
   " * ""===============================================================================*/" > n)
 "Default C++-style template for file documentation.")
;==============================================================================
;系统定制自动添加脚本
;==============================================================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-expand-on-auto-complete t)
 '(ac-show-menu-immediately-on-auto-complete t)
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(background-color "#002b36")
 '(background-mode dark)
 '(c-default-style (quote ((c-mode . "") (c++-mode . "") (java-mode . "java") (awk-mode . "awk") (other . "gnu"))))
 '(cursor-color "#839496")
 '(custom-safe-themes (quote ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(doxymacs-doxygen-style "C++")
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-source-path (quote (("/" "/"))))
 '(fci-rule-color "#393939")
 '(foreground-color "#839496")
 '(global-auto-complete-mode t)
 '(org-agenda-files (quote ("~/1.org")))
 '(tabbar-mode t nil (tabbar))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#f2777a") (40 . "#f99157") (60 . "#ffcc66") (80 . "#99cc99") (100 . "#66cccc") (120 . "#6699cc") (140 . "#cc99cc") (160 . "#f2777a") (180 . "#f99157") (200 . "#ffcc66") (220 . "#99cc99") (240 . "#66cccc") (260 . "#6699cc") (280 . "#cc99cc") (300 . "#f2777a") (320 . "#f99157") (340 . "#ffcc66") (360 . "#99cc99"))))
 '(vc-annotate-very-old-color nil))
 '(vc-annotate-background nil)
 '(global-cedet-m3-minor-mode 1)
 '(global-srecode-minor-mode 1)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;==============================================================================
;Package Title: CEDET - Collection of Emacs Development Environment Tools
;Description: CEDET是一堆完全用elisp实现的emacs工具的集合.
;Components:
;+--------+--------------------------------------------------------------------
;EDE      |用来管理项目，像IDE把文件作为一个project来管理
;+--------+--------------------------------------------------------------------
;Semantic |代码间跳转和自动补全两大功能通过semantic实现
;+--------+--------------------------------------------------------------------
;SRecode  |是一个代码模板系统
;+--------+--------------------------------------------------------------------
;Cogre    |主要和图形相关，比如生成UML图
;+--------+--------------------------------------------------------------------
;Speedbar |Speedbar用于显示目录树，函数列表等
;+--------+--------------------------------------------------------------------
;EIEIO    |EIEIO是一个底层库，它为elisp加入了OO支持 
;+--------+--------------------------------------------------------------------
;ECB      |代码浏览器，需单独安装配置，为Emacs提供IDE窗口配置
;+--------+--------------------------------------------------------------------
;------------------------------------------------------------------------------
;EDE配置
;------------------------------------------------------------------------------
(global-ede-mode 1)
;------------------------------------------------------------------------------
;Semantic配置
;------------------------------------------------------------------------------
(semantic-mode 1)
(global-semantic-highlight-func-mode 1)
(global-semantic-decoration-mode 1)
(global-semantic-stickyfunc-mode 1)
(global-semantic-idle-completions-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semanticdb-minor-mode 1)
(global-semantic-idle-summary-mode 1)
(global-semantic-mru-bookmark-mode 1)
(global-semantic-idle-local-symbol-highlight-mode 1)
(global-semantic-highlight-edits-mode 1)
(global-semantic-show-unmatched-syntax-mode 1)
(global-semantic-show-parser-state-mode 1)
;------------------------------------------------------------------------------
;ECB配置
;------------------------------------------------------------------------------
;设置ECB路径（虽然ECB是PACKAGE包自动安装的，但是路径也要
;设置，以后更新插件的时候也要更新路径！） 
(add-to-list 'load-path "~/.emacs.d/elpa/ecb-20140215.114")
;加载ECB，且自动开启
(require 'ecb)
;(require 'ecb-autoloads)
;自动激活ECB，关闭每天提示
(setq ecb-auto-activate t
      ecb-tip-of-the-day nil)
(setq ecb-layout-name "left15")
;设置LAYOUT显示方式，具体显示方式可以查看
;http://ecb.sourceforge.net/docs/Changing-the-ECB-layout.html
;显示隐藏ECB窗口
(global-set-key (kbd "C-'") 'ecb-show-ecb-windows)
(global-set-key (kbd "M-'") 'ecb-hide-ecb-windows)
;------------------------------------------------------------------------------
;SR-SPEEDBAR配置
;------------------------------------------------------------------------------
;(require 'sr-speedbar)
;(global-set-key (kbd "C-'") 'sr-speedbar-toggle)
