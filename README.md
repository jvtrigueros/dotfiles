# dotfiles

I tried to come up with a system to manage by dotfiles, but every attempt failed until now! I'm now using [`chezmoi`](https://github.com/twpayne/chezmoi) and it's fantastic! It seems like over engineering at first, but once you get the hang of it, it is straightforward and simple.

To install all my dotfiles in a new computer, there are some requirements:

* [homebrew](https://brew.sh/), this works on both macOS and Linux
* [git](https://git-scm.com/)

After that, simply run:

``` sh
chezmoi init --apply https://github.com/jvtrigueros/dotfiles.git
```

Which will clone the repository and copy the dotfiles to the right location. DONE!

## TODO
_Of course, it's not as simple as that but this will put the configuration at a good starting point, what's missing is the packages that need to be installed with brew or npm, but will leave that for a later date._
