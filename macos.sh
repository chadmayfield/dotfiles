#!/bin/bash

#install.sh - on initial install brew a cup to get ready for work

# author  : Chad Mayfield (chad@chd.my)
# license : gplv3


if ! [[ $OSTYPE =~ "darwin" ]]; then
	echo "ERROR: This should only be run on a Mac!"
	exit 1
fi

# show "unsupported" network drives (for non-Apple Time Machines)
defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1

#EOF 
