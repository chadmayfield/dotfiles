# dotfiles

[![Build Status](https://2a5d68700812.ngrok.io/api/badges/chadmayfield/dotfiles/status.svg)](https://2a5d68700812.ngrok.io/chadmayfield/dotfiles)

These are my customizations for Linux and macOS systems, my dotfiles.

Over the years I've had many different dotfiles, too many. So I created this repo as my obligatory location to house my customizations. However, it fell by the wayside and has not received much love. As I have time (which isn't likely) I'll be pruning it and adding to it from systems I currently have.


## Install
Installation of these files is accomplished with ansible. The only requirement for this repo is ansible. Once ansible is installed you can install this with;
```
ansible-playbook -K install.yml
```
This will ask for the sudo password to do things like install/remove go or update profile.d scripts.

### Screenshots

##### Prompt
![My prompt](http://i.imgur.com/gvGk25zl.png)

##### vim syntax highlighting
![Screenshot of my .vimrc](http://i.imgur.com/yxtMt8Ql.png)

## TODO
(as of 12/16/2020)
- [ ] Create and add an uninstall playbook.
- [ ] Start populating .zshrc with zsh specific code.
- [ ] Write tests for .bashrc to make sure they all still work!
- [ ] Organize better based on OS and functional area.
- [ ] Add additional files to pull secrets and use as env vars.
