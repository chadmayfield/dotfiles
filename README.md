# Chad's dotfiles
------------

Yes, this is the obligatory startup/configuration files repo...

![My prompt](http://i.imgur.com/gvGk25zl.png)

![Screenshot of my .vimrc](http://i.imgur.com/yxtMt8Ql.png)

## Install
**DISCLAIMER**: I use these configuration files everyday and they work, for you however, they may not.  It's up to you to review the code and ultimately trust it.

Generally I clone this repository and place it in `~/.dot_files` (for easy updating).  When the install runs it will create a backup directory at `~/.dot_files_original` and move the originals into it, creating symlinks in their place.

```bash
git clone https://github.com/chadmayfield/dot_files.git ~/.dot_files && cd ~/.dot_files && ./setup.sh install
```

To update simply change directory and run `git pull`

```bash
cd ~/.dot_files/ && git pull
```

## Uninstall
The uninstall will remove all symlinks and move the original files back into place, deleting the backup directory.


## Installing extras with Homebrew
There are a few things that I like to add on a Mac via [Homebrew](https://brew.sh/).  This script takes care of installing (if not installed), updating, and installing the formulae.

```bash
./brew.sh
```
