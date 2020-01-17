#!/bin/bash

check_yes_no () {
        echo "$1"
        local ans PS3="> "
        select ans in Yes No; do
                [[ $ans == Yes ]] && eval "$1" && echo -e "[\e[92mOK\e[0m]" && return 0
                [[ $ans == No ]] && return 1
        done
}

if [ `whoami` = root ]; then
        check_yes_no 'yum -y update'
        check_yes_no 'yum -q -y install net-tools'

        #-------------------------------------------------------------------------------
        # IPTABLES
        #-------------------------------------------------------------------------------
        check_yes_no 'yum -q -y remove firewalld'
        check_yes_no 'yum -q -y install iptables-services'
        check_yes_no 'systemctl start iptables'
        check_yes_no 'systemctl enable iptables'


        #-------------------------------------------------------------------------------
        # REPOs
        #-------------------------------------------------------------------------------
        check_yes_no 'yum install -q -y yum-utils'
        check_yes_no 'yum -q -y install  https://centos7.iuscommunity.org/ius-release.rpm'
        check_yes_no 'yum install -q -y epel-release'
        check_yes_no 'yum -q -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm'

        #-------------------------------------------------------------------------------
        # TIME
        #-------------------------------------------------------------------------------
        check_yes_no 'ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime'
        check_yes_no 'yum -q -y install ntp'
        check_yes_no 'systemctl enable ntpd'
        check_yes_no 'systemctl start ntpd'

        #-------------------------------------------------------------------------------
        # NGINX
        #-------------------------------------------------------------------------------
        if check_yes_no 'yum -q -y install nginx'; then
                check_yes_no 'systemctl enable nginx'
                check_yes_no 'systemctl start nginx'
                check_yes_no 'iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT'
                check_yes_no 'iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT'
                check_yes_no 'service iptables save'

        fi

        #-------------------------------------------------------------------------------
        # MARIADB
        #-------------------------------------------------------------------------------
        if check_yes_no 'yum -q -y install mariadb mariadb-server'; then
                check_yes_no 'systemctl enable mariadb'
                check_yes_no 'systemctl start mariadb'
                check_yes_no 'yum -q -y install phpmyadmin'
        fi

        #-------------------------------------------------------------------------------
        # FAIL2BAN
        #-------------------------------------------------------------------------------
        if check_yes_no 'yum -q -y install fail2ban'; then
                check_yes_no 'systemctl enable fail2ban'
                check_yes_no 'systemctl start fail2ban'
        fi

        #-------------------------------------------------------------------------------
        # DEVELOPMENT
        #-------------------------------------------------------------------------------
        check_yes_no 'yum -q -y groupinstall "Development Tools"'
        check_yes_no 'yum -q -y install python36u python36u-devel python36u-pip python-pip'
        check_yes_no 'yum -q -y install perl perltidy perl-Perl-Critic perl-Data-Dumper perl-App-cpanminus perl-DBD-MySQL'
        
        #-------------------------------------------------------------------------------
        # Nodejs. Со временем и 12 версия ноды может устареть
        #-------------------------------------------------------------------------------       
        check_yes_no 'curl -sL https://rpm.nodesource.com/setup_12.x | sudo -E bash -'
        check_yes_no 'yum -q -y install npm'
        # Нужен, чтобы заработала автодополнялка js
        check_yes_no 'npm install -g tern'
        check_yes_no 'npm install -g eslint'


        #-------------------------------------------------------------------------------
        # VIM
        #-------------------------------------------------------------------------------
        check_yes_no 'yum install -q -y neovim python3-neovim'
        check_yes_no 'npm install -g neovim'
        #-------------------------------------------------------------------------------
        # OTHERS
        #-------------------------------------------------------------------------------
        check_yes_no 'yum -q -y install wget'
        check_yes_no 'yum -q -y install nano'
        check_yes_no 'yum -q -y install rsync'
        check_yes_no 'yum -q -y install screen'
        check_yes_no 'yum -q -y install mc'
        check_yes_no 'yum -q -y install tmux2'
        check_yes_no 'yum -q -y install mlocate && updatedb'
        check_yes_no 'yum -q -y install httpd-tools'
        check_yes_no 'yum -q -y install lrzsz'
        check_yes_no 'yum -q -y install mailx'
        check_yes_no 'pip3 install virtualenv'
        # Красивый форматер для конфигов nginx
        git clone https://github.com/1connect/nginx-config-formatter.git
        ln -s ~/nginx-config-formatter/nginxfmt.py /bin/nginxfmt.py
        chmod +x /bin/nginxfmt.py
        
        check_yes_no 'pip3 install autopep8'
        check_yes_no 'pip3 install neovim'
        check_yes_no 'pip install --upgrade setuptools pip && pip2 install neovim'

