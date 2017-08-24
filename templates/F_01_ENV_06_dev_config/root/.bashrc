# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Customized Setting
alias c='clear'
alias grep='grep --color=auto'
alias ll='ls -alh'
alias l='ls -lh'
#alias v='vim +"colorscheme lucid"'
alias v='vim'
alias vv='vim -u /dev/null'
alias o='cd ..'
alias oo='cd ../..'
alias ooo='cd ../../..'
alias b='cd -'
alias be='bundle exec'
alias bk='bundle exec rake'
alias bl='bundle exec rails'

alias bv='
  echo "==================================="; \
  echo "     rails tmp:clear"; \
  echo "==================================="; \
  bundle exec rails tmp:clear ; \
  echo "" ; \
  echo "==================================="; \
  echo "     rails assets:clobber"; \
  echo "==================================="; \
  bundle exec rails assets:clobber ; \
  echo "" ; \
  echo "==================================="; \
  echo "     Start Rails in Dev Mode"; \
  echo "==================================="; \
  bundle exec rails server -b 0.0.0.0 ; \
  echo ""
  '

alias bn='
  echo "==================================="; \
  echo "     rails tmp:clear"; \
  echo "==================================="; \
  bundle exec rails tmp:clear ; \
  echo "" ; \
  echo "==================================="; \
  echo "     rails assets:clobber"; \
  echo "==================================="; \
  bundle exec rails assets:clobber ; \
  echo ""
  '

alias br='
  echo "==================================="; \
  echo "     rails tmp:clear"; \
  echo "==================================="; \
  bundle exec rails tmp:clear ; \
  echo "" ; \
  echo "==================================="; \
  echo "     rails assets:clobber"; \
  echo "==================================="; \
  bundle exec rails assets:clobber ; \
  echo "" ; \
  echo "==================================="; \
  echo "     rails assets:precompile RAILS_ENV=production"; \
  echo "==================================="; \
  bundle exec rails assets:precompile RAILS_ENV=production ; \
  echo "" ; \
  echo "==================================="; \
  echo "     touch tmp/restart.txt"; \
  echo "==================================="; \
  bundle exec rails restart ; \
  echo ""
  '

alias glo='git log --graph --stat --decorate --all'

alias gpush='
  echo "==================================="; \
  echo "     git status"; \
  echo "==================================="; \
  git status ; \
  echo "" ; \
  echo "==================================="; \
  echo "     git pull and git push"; \
  echo "==================================="; \
  git pull && git push ; \
  echo "" ; \
  echo "==================================="; \
  echo "     git status"; \
  echo "==================================="; \
  git status ; \
  echo ""
  '

export HISTTIMEFORMAT='%F %T '
export HISTSIZE=5000000
unset PROMPT_COMMAND

function parse_git_dirty_branch {                                         
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo -e "\033[01;31m$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1)/")" || echo -e "\033[1;32m$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1)/")"
}                                         

function git_since_last_commit {                                                                                                                                               
    LAST_COMMIT=$(git log --pretty=format:%ar -1 2> /dev/null)                                                                                                                 
    [[ ! -z "${LAST_COMMIT}" ]] && echo "(${LAST_COMMIT})"                                                                                                                     
}

# For PS1 console (31m -> RED prompt, 32m GREEN 33m YELLOW)
PS1='\[\e[1;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w $(parse_git_dirty_branch)\[\e[0;33m\]$(git_since_last_commit)\[\033[00m\]\n# '
