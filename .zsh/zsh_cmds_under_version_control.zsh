# Set up the prompt
autoload -Uz promptinit
promptinit
#prompt walters



# History
# Keep this many lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=9000
HISTFILE=~/.zsh_history
setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups # Do not write events to history that are duplicates of previous events
setopt share_history
setopt inc_append_history


# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


#############################################################################
# Config of ZSH itself 
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html

#setopt completealiases
bindkey -v # to set vim key bindings

# Vim undo and backspace doesn't stop at the point where you started insert mode
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

autoload -U colors && colors

#aliases
if ls -F --color=auto >&/dev/null; then
    eval `dircolors -b`
    alias ls="ls --color=auto -F"
else
    alias ls="ls -F"
fi
alias grep='grep --color=auto'
alias ll='ls -lh'
alias la='ls -a'
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"


# 10ms for key sequences (for going between vim normal and insert modes)
#KEYTIMEOUT=1 

# switch to COMMAND mode by using "jj" instead of ESC (but need to turn off the KEYTIMEOUT above)
bindkey -M viins 'jj' vi-cmd-mode


#### stuff here changes the command prompt
#https://wiki.archlinux.org/index.php/Zsh#Customizing_the_prompt
# to display git repo and branch currently working within
autoload -Uz vcs_info
setopt prompt_subst

precmd() {
    RPROMPT=""
    vcs_info
}

# stuff to change command prompt on the right
zle-keymap-select() {
  RPROMPT=""
  [[ $KEYMAP = vicmd ]] && RPROMPT="[ CMD ]"
  () { return $__prompt_status }
  zle reset-prompt
}
zle-line-init() {
  typeset -g __prompt_status="$?"
}
zle -N zle-keymap-select
zle -N zle-line-init

# command prompt on the left
# displays pwd and if inside a git repo, then the current branch; next,
# user@hostname, then `$` if logged in as normal user or `#` if logged in as root
PS1="
%{$fg[blue]%}[%~]% %{$fg[red]%}\$vcs_info_msg_0_ %{$reset_color%}
%{$fg_bold[cyan]%}%n%{$fg_no_bold[cyan]%}@%{$fg_bold[cyan]%}%M \
%{$fg_no_bold[green]%}%(!.#.$) %{$reset_color%}"
####


#only past commands beginning with the current input will be shown, 
# this does it for the up and down arrow keys in NORMAL mode
bindkey "^[[A" history-beginning-search-backward 
bindkey "^[[B" history-beginning-search-forward

# this does it for the j (down/more recent in hist) and k (up/older in hist) in COMMAND/vim mode
# http://stackoverflow.com/questions/3127392/backward-search-in-vi-mode
bindkey -M vicmd "k" history-beginning-search-backward 
bindkey -M vicmd "j" history-beginning-search-forward 

# To move to the beginning of the line (H) or end of a line (L) in vi COMMAND mode
bindkey -M vicmd "H" vi-beginning-of-line
bindkey -M vicmd "L" vi-end-of-line


# for tmux to play nice with vim
#alias tmux="TERM=screen-256color tmux"
TERM=screen-256color

# end of ZSH config 
#############################################################################


export EDITOR=vim
export VISUAL=gvim

# ruby gems installed locally
export GEM_PATH=$HOME/.local:$GEM_PATH
# now install gems locally with:
# gem install <gem_name> --install-dir ~/.local

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH=$HOME/.local/bin:$HOME/.cabal/bin:$PATH

alias sshy='ssh -Y'
alias ptvi='ptipython --vi'

# to set rstudio version of R
#export RSTUDIO_WHICH_R=/usr/local/bin/R

# git shortcuts
#alias gb='git branch '
#alias gc='git checkout '
#alias gcb='git checkout -b'
#alias ga='git add '
#alias gcm='git commit -m '
#alias gp='git push '
#alias gpu='git pull'
#alias gcl='git clone'
#alias gs='git status '
#alias gd='git diff'
#alias gh='git hist' ## hist is also an alias inside .gitconfig
#alias gl='git log'
#alias gk='gitk --all&'
#alias gx='gitx --all'
