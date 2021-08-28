export PATH="/opt/homebrew/opt/ncurses/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/3.0.0/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/go"
export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"

setopt AUTO_CD                  # auto cd into path
setopt SHARE_HISTORY            # share history file across the sessions
setopt APPEND_HISTORY           # and append to it rather overwrite
setopt HIST_EXPIRE_DUPS_FIRST   # expire duplicate first
setopt HIST_IGNORE_DUPS         # do not store duplications
setopt HIST_FIND_NO_DUPS        # ignore duplicate when searching
setopt HIST_REDUCE_BLANKS       # remove blank lines from histody

# key binding
bindkey -v
autoload -U edit-command-line
zle -N edit-command-line
export VISUAL=nvim
export EDITOR=nvim
bindkey -M vicmd v edit-command-line
VIMODE='[I]'
function zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/[N]}/(main|viins)/[I]}"
    zle reset-prompt
}
zle -N zle-keymap-select

# auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
function expand-alias() {
    zle _expand_alias
    zle self-insert
}
zle -N expand-alias
bindkey -M main ' ' expand-alias
compinit -D ~/.cache/zsh/zcompdump-$ZSH_VERSION

# prompt
autoload -Uz vcs_info # make sure vcs_info function is available
setopt prompt_subst # allow dynamic command prompt
zstyle ':vcs_info:*' check-for-changes true # unsubmitted changes
zstyle ':vcs_info:*' stagedstr '%{%F{green}%B%} ●%{%b%f%}' # staged changes
zstyle ':vcs_info:*' unstagedstr '%{%F{red}%B%} ●%{%b%f%}' # unstaged changes
zstyle ':vcs_info:*' formats '%{%F{green}%}%25>…>%b%<<%{%f%}%{%f%}%c%u'
# zstyle ':vcs_info:*' actionformats '%{%F{cyan}%}%45<…<%R%<</%{%f%}%{%F{red}%}(%a|%m)%{%f%}%{%F{cyan}%}%S%{%f%}%c%u'
# zstyle ':vcs_info:git:*' patch-format '%10>…>%p%<< (%n applied)'

function preexec() {
  cmd_start=$(($(print -P %D{%s%6.}) / 1000))
}

function precmd() {
  if [ $cmd_start ]; then
    local now=$(($(print -P %D{%s%6.}) / 1000))
    local d_ms=$(($now - $cmd_start))
    local d_s=$((d_ms / 1000))
    local ms=$((d_ms % 1000))
    local s=$((d_s % 60))
    local m=$(((d_s / 60) % 60))
    local h=$((d_s / 3600))

    if   ((h > 0)); then cmd_time=${h}h${m}m
    elif ((m > 0)); then cmd_time=${m}m${s}s
    elif ((s > 9)); then cmd_time=${s}.$(printf %03d $ms | cut -c1-2)s # 12.34s
    elif ((s > 0)); then cmd_time=${s}.$(printf %03d $ms)s # 1.234s
    else cmd_time=${ms}ms
    fi

    unset cmd_start
  else
    # Clear previous result when hitting Return with no command to execute
    unset cmd_time
  fi
  vcs_info
}

RPROMPT='%F{cyan}$(if [ $cmd_time ]; then echo "($cmd_time) "; fi)%F{none}${vcs_info_msg_0_}'
if [ -n "$TMUX" ]; then ARROW='%F{green}$%f'; else ARROW='%F{240}$%f'; fi
PROMPT=$'%(?..%F{red}%?)%f %F{240}%5~\n%F{255}${VIMODE} %f%(!.#.${ARROW}) '


[ -f ~/dotfiles/zsh/aliases ] && source $HOME/dotfiles/zsh/aliases

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs -g "!{node_modules,.git}" 2> /dev/null'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --preview "cat {}"'

source ~/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
