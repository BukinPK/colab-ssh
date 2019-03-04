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
    echo "Sshd daemon start..."

    ################################## SYSTEM SETTINGS ##############################################
    cp $BASEDIR/.bashrc /root/
    echo "Update .basrhc!"
    apt-get -y -qq install htop vim
    echo "Install... vim, htop "
    echo root:${PASSWORD} | chpasswd

    ################################## TUNNEL SETTINGS ##############################################
    # Tunnel is activating
    echo "Tunnel activating..."
    pid=$(pidof $BASEDIR/tunnel-cli)
    if [ -n "$pid" ]; then
	    kill $pid
    fi
    rm -rf ~/.tunnel.log
    nohup $BASEDIR/tunnel-cli --tcp 22 >~/.tunnel.log 2>/dev/null &
    sleep 1
    cat ~/.tunnel.log
fi
