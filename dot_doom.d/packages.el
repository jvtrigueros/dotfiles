;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)

(package! super-save)

(package! benchmark-init)

(package! lsp-treemacs)

(package! beacon)

(package! just-mode)

(package! free-keys)

(package! chezmoi
          :recipe (:host github
                   :repo "tuh8888/chezmoi.el"))

(package! blamer)

(package! restclient-jq)

(package! topsy
  :recipe (:host github
           :repo "alphapapa/topsy.el"))

(package! mise
  :recipe (:host github
           :repo "liuyinz/mise.el"))

;;;;;;;;;;;;;
;; Clojure ;;
;;;;;;;;;;;;;

(package! evil-cleverparens)
(package! kaocha-runner)
(package! html-to-hiccup)

;;;;;;;;;;
;; Ruby ;;
;;;;;;;;;;

;; Disable Ruby plugins, they don't really help
(package! bundler
  :disable t)
(package! minitest
  :disable t)
(package! rubocop
  :disable t)
(package! robe
  :disable t)
(package! rake
  :disable t)

(when (modulep! :tools tree-sitter)
  (package! ts-fold :pin "c3da5520b988720f7f6e9e5e11b60746598112e0"
    :recipe (:host github :repo "emacs-tree-sitter/ts-fold")))

(package! rsync-mode
  :recipe (:host github
           :repo "r-zip/rsync-mode"))

(package! ultra-scroll
  :recipe (:host github
           :repo "jdtsmith/ultra-scroll"))
;;;
