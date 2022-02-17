;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jose V. Trigueros"
      user-mail-address "")

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
(setq doom-font (font-spec :family "Fantasque Sans Mono" :size 16 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Fantasque Sans Mono" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-nord-light)
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

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

(after! magit
  (map!
   :map git-rebase-mode-map
   "S-SPC" #'magit-diff-show-or-scroll-up))

;; Change default avy-keys to be DVORAK friendly
(setq avy-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n))

;; Change Default Formatter for Clojure
(setq-hook! 'clojure-mode-hook +format-with-lsp nil)
(set-formatter! 'cljstyle "cljstyle pipe" :modes '(clojure-mode))

(after! clojure-mode
  ;; Disable documentation pop, can still be summoned with M-x lsp-ui-doc-show
  (setq lsp-ui-doc-show-with-cursor nil)
  (setq lsp-ui-doc-show-with-mouse t))

(add-hook 'clojure-mode-hook #'evil-cleverparens-mode)

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

;; Add push git options
(after! magit
  (map! :leader
        (:when (featurep! :tools magit)
         (:prefix-map ("g" . "git")
          :desc "Push" "p" #'magit-push
          :desc "Amend" "a" #'magit-commit-amend)))
  (map!
   :after magit
   :map magit-diff-section-base-map
   "<S-return>" #'magit-diff-visit-file-other-window))

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
         (expand-file-name "ispell/jvtrigueros.pws" doom-etc-dir)))

;; Specify location of Language Tool when installed with LinuxBrew
(setq! langtool-bin "/home/linuxbrew/.linuxbrew/opt/languagetool/bin/languagetool")

(use-package! just-mode)

(after! good-scroll
  (good-scroll-mode 1))

;; Allow scrolling sideways with the trackpad
(setq! mouse-wheel-flip-direction t
       mouse-wheel-tilt-scroll t)

;; Formatting for JSON files
(add-hook!
 json-mode-hook
 (setq! js-indent-level 2))

;; Configure TabNine
(after! company
  (setq +lsp-company-backends '(company-tabnine :separate company-capf company-yasnippet))
  (setq company-show-numbers t)
  (setq company-idle-delay 0))

