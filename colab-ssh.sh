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
            wget "https://raw.githubusercontent.com/mpolatcan/colab-ssh/master/sshd_config"
    fi
    cp sshd_config /etc/ssh/
    mkdir -p /var/run/sshd
    /usr/sbin/sshd -D &
    echo "sshd daemon is running..."

    ################################## SYSTEM SETTINGS ##############################################
    echo "Getting .bashrc config and apply settings..."
    if [[ ! -e ".bashrc" ]]
        then
            wget "https://raw.githubusercontent.com/mpolatcan/colab-ssh/master/.bashrc" > /dev/null
    fi
    cp .bashrc /root/
    echo ".basrhc updated!"
    apt-get install nano htop pciutils net-tools vim tmux
    echo "nano, htop, pciutils, net-tools installed..."
    echo "Setting password..."
    echo root:${PASSWORD} | chpasswd

    ################################## TUNNEL SETTINGS ##############################################
    echo "Getting Labstack tunnel..."
    if [[ ! -e "tunnel-cli" ]]
        then
            wget "https://github.com/mpolatcan/colab-ssh/raw/master/tunnel-cli"
            chmod +x tunnel-cli
    fi
    # Tunnel is activating
    echo "Tunnel is activating..."
    ./tunnel-cli --tcp 22 &
fi

