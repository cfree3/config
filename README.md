`config`
========
This repository contains my collection of configuration files for shells, editors, utilities, etc.
Much of it is specific to a GNU/Linux-type environment; but where I've wanted to share files with
Mac OS X, I have attempted to write the configs such that they will work well in both environments.
(`.vimrc` and `.zshrc` are two examples of that.)

Grab an individual file
-----------------------
If moving to a new system, perhaps temporarily, it can be useful to grab an individual config file.
I have redirects set up to make this easy:

```shell
wget http://curtisfree.com/config/${path_to_config}
```

For example:

```shell
wget http://curtisfree.com/config/.vimrc
wget http://curtisfree.com/config/.config/openbox/rc.xml
```

Apparently `curl` won't handle HTTP 303 redirections, so you'd best stick with `wget`. Check out
[Homebrew](http://mxcl.github.io/homebrew/) for installing `wget` on OS X.
