#!/bin/bash

PASSWORD=$1

if [[ "${PASSWORD}" == "" ]]
    then
        echo "[USAGE] ./colab-ssh.sh [password]"
else
    ################################## SSH SETTINGS ##############################################
    echo "Getting sshd config and apply settings..."
    if [[ ! -e "sshd_config" ]]
        then
            wget "https://raw.githubusercontent.com/mpolatcan/colab-ssh/master/sshd_config" -q
    fi
    cp sshd_config /etc/ssh/
    mkdir -p /var/run/sshd
    /usr/sbin/sshd -D &
    echo "sshd daemon is running..."

    ################################## SYSTEM SETTINGS ##############################################
    echo "Getting .bashrc config and apply settings..."
    if [[ ! -e ".bashrc" ]]
        then
            wget "https://raw.githubusercontent.com/mpolatcan/colab-ssh/master/.bashrc" -q
    fi
    cp .bashrc /root/
    echo ".basrhc updated!"
    apt-get -y -qq install htop pciutils net-tools vim
    echo "vim, htop, pciutils, net-tools installed..."
    echo "Setting password..."
    echo root:${PASSWORD} | chpasswd

    ################################## TUNNEL SETTINGS ##############################################
    echo "Getting Labstack tunnel..."
    if [[ ! -e "tunnel-cli" ]]
        then
            wget "https://github.com/mpolatcan/colab-ssh/raw/master/tunnel-cli" -q
            chmod +x tunnel-cli
    fi
    # Tunnel is activating
    echo "Tunnel is activating..."
    ./tunnel-cli --tcp 22 &
fi

