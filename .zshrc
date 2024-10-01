# enable and source oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# theme [https://github.com/ohmyzsh/ohmyzsh/wiki/Themes]
ZSH_THEME="robbyrussell"

# enable command auto-correction
ENABLE_CORRECTION="true"

# plugins
plugins=(git)

# aliases
alias ll='ls -la'
alias gs='git status'
alias gp='git pull'
alias gd='git diff'

# export environment vars
export EDITOR='vim'
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE

# extended history options
setopt EXTENDED_HISTORY          # format history as ':start:elapsed;command'
setopt HIST_EXPIRE_DUPS_FIRST    # trim history by removing duplicate events
setopt HIST_FIND_NO_DUPS         # don't display a previously events
setopt HIST_IGNORE_ALL_DUPS      # delete old events if a new one is a dupe
setopt HIST_IGNORE_DUPS          # ignore dupes
setopt HIST_IGNORE_SPACE         # ignore commands starting with a space
setopt HIST_SAVE_NO_DUPS         # don't save dupes in history
setopt SHARE_HISTORY             # share history across all sessions

# prompt
PROMPT='%n@%m %1~ %# '

# enable syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# enable auto-suggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh