# ~/.bash_profile: personal init file, executed by bash(1) for login shells

if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

#EOF

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH
