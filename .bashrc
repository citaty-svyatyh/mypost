# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

alias dusk='du -ahd1| sort -rh | head -11 '
alias vim='nvim'

export EDITOR=nvim
#export TERM=screen-256color


# Чтобы работал rsync при motd 
[ -z "$PS1" ] && return

# Можно нажимать CTRL-S при в nvim
stty -ixon

#-------------------------------------------------------------------------------
# Настройка истории команд
#-------------------------------------------------------------------------------

# Пишет время и дату ввода команды
export HISTTIMEFORMAT="%h %d %H:%M:%S "

# Увеличиваем Размер Хранимой Истории
export HISTSIZE=10000
export HISTFILESIZE=10000

# Мгновенно Сохранять Историю Команд.По умолчанию, если сессия внезапно обрывается, то теряется история команд
PROMPT_COMMAND='history -a'
PROMPT_COMMAND="$PROMPT_COMMAND; history -a"

# Игнорировать Определенные Команды
export HISTIGNORE="ls:ps:history"


#-------------------------------------------------------------------------------
# Настройка подсветки для команды less
#-------------------------------------------------------------------------------

export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Чтобы работал fzf и работало игнорирование .gitignore при поиске fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='ag -g ""'
