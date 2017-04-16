My dot files
------------

**DISCLAIMER**: These work for me, they may not for you... (I may know what I am doing or not), it's up to you to decide to trust and actually use these files.  This README is *just for my reference*.

Yes, this is the obligatory startup/configuration files repo with detailed explanations (what can I say, I actually don't mind documentation and I find writing it helps me remember little details that would otherwise be lost into the ether of my mind).

For ease of use (for updating this repo), I keep these in a specific location in my home directory as a single repo.  I then use the install.sh script to create symlinks to each of the files.  When I make a change, I commit it to the repo and push it.


###### bash_profile
Nothing much here, just a call to source .bashrc if it exists.

###### bashrc
My bash [Run-Control](http://www.catb.org/~esr/writings/taoup/html/ch10s03.html) file.  The file is seperated between macOS and Linux so I only need one.  I try to keep this pretty clean, with few aliases and if a function is over 20 lines or so, I just write a new script and add it to the [scriptlets repo](https://github.com/chadmayfield/scriptlets).

###### dotpatterns
The definitions file for finddots/deldots functions to find and remove temp dot files created by Windows/macOS (while on my Linux servers... yes, I hate them).

###### gitconfig
My git config with aliases and color definitions.

###### github
My github username/token definition which is [inlcuded](http://agateau.com/2015/splitting-your-gitconfig/) in my gitconfig.

###### install.sh/uninstall.sh
Install/Uninstall files which backup the original startup and config files and creates symlinks to the repos

###### vimrc
Vim startup file, just bare vim, no plugins.

