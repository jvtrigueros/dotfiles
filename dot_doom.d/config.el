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

(setq doom-font (font-spec :family "FantasqueSansMono Nerd Font Mono" :size 16 :weight (if IS-MAC 'normal 'bold))
      doom-variable-pitch-font (font-spec :family "FantasqueSansMono Nerd Font" :size 16))

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
          :desc "Amend" "a" #'magit-commit-amend)
         :desc "Push" "p" #'magit-push)))

;; Change default avy-keys to be DVORAK friendly
(setq avy-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n))
(setq avy-all-windows t)

;; Change Default Formatter for Clojure
(setq-hook! 'clojure-mode-hook +format-with-lsp nil)
(set-formatter! 'cljstyle "cljstyle pipe" :modes '(clojure-mode))

(after! clojure-mode
  ;; Disable documentation pop, can still be summoned with M-x lsp-ui-doc-show
  (setq lsp-ui-doc-show-with-cursor nil)
  (setq lsp-ui-doc-show-with-mouse t))

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

(add-to-list 'auto-mode-alist '("\\.bb\\'" . clojure-mode))

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
         (expand-file-name "ispell/jvtrigueros.pws" doom-etc-dir)))

;; Specify location of Language Tool when installed with LinuxBrew
(setq! langtool-bin "/home/linuxbrew/.linuxbrew/opt/languagetool/bin/languagetool")

(use-package! just-mode)
(use-package! chezmoi)

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
  (setq company-show-quick-access t)
  (setq company-idle-delay 0))

;; Enable Pixel Precision Scroll for Emacs 29+
(add-hook 'text-mode-hook #'pixel-scroll-precision-mode)

;; Add custom tags for lsp-yaml
(setq! lsp-yaml-custom-tags ["!GetAtt" "!Split" "!ImportValue" "!Ref" "!Sub"])

(setq!
 ;; Disable the other terraform LSP client
 lsp-disabled-clients '(tfls)
 lsp-terraform-ls-enable-show-reference t
 lsp-enable-links t)

;; browse-at-remote configuration for Gerrit, this may ruin it for other repositories...
(setq! browse-at-remote-append-path-to-host "/plugins/gitiles")

(when (not IS-MAC)
  (use-package! vterm
    :load-path  "~/.emacs.d/.local/straight/repos/emacs-libvterm"))

;;;;;;;;;;;;;;;;;;;
;; Custom Advice ;;
;;;;;;;;;;;;;;;;;;;

(defadvice!
  evil-scroll-down-center (count)
  "Centers the screen after scrolling down half a page, helps with disorientation."
  :after #'evil-scroll-down
  (evil-scroll-line-to-center count))

(defadvice!
  evil-scroll-up-center (count)
  "Centers the screen after scrolling up half a page, helps with disorientation."
  :after #'evil-scroll-up
  (evil-scroll-line-to-center count))

;;;;;;;;;;
;; Ruby ;;
;;;;;;;;;;

(set-formatter! 'rufo "rufo" :modes '(ruby-mode) :ok-statuses '(0 3))

(defun meraki/vterm-zeus-test ()
  "Insert ./script/zeus test <filename>:<lineno> on vterm"
  (interactive)
  (require 'vterm)
  (eval-when-compile (require 'subr-x))
  (let* ((buf (current-buffer))
         (filename (file-relative-name
                    (if (rspec-buffer-is-spec-p)
                        (buffer-file-name)
                      (rspec-spec-file-for (buffer-file-name)))
                    (doom-project-root)))
         (lineno (when (and (rspec-buffer-is-spec-p)
                            (region-active-p))
                   (concat ":" (number-to-string (line-number-at-pos)))))
         (command (concat "./script/zeus test " filename lineno)))
    (unless (get-buffer vterm-buffer-name)
      (vterm))
    ;; (display-buffer vterm-buffer-name t)
    ;; (switch-to-buffer-other-window vterm-buffer-name)
    (pop-to-buffer vterm-buffer-name)
    (vterm--goto-line -1)
    (message command)
    (vterm-send-string command)
    (vterm-send-return)
    (pop-to-buffer buf)
    (use-region-p)))

(map! :after ruby-mode
      :localleader
      :map ruby-mode-map
      :prefix ("z" . "zeus")
      "t" #'meraki/vterm-zeus-test)