fi


check_yes_no 'curl -s https://raw.githubusercontent.com/citaty-svyatyh/mypost/master/.bashrc -o ~/.bashrc'
check_yes_no 'curl -s https://raw.githubusercontent.com/citaty-svyatyh/mypost/master/.ctags -o ~/.ctags'
# Возможно jshint больше не нужен, на его смену пришел .eslintrc 
# check_yes_no 'curl -s  https://raw.githubusercontent.com/citaty-svyatyh/mypost/master/.jshintrc -o ~/.jshintrc'
# check_yes_no 'curl -s https://raw.githubusercontent.com/citaty-svyatyh/mypost/master/.screenrc -o ~/.screenrc'
check_yes_no 'curl -s https://raw.githubusercontent.com/citaty-svyatyh/mypost/master/.tern-project -o ~/.tern-project'
check_yes_no 'curl -s  https://raw.githubusercontent.com/citaty-svyatyh/mypost/master/.tmux.conf -o ~/.tmux.conf'
check_yes_no 'curl -s  https://raw.githubusercontent.com/citaty-svyatyh/mypost/master/.pylintrc -o ~/.pylintrc'
check_yes_no 'curl -fLo ~/.config/nvim/init.vim --create-dirs https://raw.githubusercontent.com/citaty-svyatyh/mypost/master/init.vim'


#-------------------------------------------------------------------------------
# Чтобы каждое консольное приглашение было по разному раскрашено
#-------------------------------------------------------------------------------

R=(`shuf -i31-37 -n5`)
# echo ${R[0]} ${myarr[1]} ${myarr[2]}
BASHRC=$(cat <<-END
export PS1='\[\033[01;${R[0]}m\]\u\[\033[01;${R[1]}m\]@\[\033[01;${R[2]}m\]\h \[\033[01;${R[3]}m\]\w \[\033[01;${R[4]}m\]$ \[\033[00m\]'
END
)


if check_yes_no 'echo "Add color to .bashrc?"'; then
        echo "$BASHRC" >> ~/.bashrc
        #exec bash # Не работает source  ~/.bashrc
fi


check_yes_no 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

if check_yes_no 'virtualenv env'; then
        check_yes_no 'echo ". env/bin/activate" >> .bashrc '
        check_yes_no '. env/bin/activate'
        check_yes_no 'pip install autopep8'
        check_yes_no 'pip install neovim'
        # Нужен для автодополнялки
        check_yes_no 'pip install pynvim'
fi
# vim если найдет переменню окружения MYCOLOR, то включит режим true color
check_yes_no 'echo "export MYCOLOR=24bit" >> .bash_profile'

# Настройка глобального eslintera
echo "Настройка глобального eslintera. Для react это не требуется! В react достаточно одной строки в package.json, которая есть по умолчанию"
read -p "Нужно настроить глобальный eslinter (y/n)?" CONT
if [ "$CONT" = "y" ]; then
    #check_yes_no 'npm init'
    #check_yes_no 'npm install eslint --save-dev'
    echo "choise 'To check syntax, find problems, and enforce code style'"
    check_yes_no 'eslint --init'
fi
