setopt no_beep
setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_cd
setopt correct

export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.poetry/bin
export PATH=$PATH:$HOME/.pyenv/bin
export PATH="$HOME/.poetry/bin:$PATH"
export PATH=$PATH:$HOME/bin

eval "$(pyenv init --path)"

if [ -x "`which go`" ]; then
    export GOPATH=$HOME/go
    export PATH="$GOPATH/bin:$PATH"
fi

# cd bookmark config
# cd @ + dirname
if [ -d "$HOME/.bookmarks" ]; then
  export CDPATH=".:$HOME/.bookmarks:/"
  alias goto="cd -P"
  function cd {
    if [[ ${1} =~ ^@ ]];then
      cd -P $1 || return 1
      return
    fi 
    builtin cd "$@" || return 1
  }

  function bmark {
    local current_dir=$(pwd)
    ln -s $current_dir ~/.bookmarks/@$(basename $current_dir)
  }
fi


# ----------------------------------------------------------------------
### Added by Zinit's installer
# ----------------------------------------------------------------------

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk


# ----------------------------------------------------------------------
### rust tools
# ----------------------------------------------------------------------

# ripgrep
zinit ice as"program" from"gh-r" mv"ripgres* -> rg" pick"rg/rg"
zinit light BurntSushi/ripgrep

# exa 
zinit ice as"program" from"gh-r" mv"exa* -> exa"
zinit light ogham/exa

if [[ $(command -v exa)  ]]; then
    alias e="exa --icons"
    alias l=e
    alias ls=e
    alias ea="exa -a --icons"
    alias la=ea
    alias ee="exa -aal --icons"
    alias ll=ee
    alias et="exa -T -L 3 -a -I 'node_modules|.git|.cache|__pycache__|vendor|tmp|.venv' --icons"
    alias lt=et
    alias eta="exa -T -a -I 'node_modules|.git|.cache|__pycache__|vendor|tmp|.venv' --color=always --icons | less -r"
    alias lta=eta
  else
    alias ll="ls -la"
    alias l1="ls -1"
    alias lt="tree -L 3 -I 'node_modules|.git|.cache|__pycache__|vendor|tmp|.venv'"
    alias ltl="lt | less -r"
fi
alias sl=ls
alias dc=cd
alias ..='cd ..'

# bat
zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat
if builtin command -v bat > /dev/null; then
  alias cat="bat"
fi

# fd
zinit ice as"program" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

### end of rust tools

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ----------------------------------------------------------------------
# plugin list
# ----------------------------------------------------------------------

# コマンド補完
zinit ice wait lucid
zinit light zsh-users/zsh-completions
# 入力補完
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions
# シンタックスハイライト
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting
# 256
zinit ice wait lucid 
zinit light chrissicool/zsh-256color
# cd補完
zinit ice wait lucid
zinit light b4b4r07/enhancd

# ----------------------------------------------------------------------
# basic
# ----------------------------------------------------------------------

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

setopt inc_append_history
# historyを共有
setopt share_history
# 重複を記録しない
setopt hist_ignore_dups
# スペースから始まるコマンド行はヒストリストから削除
setopt hist_ignore_space

# ----------------------------------------------------------------------
# alias
# ----------------------------------------------------------------------

# basic command
alias mkdir="mkdir -vp"
alias du="du -hc"
alias free="free -h"
alias ...="cd ../.."
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias so="source"

# python
alias python="python3"
alias pip="pip3"


# git
alias g="git"
alias gs="git status"
alias gc="git commit"
alias gcm="git commit -m"
alias ga="git add"
alias gp="git push"
alias gd="git diff"
alias gb="git branch"
alias gl="git log"
alias gpl="git pull"
alias gco="git checkout"
alias gf="git fetch"
alias gm="git merge"

# docker-compose
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcr="docker-compose restart"
alias dcp="docker-compose ps"

# docker
alias dp="docker ps"
alias di="docker images"
alias drmi="docker rmi"

# tmux
alias tmux="tmux -u"
alias t="tmux"

# neovim
if [[ $(command -v nvim ) ]]; then
    alias vi="nvim"
    alias vim="nvim"
    alias view="nvim -R"
fi

# zsh
alias zsh="vim ~/.zshrc"
alias szsh="source ~/.zshrc"

# ----------------------------------------------------------------------
# completion
# ----------------------------------------------------------------------

# コマンド補完
autoload -Uz compinit && compinit

# 小文字でも大文字にマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補をTabや矢印で選択可能
zstyle ':completion:*:default' menu select=1

# ----------------------------------------------------------------------
# hight-light
# ----------------------------------------------------------------------

# サジェストの色変更
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

# lsコマンドで色分けする
zstyle ':completion:*' list-colors $LSCOLORS

# ----------------------------------------------------------------------
# peco
# ----------------------------------------------------------------------

function peco-history-selection() {
    BUFFER=`history -n 1 | tac | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi
function peco-cdr () {
    local selected_dir="$(cdr -l | sed 's/^[0-9]* *//' | peco)"
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N peco-cdr
bindkey '^E' peco-cdr

#
function find_cd() {
    local selected_dir=$(find . -type d | peco)
    if [ - "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N find_cd
bindkey '^X' find_cd

alias de='docker exec -it $(docker ps | peco | cut -d " " -f 1) /bin/bash'

# ----------------------------------------------------------------------
# starship
# ----------------------------------------------------------------------

eval "$(starship init zsh)"

