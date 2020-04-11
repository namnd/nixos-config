HISTFILE=~/.cache/zsh/history
HISTSIZE=10000
SAVEHIST=10000

setopt AUTO_CD                  # auto cd into path
setopt SHARE_HISTORY            # share history file across the sessions
setopt APPEND_HISTORY           # and append to it rather overwrite
setopt HIST_EXPIRE_DUPS_FIRST   # expire duplicate first
setopt HIST_IGNORE_DUPS         # do not store duplications
setopt HIST_FIND_NO_DUPS        # ignore duplicate when searching
setopt HIST_REDUCE_BLANKS       # remove blank lines from histody


bindkey -v
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

autoload -U promptinit; promptinit

# auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -D ~/.cache/zsh/zcompdump-$ZSH_VERSION

[ -f $HOME/dotfiles/aliases ] && source $HOME/dotfiles/aliases
LS_COLORS='di=94:ex=92:ln=36'
export LS_COLORS


ZSH_PATH=$HOME/dotfiles/zsh

source $ZSH_PATH/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7a7a7a"
