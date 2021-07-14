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
        check_yes_no 'yum install -q -y epel-release'
        check_yes_no 'yum -q -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm'

        #-------------------------------------------------------------------------------
        # TIME
        #-------------------------------------------------------------------------------
        check_yes_no 'ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime'
        check_yes_no 'yum -q -y install chrony'
        check_yes_no 'systemctl enable chronyd'
        check_yes_no 'systemctl start chronyd'
        
        #-------------------------------------------------------------------------------
        # Python 3.9
        #-------------------------------------------------------------------------------       
        check_yes_no 'yum -q -y python39 python39-devel python39-pip'
        
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
        # MONGODB
        #-------------------------------------------------------------------------------
        if check_yes_no 'curl -s https://raw.githubusercontent.com/citaty-svyatyh/mypost/master/mongodb-org-4.4.repo -o /etc/yum.repos.d/mongodb-org-4.4.repo'; then
                check_yes_no 'yum install -q -y mongodb-org'
                check_yes_no 'systemctl start mongod && systemctl enable mongod'
                echo 'echo "never" > /sys/kernel/mm/transparent_hugepage/enabled' >> /etc/rc.local 
                echo 'echo "never" > /sys/kernel/mm/transparent_hugepage/defrag' >> /etc/rc.local 
                check_yes_no 'chmod +x /etc/rc.d/rc.local'
                echo "Для отключения сообщения о мониторинге: db.disableFreeMonitoring()"
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
        
        #-------------------------------------------------------------------------------
        # Nodejs. Со временем и 12 версия ноды может устареть
        #-------------------------------------------------------------------------------       
        check_yes_no 'yum remove nodejs'
        check_yes_no 'curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash -'
        check_yes_no 'yum -q -y install nodejs'
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
        check_yes_no 'yum -q -y install open-vm-tools'
        check_yes_no 'yum -q -y install wget'
        check_yes_no 'yum -q -y install nano'
        check_yes_no 'yum -q -y install rsync'
        check_yes_no 'yum -q -y install mc'
        check_yes_no 'yum -q -y install tmux'
        check_yes_no 'yum -q -y install mlocate && updatedb'
        check_yes_no 'yum -q -y install httpd-tools'
        check_yes_no 'yum -q -y install lrzsz'
        check_yes_no 'yum -q -y install mailx'
        check_yes_no 'pip3.9 install virtualenv'
        # Нужен для fzf vim и .gitignore ставит ag
        check_yes_no 'yum  -q -y  install the_silver_searcher'
        # Красивый форматер для конфигов nginx
        git clone https://github.com/1connect/nginx-config-formatter.git
        ln -s ~/nginx-config-formatter/nginxfmt.py /bin/nginxfmt.py
        chmod +x /bin/nginxfmt.py
        
        check_yes_no 'pip3.9 install autopep8'
        check_yes_no 'pip3.9 install neovim'

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
    # инит
    check_yes_no 'npm init'
    check_yes_no 'npm install eslint --save-dev'
    echo "choise 'To check syntax, find problems, and enforce code style'"
    check_yes_no 'eslint --init'
    check_yes_no 'curl -s  https://raw.githubusercontent.com/citaty-svyatyh/mypost/master/.eslintrc.js  -o ~/.eslintrc.js'
fi
