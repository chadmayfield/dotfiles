# ~/.bashrc: executed by bash(1) for non-login shells.
#
# author  : Chad Mayfield (chad@chd.my)
# license : gplv3
#
# --- bash initialization cheatsheet --------------
# examples in /usr/share/doc/bash/examples/startup-files
# LOGIN                               NON-LOGIN
# /etc/profile                        /etc/bash/bashrc
# 	/etc/profile.env (if exists)      ~/.bashrc
# 	/etc/bash/bashrc (if exists)
# 	/etc/profile.d/*.sh (if exists)
# ~/.bash_profile
# 	/etc/bashrc
# 	~/.bashrc (if exists)
# if( ~/.bash_profile doesn't exist)
# 	~/.bash_login

# only do something if running interactively
[ -z "$PS1" ] && return

# source files if exist
if [ -f /etc/bashrc ]; then . /etc/bashrc; fi
if [ -f /etc/global_bashrc ]; then . /etc/global_bashrc; fi

########## EXPORTS ##########
export PAGER=less
# directory bookmarks, used with cdable_vars, use $HOME, not ~
#export dotfiles="~/.dotfiles"
#export repos="~/Code/myrepos"
#export documents="~/Documents"
#export dropbox="~/Dropbox"

# prevent overwriting of files via stdout redirection (>) to force use '>|'
set -o noclobber
# set vi editing mode in bash
#set -o vi
# update win after every command
shopt -s checkwinsize
# just type directory to cd to it
shopt -s autocd
# autocorrect minor mispellings in cd
shopt -s dirspell
shopt -s cdspell

########## BASH HISTORY ##########
# bash_history: append instead of rewriting it
shopt -s histappend
# bash_history: one command per line
shopt -s cmdhist
# bash_history: allow a larger file
HISTFILESIZE=1000000
HISTSIZE=1000000
# bash_history: don’t store specific lines
HISTIGNORE='exit:ls:bg:fg:history'
# bash_history: ignorespace/ignoredups
HISTCONTROL=ignoreboth
# bash_history: record timestamps
HISTTIMEFORMAT='%F %T '
# bash_history: store immediately
PROMPT_COMMAND='history -a'
# trim long paths @ prompt (req Bash 4.x)
#PROMPT_DIRTRIM=2

########## ALIASES ##########
# to clean up .bashrc, maybe put aliases in ~/.bash_aliases and source it.
# see /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi

alias refresh='source ~/.bashrc'
alias -- -='cd -'                   # return to previous working directory
alias h='history'
alias vi='vim'
alias rm='rm -i'                    # interactive to avoid accidental rm
alias mkdir="mkdir -pv"
alias grep='grep --color=auto'

# get current ip
alias myip="curl -s http://ipinfo.io/ip"

# disk usage
alias ducks='du -cks ${1}* | sort -rn | head'
#alias ducks="find . -printf '%s %p\n'| sort -nr | head -10"

# alias to remove host key from known_hosts
alias removekey="if [ ! $1 ]; then echo "ERROR: You must specify a hostname/IP to remove!"; else ssh-keygen -R $1 fi"
#alias removekey="if [ ! $1 ]; then echo "Enter a known_hosts line number to remove."; else sed -i "${1}d" ~/.ssh/known_hosts; fi"

alias path='echo -e ${PATH//:/\\n}' # show $PATH on new lines for readablity
alias webify="mogrify -resize 690\> *.png"
alias serve='python -m SimpleHTTPServer'
#alias pc='python -ic "from __future__ import division; from math import *"'

# rerun last command but use sudo this time!
alias crap='sudo $(history -p \!\!)'
#alias crap='sudo $(fc -ln -1)'

# a ton of ls aliases
#alias la='ls -A'
#alias l='ls -CF'
#alias ll="ls -lhA"
#alias la='ls -Al'                # ls: show hidden files
#alias lx='ls -lXB'               # ls: sort by extension
#alias lk='ls -lSr'               # ls: sort by size
#alias lc='ls -lcr'               # ls: sort by change time  
#alias lu='ls -lur'               # ls: sort by access time   
#alias lr='ls -lR'                # ls: recursive ls
#alias lt='ls -ltr'               # ls: sort by date
#alias lm='ls -al | more'         # ls: pipe through 'more'
#alias lo="ls -o"

# deal with misspellings
alias kk='ll'
alias sl='ls'
alias ks='ls'
alias xs='cd'
alias vf='cd'
alias moew='more'
alias moer='more'

########## FUNCTIONS ##########
# parses past history files defined for keyword
histgrep() {
    grep -P $@ ~/.bash_history
}

