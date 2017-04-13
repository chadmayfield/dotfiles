#!/bin/bash

# install.sh - symlink dotfiles to git repo for easy updating of dotfiles

if [ $# -ne 1 ]; then
    echo "ERROR: Please include your GitHub API Key for ~/.gitconfig!"
#    exit 1
fi

github_api=$1
iam=$(whoami)
backupdir="~/.original_dotfile_backups"

# declare array with filenames
dotfiles=("vim" "vimrc" "gitconfig" "bash_profile" "bashrc" "dotpatterns")

echo "installing dot files..."

# make a backup directory
mkdir -p $backupdir
echo "created backup directory at $backupdir for original files"

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
    chown -R $iam:$iam $i

    # chmod file to 0644, can change in future
    chmod -R 0644 $i
done

# add github api key to ~/.gitconfig 
sed -i "s/GITHUB_API/$github_api/g" ~/.gitconfig

echo "done! successfully installed dot files"

#EOF
