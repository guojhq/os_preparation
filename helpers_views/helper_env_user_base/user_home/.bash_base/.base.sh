# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# General aliases
alias c='clear'
alias grep='grep --color=auto'
alias ll='ls -alh'
alias l='ls -lh'
#alias v='vim +"colorscheme lucid"'
#alias v='vim'
alias v='[[ -f "Session.vim" ]] && vim -S || vim'
alias vv='vim -u /dev/null'
alias o='cd ..'
alias oo='cd ../..'
alias ooo='cd ../../..'
alias b='cd -'

# tmux aliases
alias t='tmux -2 new -s $(basename ${PWD})'
alias tt='tmux -2'
alias tn_s='tmux -2 new -s'
alias ta='tmux -2 a'
alias tl='tmux ls'

# Git aliases
alias gl='git log --graph --stat --decorate --all'
alias gls='git log --graph --stat --decorate --all --oneline'
alias glg='git log --graph --decorate --all --oneline'
alias gl-current='git log --graph --stat --decorate'
alias gls-current='git log --graph --stat --decorate --oneline'
alias glg-current='git log --graph --decorate --oneline'

alias gpush='
  echo "==================================="; \
  echo "     git status"; \
  echo "==================================="; \
  git status ; \
  echo "" ; \
  echo "==================================="; \
  echo "(git pull) && (git push) && (git push --tags)"; \
  echo "==================================="; \
  git pull && git push && git push --tags ; \
  echo "" ; \
  echo "==================================="; \
  echo "     git status"; \
  echo "==================================="; \
  git status ; \
  echo ""
  '

export HISTTIMEFORMAT='%F %T '
export HISTSIZE=5000000
umask 022

#------------------------------------------------------
#               Bash Prompt Config
#------------------------------------------------------
# Color
COLOR_RED='\[\e[1;31m\]'
COLOR_DARK_RED='\[\e[0;31m\]'
COLOR_GREEN='\[\e[1;32m\]'
COLOR_DARK_GREEN='\[\e[0;32m\]'
COLOR_YELLOW='\[\e[1;33m\]'
COLOR_DARK_YELLOW='\[\e[0;33m\]'
COLOR_BLUE='\[\e[1;34m\]'
COLOR_DARK_BLUE='\[\e[0;34m\]'
COLOR_CYAN='\[\e[1;36m\]'
COLOR_DARK_CYAN='\[\e[0;36m\]'
COLOR_MAGENTA='\[\e[1;35m\]'
COLOR_DARK_MAGENTA='\[\e[0;35m\]'
COLOR_END='\[\033[00m\]'

USER_COLOR="${COLOR_GREEN}"

# OS Version
OS_VER="$(lsb_release -irs | cut -d'.' -f-2)"

# vim Session.vim , *.swp
vim_session() {
  local vim_session="$(ls |grep  "Session.vim")"
  local vim_swp="$(ls -a | grep -E "^.[^[:space:]]+.swp$")"
  local vim_msg=""

  local vim_yellow="\e[1;33m"
  local vim_magenta="\e[1;35m"
  local vim_color_end="\033[00m"

  [[ -n "${vim_session}" ]] && vim_msg="${vim_yellow}(VIM:Session.vim)${vim_color_end}"
  [[ -n "${vim_swp}" ]] && vim_msg="${vim_msg}${vim_magenta} (VIM:swp)${vim_color_end}"
  [[ -n "${vim_msg}" ]] && echo -e "${vim_msg} "
}

# Logged On (pty , tty) who - show who is logged on (tty/pts) (terminal / ssh)
logged_on_session() {
  local logged_on_session="$(who | wc -l)"
  local logged_red="\e[1;31m"
  local logged_color_end="\033[00m"
  local logged_on_msg="${logged_red}(LoggedOn: ${logged_on_session})${logged_color_end}"

  [[ "${logged_on_session}" -ne 1 ]] && echo -e " ${logged_on_msg}"
}

# PS1
unset PROMPT_COMMAND
PS1_TAIL="\u@\h${COLOR_END} ${COLOR_DARK_CYAN}(${OS_VER}) \t${COLOR_END}\$(logged_on_session) \$(vim_session)${COLOR_BLUE}\w${COLOR_END}\n# "
PS1="${USER_COLOR}${PS1_TAIL}"

#------------------------------------------------------
#               User customized bash setting
#------------------------------------------------------
BASH_FILES="$(find $HOME/.bash_user -mindepth 1 -maxdepth 1 -type f -name "*.sh")"
if [[ -n "${BASH_FILES}" ]]; then
  for BASH_FILE in $BASH_FILES; do
    source $BASH_FILE
  done
fi

#------------------------------------------------------
#               Bash Prompt - For Git
#------------------------------------------------------
# ---Symbol---
GIT_SYMBOL_LOCAL="Ⓛ"
GIT_SYMBOL_REMOTE="Ⓡ"
#GIT_SYMBOL_LOCAL="ᄉ"
#GIT_SYMBOL_REMOTE="⚯"
GIT_SYMBOL_AHEAD="⬆"
GIT_SYMBOL_BEHIND="⬇"
GIT_SYMBOL_TAG="⚑"
GIT_SYMBOL_STASHED="☲"
GIT_SYMBOL_CHANGED="✎"
#GIT_SYMBOL_UNTRACKED="+"
GIT_SYMBOL_UNTRACKED="∿"
GIT_SYMBOL_STAGED="➜"
GIT_SYMBOL_CLEAN="✔"
GIT_SYMBOL_CONFLICT="✖"

# ---Git Prompt Setting---
GIT_PROMPT_SIMPLE_MODE=0
#GIT_PROMPT_FETCH_TIMEOUT=1
GIT_PROMPT_FETCH_TIMEOUT=5
AUTO_FETCH_REMOTE_STATUS=1

source $HOME/.bash_base/.prompt_for_git/.init.sh

