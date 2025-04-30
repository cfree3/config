# `config`

This repository contains my collection of configuration files for shells, editors, utilities, etc.

Most of these scripts should work on macOS or GNU/Linux, if the application in question runs on that
platform.

## How to use

This repository is structured for use with [GNU Stow][stow], as described by Brandon Invergo [on his
website][using].

To avoid having to specify a target, it's easiest to clone this repository into your home directory:

```sh
cd ~
git clone https://github.com/cfree3/config.git Config
cd Config
```
Then you can use Stow to put symlinks in place, app by app:

```sh
stow zsh
stow tmux
stow nvim
# etc.
```

[stow]:  https://www.gnu.org/software/stow/
[using]: https://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html
