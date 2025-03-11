;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Jose V. Trigueros"
      user-mail-address "")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;

(setq doom-font (font-spec :family "FantasqueSansM Nerd Font Mono" :size 16 :weight (if IS-MAC 'normal 'bold))
      doom-variable-pitch-font (font-spec :family "FantasqueSansM Nerd Font" :size 16))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-nord-light)
(setq doom-theme 'doom-dracula)
(custom-theme-set-faces! 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! super-save
  :config
  (super-save-mode +1))

(use-package! beacon
  :after doom-themes
  :config
  (beacon-mode +1)
  (setq beacon-color (let ((bg (face-attribute 'highlight :background nil t)))
                       (if (eq bg 'unspecified)
                           (face-attribute 'highlight :foreground nil t)
                         bg))
        beacon-blink-when-buffer-changes t
        beacon-blink-when-point-moves-vertically 10))

(defun jvt/magit-commit-amend ()
  (interactive)
  (magit-commit-amend '("-C" "HEAD")))

(after! magit
  (map!
   :map git-rebase-mode-map
   "S-SPC" #'magit-diff-show-or-scroll-up)
  (map!
   :map magit-diff-section-base-map
   "<s-return>" #'magit-diff-visit-file-other-window)
  (map! :leader
        (:prefix ("g" . "git")
                 (:prefix ("c" . "create")
                  :desc "Amend" "a" #'jvt/magit-commit-amend)
                 :desc "Push" "p" #'magit-push)))

;; Change default avy-keys to be DVORAK friendly
(setq avy-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n))
(setq avy-all-windows t)

(after! clojure-mode
  ;; Disable documentation pop, can still be summoned with M-x lsp-ui-doc-show
  (setq lsp-ui-doc-show-with-cursor nil)
  (setq lsp-ui-doc-show-with-mouse t)

  ;; Change Default Formatter for Clojure
  (set-formatter! 'cljstyle '("cljstyle" "pipe") :modes '(clojure-mode))
  (setq-hook! 'clojure-mode-hook
    +format-with-lsp nil
    +format-with 'cljstyle))
;;   (setq! clojure-align-separator 'entire)
;;   (map! (:localleader
;;           (:map (clojure-mode-map clojurescript-mode-map)
;;            (:prefix
;;             ("e" . "eval")
;;             "p" #'cider-eval-sexp-at-point)))))

(use-package! cider
  :after clojure-mode
  :config
  (set-lookup-handlers! 'cider-mode nil)
  (setq cider-save-file-on-load t))

(use-package! clj-refactor
  :after clojure-mode
  :config
  (set-lookup-handlers! 'clj-refactor-mode nil))

(setq! evil-cleverparens-use-s-and-S nil)

(add-hook! '(clojure-mode-hook emacs-lisp-mode-hook)
           #'evil-cleverparens-mode)

(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.bb\\'" . clojure-mode)
                ("Jenkinsfile" . groovy-mode)
                ("\\.astro" . web-mode))))

(use-package! kaocha-runner
  :after cider
  :config
  (map! (:localleader
         (:map (clojure-mode-map clojurescript-mode-map clojurec-mode-map)
               (:prefix ("k" . "kaocha")
                        "t" #'kaocha-runner-run-test-at-point
                        "r" #'kaocha-runner-run-tests
                        "a" #'kaocha-runner-run-all-tests
                        "w" #'kaocha-runner-show-warnings
                        "h" #'kaocha-runner-hide-windows)))))

;; Load keys and certificates from auth-sources
(setq auth-sources '("~/.authinfo"))
(setq network-stream-use-client-certificates t)

;; Make buffer names unique: https://www.gnu.org/software/emacs/manual/html_node/emacs/Uniquify.html
;; Source: http://pragmaticemacs.com/emacs/uniquify-your-buffer-names/
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;; ispell, for some reason this doesn't get set
(after! ispell
  (setq! ispell-dictionary "en")
  (setq! ispell-personal-dictionary
         (expand-file-name "ispell/jvtrigueros.pws" doom-data-dir)))

;; Specify location of Language Tool when installed with LinuxBrew
(if (featurep :system 'macos)
    (setq! langtool-http-server-host "localhost"
           langtool-http-server-port 8081)
  (setq! langtool-bin "/home/linuxbrew/.linuxbrew/opt/languagetool/bin/languagetool"))

(use-package! just-mode)
(use-package! chezmoi
  :config
  (setq chezmoi-command "chezmoi --use-builtin-diff"))

;; Allow scrolling sideways with the trackpad
(setq! mouse-wheel-flip-direction t
       mouse-wheel-tilt-scroll t)

;; Formatting for JSON files
(add-hook!
 json-mode-hook
 (setq! js-indent-level 2))

(after! lsp-mode
  ;; Add custom tags for lsp-yaml
  (setq! lsp-yaml-custom-tags ["!GetAtt" "!Split" "!ImportValue" "!Ref" "!Sub" "!reference"])
  (setq!
   ;; Disable the other terraform LSP client
   lsp-disabled-clients '(tfls)
   lsp-terraform-ls-enable-show-reference t
   lsp-enable-links t)

  (defun lsp-booster--advice-json-parse (old-fn &rest args)
    "Try to parse bytecode instead of json."
    (or
     (when (equal (following-char) ?#)
       (let ((bytecode (read (current-buffer))))
         (when (byte-code-function-p bytecode)
           (funcall bytecode))))
     (apply old-fn args)))

  (advice-add (if (progn (require 'json)
                         (fboundp 'json-parse-buffer))
                  'json-parse-buffer
                'json-read)
              :around
              #'lsp-booster--advice-json-parse)

  (defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
    "Prepend emacs-lsp-booster command to lsp CMD."
    (let ((orig-result (funcall old-fn cmd test?)))
      (message "orig-result: %s" orig-result)
      (message "command-from-exec-path: %s" (or (+python-executable-find (car orig-result))
                                                (executable-find (car orig-result))))
      (if (and (not test?)                             ;; for check lsp-server-present?
               (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
               lsp-use-plists
               (not (functionp 'json-rpc-connection))  ;; native json-rpc
               (executable-find "emacs-lsp-booster"))
          (progn
            (when-let ((command-from-exec-path (or (+python-executable-find (car orig-result)) ;; because Python is complicated
                                                   (executable-find (car orig-result)))))      ;; resolve command from exec-path (in case not found in $PATH)
              (setcar orig-result command-from-exec-path))
            (message "Using emacs-lsp-booster for %s!" orig-result)
            (cons "emacs-lsp-booster" orig-result))
        orig-result)))
  (advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command))

(when (not (featurep :system 'macos))
  (use-package! vterm
    :load-path  "~/.emacs.d/.local/straight/repos/emacs-libvterm"))

;;;;;;;;;;;;;;;;;;;
;; Custom Advice ;;
;;;;;;;;;;;;;;;;;;;

(defadvice!
  evil-scroll-down-center (count)
  "Centers the screen after scrolling down half a page, helps with disorientation."
  :after #'evil-scroll-down
  (evil-window-middle))

(defadvice!
  evil-scroll-up-center (count)
  "Centers the screen after scrolling up half a page, helps with disorientation."
  :after #'evil-scroll-up
  (evil-window-middle))

;;;;;;;;;;;;;;;;;;
;; Custom Hooks ;;
;;;;;;;;;;;;;;;;;;

(add-hook! 'better-jumper-post-jump-hook
  #'recenter)

;;;;;;;;;;
;; Ruby ;;
;;;;;;;;;;

(remove-hook 'ruby-mode-hook #'rubocop-mode)
(add-to-list 'flycheck-disabled-checkers 'ruby-rubocop)

(setq-hook! 'ruby-mode-hook
  +format-with-lsp nil
  +format-with 'rufo)

;;;;;;;;;;;;;;;;;;
;; workspace.el ;;
;;;;;;;;;;;;;;;;;;

(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))

;;;;;;;;;;;;;;;;;;
;; company-mode ;;
;;;;;;;;;;;;;;;;;;

(add-hook! 'company-box-mode-hook
  (setq company-frontends
        '(company-tng-frontend company-box-frontend)))

;;;;;;;;;;;;
;; python ;;
;;;;;;;;;;;;

(add-hook 'python-mode-hook #'mise-mode)

;;;;;;;;;;;;
;; lookup ;;
;;;;;;;;;;;;

(after! dumb-jump
  (setq +lookup-definition-functions
        '(+lookup-dictionary-definition-backend-fn
          +lookup-xref-definitions-backend-fn
          +lookup-project-search-backend-fn
          +lookup-evil-goto-definition-backend-fn))
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package! rsync-mode)

(use-package! ultra-scroll
  :init
  (setq scroll-conservatively 101
        scroll-margin 0)
  :config
  (ultra-scroll-mode 1))
