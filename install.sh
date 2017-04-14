#!/bin/bash

# install.sh - symlink dotfiles to git repo for easy updating of dotfiles

iam=$(whoami)
backupdir="~/.original_dotfile_backups"

# declare array with filenames
dotfiles=("vim" "vimrc" "gitconfig" "bash_profile" "bashrc" "dotpatterns")

echo "installing dot files..."

# make a backup directory
mkdir -p $backupdir

if [ -d $backupdir ]; then
    echo "created backup directory at $backupdir for original files"
else
    echo "ERROR: Unable to create directory, $backupdir!"
    exit 1
fi

# rename all of the gitignore files
for f in $(find . -name gitignore)
do
    new=$(echo $f | sed 's/gitignore/.gitignore/g')
    mv $f $new
done

# loop through array and create symlinks
for i in ${dotfiles[@]}
do
    # make a backup to be safe"
    mv ~/.${i} $backupdir

    # create symlink from original file/dir to git repo
    ln -sf $(pwd)/${i} ~/.${i}

    # chown file to $iam just in case
    if [[ $OSTYPE =~ "darwin" ]]; then
        chown -R ${iam}:staff $i
    else
        chown -R ${iam}:${iam} $i     
    fi

    # chmod file to 0755, can change in future
    chmod -R 0755 $i
done

echo "done! successfully installed dot files"

#EOF
