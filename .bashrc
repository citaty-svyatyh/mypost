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
export TERM=screen-256color


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
