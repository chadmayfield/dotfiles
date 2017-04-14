#!/bin/bash

# uninstall.sh - remove symlinks to dotfiles & copy backups into place

iam=$(whoami)
backupdir="~/.original_dotfile_backups"

if [ ! -d $backupdir ]; then
    echo "ERROR: The backup directory ($backupdir) doesn't exist!"
    exit 1
fi

# declare array with filenames
dotfiles=("vim" "vimrc" "gitconfig" "bash_profile" "bashrc" "dotpatterns")

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
#    if [ -e ${backupdir}/.${i} ]; then
        mv ${backupdir}/.${i} ~/
#    fi

    # chown file to $iam just in case
    if [[ $OSTYPE =~ "darwin" ]]; then
        chown -R ${iam}:staff ~/.${i}
    else
        chown -R ${iam}:${iam} ~/.${i}
    fi

    # chmod file to 0755, can change in future
    chmod -R 0755 $i
done

echo "done! successfully uninstalled dot files"

#EOF
