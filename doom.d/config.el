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
(setq doom-theme 'doom-nord-light)
;; (setq doom-theme 'doom-dracula)

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
  (setq auth-sources '("~/.authinfo")))

;; Change default avy-keys to be DVORAK friendly
(setq avy-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n))

;; Change Default Formatter for Clojure
(setq-hook! 'clojure-mode-hook +format-with-lsp nil)
(set-formatter! 'cljstyle "cljstyle pipe" :modes '(clojure-mode))

(after! clojure-mode
  (setq! clojure-align-separator 'entire)
  (map! (:localleader
        (:map (clojure-mode-map clojurescript-mode-map)
             (:prefix ("e" . "eval")
                "p" #'cider-eval-sexp-at-point)))))


;; Add push git options
(map! :leader
      (:when (featurep! :tools magit)
       (:prefix-map ("g" . "git")
        :desc "Push" "p" #'magit-push
        :desc "Amend" "a" #'magit-commit-amend)))

(after! git-rebase
  (map!
   :map git-rebase-mode-map
   "S-SPC" #'magit-diff-show-or-scroll-up))

;; Still looking for a way to make this work, commenting in the meantime
;; (after! lispyville-mode
;;   (lispyville-mode-line-string))

;; Load keys and certificates from auth-sources
(setq network-stream-use-client-certificates t)

;; Make buffer names unique: https://www.gnu.org/software/emacs/manual/html_node/emacs/Uniquify.html
;; Source: http://pragmaticemacs.com/emacs/uniquify-your-buffer-names/
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;; macOS
(when IS-MAC
  (setq! mac-right-option-modifier 'meta)

  ;; Configure the location of Omnisharp for lsp server
  (setq! omnisharp-server-executable-path "/usr/local/bin/omnisharp"))
