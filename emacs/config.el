;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jay Cunningham"
      user-mail-address "jcunningham@spec-trust.com")

;; ENABLE setting local variables, be wary
(setq enable-local-variables t)

;; natively compile eLISP shit
(when (fboundp 'native-compile-async)
  (setq comp-deferred-compilation t))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-rouge)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; don't ask to quit
(setq confirm-kill-emacs nil)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;

;; set up some great vim movements
(when (featurep! :editor evil +everywhere)

  ;; esc is entered immediately
  (setq evil-esc-delay 0)
  ;; set evil escape "jk" to a higher delay
  (setq evil-escape-delay 0.2)
  (setq evil-ex-search-case 'smart)

  ;; Snipe throughout the buffer
  (setq evil-snipe-scope 'whole-buffer)
  (setq evil-snipe-repeat-scope 'whole-buffer)
  (setq evil-snipe-smart-case t)
  ;; don't repeatedly snipe
  (setq evil-snipe-repeat-keys nil)
  (setq evil-snipe-override-mode nil)

  ;; Minibuffer
  (map! :map (evil-ex-completion-map evil-ex-search-keymap)
        "C-a" #'evil-beginning-of-line
        "C-b" #'evil-backward-char
        "C-f" #'evil-forward-char
        :gi "C-j" #'next-complete-history-element
        :gi "C-k" #'previous-complete-history-element)

  (define-key! :keymaps +default-minibuffer-maps
    "C-j"    #'next-line
    "C-k"    #'previous-line)
    ;;"C-S-j"  #'scroll-up-command
    ;;"C-S-k"  #'scroll-down-command)
  ;;
  ;; For folks with `evil-collection-setup-minibuffer' enabled
  (define-key! :states 'insert :keymaps +default-minibuffer-maps
    "C-j"    #'next-line
    "C-k"    #'previous-line)

  (define-key! read-expression-map
    "C-j" #'next-line-or-history-element
    "C-k" #'previous-line-or-history-element)
)

;; _ are parts of words now!
(modify-syntax-entry ?_ "w")


;; unique buffer names!
;; Specify that buffers must have unique names and specify logic
(require 'uniquify)
;; Use path components with forward slashes
(setq uniquify-buffer-name-style 'forward)

;; doom's `persp-mode' activation disables uniquify, b/c it says it breaks it.
;; It doesn't cause big enough problems for me to worry about it, so we override
;; the override. `pers-mode' is activated in the `doom-init-ui-hook', so we add
;; another hook at the end of the list of hooks to set our uniquify values.
(add-hook! 'doom-init-ui-hook
           :append ;; ensure it gets added to the end.
           #'(lambda () (require 'uniquify) (setq uniquify-buffer-name-style 'forward)))

;;
;; Defaults
;;
(setq-default tab-width 4)

;;
;; Modifiers
;;

;; open file in vertical split
(map! (:leader
       :prefix "f"
       :desc "find file, vsplit"
       :nv "v"
       #'projectile-find-file-other-window))

;; semantic zoom level
(map!
  :prefix "z"
  :desc "close semantic level folds"
  :nv "C"
  #'hs-hide-level)

;; no hs-show-level :( but whatever
(map!
  :prefix "z"
  :desc "open all folds"
  :nv "O"
  #'hs-show-all)

;; C-i is TAB in terminal emacs...i guess
(map! :desc "jump forward"
      :nv "C-i"
      #'better-jumper-jump-forward)

;; window navigation with vim keys
(map!
  (:nv "C-j" #'tmux-pane-omni-window-down)
  (:nv "C-k" #'tmux-pane-omni-window-up)
  (:nv "C-h" #'tmux-pane-omni-window-left)
  (:nv "C-l" #'tmux-pane-omni-window-right))

;; search for text under cursor
(map!
 :leader
 :prefix "s"
 :desc "search under cursor"
 :n "c"
 #'isearch-forward-symbol-at-point)

;; 15 is the original setting, but it seems like it's down to 0.5 via doom or
;; something, so try setting it back up to avoid GC pauses
(setq gcmh-idle-delay 10)

;; setup neotree for the terminal
;; use icons for neotree in the gui, otherwise terminal arrows
;;(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-window-fixed-size nil)

;; set our embarking character to M-; because C-; doesn't work in terminals
(map! (:desc "embark-act" :g "M-;" #'embark-act)
        (:desc "embark-act" :leader :nvi "a" #'embark-act))

;; enable split navigation for embark
(map!
 :map embark-file-map
 :desc "Open file in v-split" "v" (lambda (file) (interactive "f") (+evil/window-vsplit-and-follow) (find-file file))
 :desc "Open file in h-split" "h" (lambda (file) (interactive "f") (+evil/window-split-and-follow) (find-file file)))
(map!
 :map embark-buffer-map
 :desc "Open file in v-split" "v" (lambda (file) (interactive "f") (+evil/window-vsplit-and-follow) (find-file file))
 :desc "Open file in h-split" "h" (lambda (file) (interactive "f") (+evil/window-split-and-follow) (find-file file)))


;;
;; Hooks
;;

;; stop automatic parens insertion (and {)
(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

;;
;; LSP stuff
;;

;; disable LSP file watchers to prevent hanging
;(setq lsp-enable-file-watchers nil)
;
;;; set garbage collection threshold to 100mb (doom might do this already)
;(setq gc-cons-threshold 100000000)
;;; set how much data emacs can read from process output
;(setq read-process-output-max (* 1024 1024)) ;; 1mb
;
;(after! lsp-mode
;  ;; :global/:workspace/:file
;  (setq lsp-modeline-diagnostics-scope :workspace)
;  ;; moar diagnostics!
;  (setq lsp-ui-sideline-diagnostic-max-lines 20)
;  ;; use `K` to open this on demand instead of while hovering
;  ;; (setq lsp-ui-doc-enable nil)
;  (setq lsp-idle-delay 0.8)
;  (setq lsp-ui-sideline-show-code-actions nil)
;  (setq lsp-rust-analyzer-max-inlay-hint-length 40)
;  (setq lsp-rust-analyzer-server-display-inlay-hints t)
;  (setq lsp-rust-analyzer-display-reborrow-hints 'never)
;  (setq lsp-rust-analyzer-macro-expansion-method (quote rustic-analyzer-macro-expand))
;  (setq lsp-rust-analyzer-proc-macro-enable t)
;  (setq lsp-headerline-breadcrumb-enable t)
;  (setq lsp-treemacs-sync-mode 1)
;)
;
;;; flip the diagnostics results to show errors first...
;;; (after! consult
;;;   (define-advice consult-lsp--diagnostics--flatten-diagnostics
;;;       (:filter-return (values) reverse-diagnostics)
;;;       (reverse values)))
;;; remove the above to tinker
;;; (advice-remove 'consult-lsp--diagnostics--flatten-diagnostics 'consult-lsp--diagnostics--flatten-diagnostics@reverse-diagnostics)
;
;;;
;;; Rustic configurations
;;;
;
;(after! rustic
;  (setq rustic-compile-directory-method 'rustic-buffer-workspace)
;  (setq rustic-cargo-check-arguments "--tests --benches --all-features")
;  (setq rustic-default-test-arguments "--tests --all-features")
;  (setq rustic-default-clippy-arguments "--all-features")
;
;  ;; configure flycheck for rustic
;  ;;(push 'rustic-clippy flycheck-checkers)
;  ;;(remove-hook 'rustic-mode-hook 'flycheck-mode)
;
;  ;; use clippy instead of check for rust-analyzer diagnostics!
;  (setq lsp-rust-analyzer-cargo-watch-command "clippy")
;
;  (defun mp/rustic-get-crate-name ()
;    "Retrieve the crate name for the currently active buffer, or nil"
;    (let ((base-dir (rustic-buffer-crate)))
;    ;  (when base-dir
;        (let* ((cargo
;                (file-name-concat base-dir "Cargo.toml"))
;               (name
;                (when (file-exists-p cargo)
;                  (string-trim
;                   (shell-command-to-string
;                    (format "rg -m 1 '^ *name *=' %s | awk '{print $NF}' | jq -r"
;                            cargo))))))
;          (if (string-empty-p name) nil name))))
;
;  (map!
;        (:after rustic
;         :map rustic-mode-map
;         :localleader
;         :prefix "b"
;         :desc "cargo clippy (crate)"
;         :nv "p"
;         #'(lambda ()
;             (interactive)
;             (let ((rustic-compile-directory-method #'rustic-buffer-crate))
;             (rustic-run-cargo-command (format "cargo clippy %s" rustic-default-clippy-arguments) '(:buffer "*cargo-clippy*")))))
;        (:after rustic
;         :map rustic-mode-map
;         :localleader
;         :prefix "t"
;         :desc "cargo test (crate)"
;         :nv "p"
;         #'(lambda ()
;             (interactive)
;             (let ((rustic-compile-directory-method #'rustic-buffer-crate))
;             (rustic-run-cargo-command (format "cargo test %s" rustic-default-test-arguments)
;                                       '(:buffer "*cargo-test*")))))
;  )
;)
;
;(add-hook!
; rustic-mode
; #'(lambda ()
;     ;; natural behavior for launching split window
;     (setq display-buffer-alist (assoc-delete-all "^\\*rustic-compilation" display-buffer-alist))))
;
;;;
;;; Autocompletions and Searching
;;;
;
;;; fast autocompletion results
;(setq company-idle-delay 0.1)
;
;;; decrease time to help me out while i'm learnitating
;(setq which-key-idle-delay 0.8)
;(setq which-key-idle-secondary-delay 0.1)
