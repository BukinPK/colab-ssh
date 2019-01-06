#!/bin/bash

PASSWORD=$1

if [[ "${PASSWORD}" == "" ]]
    then
        echo "[USAGE] ./colab-ssh.sh [password]"
else
    echo "Getting sshd config and apply settings..."
    wget "https://raw.githubusercontent.com/mpolatcan/colab-ssh/master/sshd_config" > /dev/null
    mv sshd_config /etc/ssh/
    mkdir -p /var/run/sshd
    /usr/sbin/sshd -D &
    echo "sshd daemon is running..."
    # Get .bashrc config
    echo "Getting .bashrc config and apply settings..."
    wget "https://raw.githubusercontent.com/mpolatcan/colab-ssh/master/.bashrc" > /dev/null
    mv .bashrc /root/
    echo ".basrhc updated!"
    # Get Labstack Tunnel 
    echo "Getting Labstack tunnel..."
    wget "https://github.com/mpolatcan/colab-ssh/raw/master/tunnel-cli" >> /dev/null
    chmod +x tunnel-cli
    # Setting password
    echo "Setting password..."
    echo root:${PASSWORD} | chpasswd
    # Tunnel is activating
    echo "Tunnel is activating..."
    ./tunnel-cli --tcp 22 &
fi

