`config`
========
This repository contains my collection of configuration files for shells, editors, utilities, etc.
Much of it is specific to a GNU/Linux-type environment; but where I've wanted to share files with
Mac OS X, I have attempted to write the configs such that they will work well in both environments.
(`.vimrc` and `.zshrc` are two examples of that.)

Grab an individual file
-----------------------
If moving to a new system, perhaps temporarily, it can be useful to grab an individual config file.

```shell
wget https://raw.githubusercontent.com/cfree3/config/master/${path_to_config}
```

For example:

```shell
wget https://raw.githubusercontent.com/cfree3/config/master/.vimrc
wget https://raw.githubusercontent.com/cfree3/config/master/.config/openbox/rc.xml
```

If you're a fan of `curl`, you can of course use that -- or any equivalent tool.
