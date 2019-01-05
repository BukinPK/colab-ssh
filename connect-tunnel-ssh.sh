!chmod +x tunnel-cli
!mkdir -p /var/run/sshd
!echo root:0019030 | chpasswd
!apt-get install htop nano pciutils net-tools vim
get_ipython().system_raw('/usr/sbin/sshd -D &')
!./tunnel-cli --tcp 22