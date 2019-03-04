#!/bin/bash

PASSWORD=$1
BASEDIR=$(dirname $(realpath $0))

echo $basedir
if [[ "${PASSWORD}" == "" ]]
    then
        echo "[USAGE] ./colab-ssh.sh [password]"
else
    ################################## SSH SETTINGS ##############################################
    cp $BASEDIR/sshd_config /etc/ssh/
    mkdir -p /var/run/sshd
    /usr/sbin/sshd -D &
    echo "sshd daemon is running..."

    ################################## SYSTEM SETTINGS ##############################################
    cp $BASEDIR/.bashrc /root/
    echo ".basrhc updated!"
    apt-get -y -qq install htop pciutils net-tools vim
    echo "vim, htop, pciutils, net-tools installed..."
    echo root:${PASSWORD} | chpasswd

    ################################## TUNNEL SETTINGS ##############################################
    # Tunnel is activating
    echo "Tunnel is activating..."
    rm -rf ~/.tunnel.log
    nohup $BASEDIR/tunnel-cli --tcp 22 >~/.tunnel.log 2>/dev/null &
    sleep 1
    cat ~/.tunnel.log
fi
