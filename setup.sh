#!/bin/bash

# setup.sh - install/uninstall dotfiles, which symlinks dot files to hidden git #            repo for easy updating of dot files

# author  : Chad Mayfield (chad@chd.my)
# license : gplv3

iam=$(whoami)
backupdir="~/.original_dotfile_backups"
secretsdir="~/.secrets"

# declare array with filenames (on seperate lines for readability)
dotfiles=( vim 
           vimrc 
           gitconfig 
           bash_profile 
           bashrc 
           inputrc 
           dotpatterns 
           curlrc 
           wgetrc 
           screenrc 
           tmux.conf
           hushlogin )

install() {
    read -p "WARNING: You are about to overwrite existing files in your home directory. Are you sure? (y/n)" -n 1

    echo "installing dot files..."

    # make a backup/secrets directory
    mkdir -p $backupdir
    mkdir -p $secretsdir

    # loop through array and create symlinks to non-dot named file
    for i in ${dotfiles[@]}
    do
        if [ -e "~/.${i}" ]; then
            # make a backup to be safe
            mv ~/.${i} $backupdir
        fi

        # create symlink from original file/dir to git repo
        ln -sf $(pwd)/${i} ~/.${i}

        # chown file to $iam just in case
        if [[ $OSTYPE =~ "darwin" ]]; then
            chown -R ${iam}:staff $i
        else
            chown -R ${iam}:${iam} $i     
        fi

        # chmod file to 0644, can change in future
        #chmod -R 0644 $i
    done

    echo "done! successfully installed dot files"
}

uninstall() {
	read -p "You are about to restore your dot files to default, overwriting any existing files in your home directory. Are you sure? (y/n)" -n 1

	echo "uninstalling dot files..."

	# loop through array and remove symlinks & mv original back into place
	for i in ${dotfiles[@]}
	do
    	# remove symlink
    	if [ -L ~/.${i} ]; then
        	echo "removing link ~/.${i}"
        	rm -f ~/.${i}
    	fi

    	# restore backup
#    	if [ -e ${backupdir}/.${i} ]; then
        	mv ${backupdir}/.${i} ~/
#    	fi

    	# chown file to $iam just in case
    	if [[ $OSTYPE =~ "darwin" ]]; then
        	chown -R ${iam}:staff ~/.${i}
    	else
        	chown -R ${iam}:${iam} ~/.${i}
    	fi

    	# chmod file to 0644, can change in future
    	#chmod -R 0644 $i
	done

#    echo "removing secrets directory..."
#    rm -rf $secrets

	echo "done! successfully uninstalled dot files"
}

case $1 in
    install)
        install
        ;;
    uninstall)
        uninstall
        ;;
    *)
        echo "ERROR: Unknown option! Please change the option & try again."
        echo "  e.g. $0 <install|uninstall>"
        exit 1
esac

#EOF
