#!/bin/bash

# brew_install.sh - on initial install brew a cup to get ready for work

# author  : Chad Mayfield (chad@chd.my)
# license : gplv3

# brew download location from https://brew.sh/ (docs: http://docs.brew.sh/)
url="https://raw.githubusercontent.com/Homebrew/install/master/install"

if [[ $OSTYPE =~ "darwin" ]]; then
    command -v brew >/dev/null 2>&1; echo "already installed! updating..." || \
        { echo "installing brew... && ruby -e $(curl -fsSL $url)"; }
else
    echo "ERROR: This should only be run on a Mac!"
    exit 1
fi

# add some extras to macos
pkg=( icdiff 
      mercurial
      dos2unix
      xhyve
      speedtest
      git-cal
      "tap showwin/speedtest"
      xz
      p7zip
      "imagemagick --with-webp" )

# add security tools
pkg+=( aircrack-ng hydra john nmap )

# update to make sure we're latest
brew update

# upgrade already installed formulae
brew upgrade

# brew formulae one by one
for i in "${pkg[@]}"
do
    brew install $i
    # steep for a couple of seconds
    sleep 2
done

# list formulae installed
echo "Your currently installed formulae are;"
brew list

# cleanup
brew cleanup

#EOF
