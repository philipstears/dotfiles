# Path to your oh-my-zsh installation.
export ZSH=/home/stears/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration
SHARE_HISTORY="false"
INC_APPEND_HISTORY="true"

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Stears: Hide default user prompt
DEFAULT_USER=stears

# Stears: Mostly copied from default bashrc
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias evil='emacs -nw'

# Stears: NOX stuff
export PATH="$HOME/opt/cross/bin:$PATH"
export PATH="$HOME/opt/bochs/bin:$PATH"

# Stears: various erlang things
export PATH="$PATH:$HOME/opt/rebar/bin"
export PATH="$PATH:$HOME/opt/bin"

# Stears: npm
export PATH="$PATH:$HOME/npm/bin"
export NODE_PATH="$NODE_PATH:/home/stears/npm/lib/node_modules"

# Stears: gimme Haskell!
export PATH=~/.cabal/bin:/opt/cabal/1.20/bin:/opt/ghc/7.8.4/bin:$PATH

# Stears: ruby
source /home/stears/.rvm/scripts/rvm

# Stears: time to try nvim properly
alias vim=nvim
alias vi=nvim

alias fuck='eval $(thefuck $(fc -ln -1))'
alias ohmy=fuck

# Stears: zsh sets LESS to "-R", I prefer git's FRX style
export LESS="FRX"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

PATH=$PATH:/home/stears/010editor;export PATH; # ADDED BY INSTALLER - DO NOT EDIT OR DELETE THIS COMMENT - 87FF8EFC-483D-BCAA-D67D-735CF60410D1 6B4D39B2-404B-FF74-1CCA-2F5960ED10B8
