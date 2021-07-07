
unsetopt beep
unsetopt correct_all

ZSH_THEME="jay"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-history-substring-search
  kubectl
  rust
)

autoload -U colors && colors

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '(%b)'
 
# verify banging
setopt hist_verify

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
_nix_prompt=""
if [[ ! -z $IN_NIX_SHELL ]]; then
    _nix_prompt="%F{23}(nix) %{$reset_color%}"
fi
export PROMPT='${_nix_prompt}%F{15}[%F{1}%n%F{15}@ %F{51}%c %F{46}λ${vcs_info_msg_0_} %F{15}] %'
#export PROMPT='%{$fg[white]%}[%{$fg[red]%}%n%{$fg[white]%}@ %{$fg[cyan]%}%c%{green%} ${vcs_info_msg_0_} %{$fg[white]%}] %{$reset_color%}%'

#ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=cyan,underline
#ZSH_HIGHLIGHT_STYLES[precommand]=fg=cyan,underline
#ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan,underline
#export PROMPT='[%n@%m: %c]$ '

# previous and next
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

bindkey 'jk' vi-cmd-mode

export EDITOR=vim
export VISUAL=vim

export PATH=~/scripts:$PATH

alias newmux='tmux new-session -A -s base'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -al'
alias g='git'
alias vim='nvim'

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /usr/share/nvm/init-nvm.sh