if [[ $OSTYPE =~ "linux" ]]; then
    ########## EXPORTS ##########
    # required to glob file extensions in extract()
    shopt -s extglob

    # make less more friendly for non-text input files, see lesspipe(1)
    #[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    ########## PROMPT ##########
    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color) color_prompt=yes;;
    esac

    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            # We have color support; assume it's compliant with Ecma-48
            # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
            # a case would tend to support setf rather than setaf.)
            color_prompt=yes
        else
            color_prompt=
        fi
    fi

    force_color_prompt=yes

    if [ "$color_prompt" = yes ]; then
        # default debian/ubuntu prompt
        #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
        # my custom prompt, orange username for linux
        PS1="(\$?) [\[$(tput sgr0)\]\[\033[38;5;208m\]\u\[$(tput sgr0)\]\[\033[38;5;10m\]@\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;14m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]] \\$\[$(tput sgr0)\] "
    else
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fi
    unset color_prompt force_color_prompt

    ########## LINUX SPECIFIC ALIASES ##########
    # enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
    fi

    #alias ls='ls -hF --color'     # ls: add colors for filetype recognition
    alias df="df -Tha --total"     # show all
    alias free="free -mt"          # always show MB and Total
    alias wget="wget -c"           # always continue
    alias j='jobs -l'
    alias ping='ping -c 10'        # make default count 10
    alias ports='netstat -nape --inet'
    alias ns='netstat -alnp --protocol=inet | grep -v CLOSE_WAIT | cut -c-6,21-94 | tail +2'

    ########## FUNCTIONS ##########
    extract() {
        if [ -z "$1" ]; then
            # display usage if no parameters given
            echo "Usage: extract </path/to/file>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        else
            if [ -f $1 ] ; then
                # NAME=${1%.*}
                # mkdir $NAME && cd $NAME
                case $1 in
                    *.tar.bz2)  tar xvjf $1     ;;
                    *.tar.gz)   tar xvzf $1     ;;
                    *.tar.xz)   tar xvJf $1     ;;
                    *.lzma)     unlzma $1       ;;
                    *.bz2)      bunzip2 $1      ;;
                    *.rar)      unrar x -ad $1  ;;
                    *.gz)       gunzip $1       ;;
                    *.tar)      tar xvf $1      ;;
                    *.tbz2)     tar xvjf $1     ;;
                    *.tgz)      tar xvzf $1     ;;
                    *.zip)      unzip $1        ;;
                    *.Z)        uncompress $1   ;;
                    *.7z)       7z x $1         ;;
                    *.xz)       unxz $1         ;;
                    *.exe)      cabextract $1   ;;
                    *)          echo "ERROR: extract() '$1' unknown archive type!" ;;
                esac
            else
                echo "ERROR: $1 file does not exist!"
            fi
        fi
    }

    # when on linux rid ourselves of pesky macOS/Windows temp files
    dotpatterns=('._*' '.DS_Store' '.TemporaryItems' '.Trashes' '.Spotlight-V100' 'Thumbs.db' '*~')

    # TODO: fix these functions... they're very old!
    # dotsfind: search path for tmp files and list them
    dotsfind() {
        searchpath="$*"
        if [ -s ~/.dotpatterns ]; then
            config="$HOME/.dotpatterns"
            findcmd="find $searchpath -name"
        while read pattern;
        do
            echo -e "Results for pattern $pattern: "
            eval "$findcmd $pattern -print > /tmp/p.txt"
            cat /tmp/p.txt
            if [ -s /tmp/p.txt ]; then
                cat /tmp/p.txt
                echo " "
            else
                echo "No files found."
                echo " "
            fi
        rm /tmp/p.txt
        done<$config
        echo " "
        else
            echo "ERROR: No ~/.dotpatterns file is defined and/or populated.  Please create it at ~/.dotpatterns and populate it with your search patterns."
        fi
    }

    # dotsdel: search path and delete tmp files
    dotsdel() {
        searchpath="$*"
        if [ -s ~/.dotpatterns ]; then
            config="$HOME/.dotpatterns"
            findcmd="find $searchpath -name"
            while read pattern;
            do
                eval "$findcmd $pattern -print0 | xargs -0 rm -rf > /tmp/p.txt"
                echo -e "Successfully deleted all files with the pattern: $pattern"
                rm /tmp/p.txt
            done<$config
            echo " "
        else
            echo "ERROR: No ~/.dotpatterns file is defined and/or populated." 
            echo "Please create at at ~/.dotpatterns and populate it with your search patterns."
        fi
    }

elif [[ $OSTYPE =~ "darwin" ]]; then
    ########## EXPORTS ##########
    # set term color to 256
    TERM="xterm-256color"

    ########## PROMPT ##########
    # default macOS Sierra prompt: 'hostname:~ username$ '
    # PS1='\h:\W \u\$ '
    # my custom prompt, blue username for macos
    PS1="(\$?) \n[\[$(tput sgr0)\]\[\033[38;5;32m\]\u\[$(tput sgr0)\]\[\033[38;5;10m\]@\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;14m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]] \\$\[$(tput sgr0)\] "

    ########## MAC SPECIFIC ALIASES ##########
    # show ls with colors
    alias ls='ls -G'
    # view driectory tree with out brew installing tree
    alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
    # format man page as a pdf and open it
    alias man2pdf='if [ $# -ne 1 ]; then echo "ERROR: You must supply a man page to convert!" else; $(man -t $1 | open -f -a Preview.app); fi'
    # open pdf/png/jpg/tiff/gif/bmp with Preview from Terminal
    alias preview='if [ $# -ne 1 ]; then echo "ERROR: You must supply a file to open in Preview.app!"; else $(open -a Preview.app $1); fi'
    # get wifi connection history
    alias wifihistory="defaults read /Library/Preferences/SystemConfiguration/com.apple.airport.preferences | grep LastConnected -A7"
    # get the weather
    alias weathershort="finger o:84096@graph.no"
    alias weather="finger 84096@graph.no"
    #alias weather="finger saltlakecity@graph.no"

    ########## FUNCTIONS ##########

else
    echo "ERROR: Unknown OSTYPE ($OSTYPE), unable to source anything!"
fi 

#EOF