#!/bin/bash
#
# gogs		Start up the OpenSSH server and Gogs server
#

KEYGEN="/usr/bin/ssh-keygen"
SSHD="/usr/sbin/sshd"
OPTIONS="-D" # -E /var/log/sshd/output.log
CONF="/etc/ssh/sshd_config"

if ! test -d /data/app; then
	mkdir -p /var/run/sshd
	mkdir -p /data/app/custom /data/app/data /data/app/conf /data/app/log /data/git /data/ssh/config /data/ssh/log
fi

if ! test -d /var/log/sshd; then
    # prepare sshd environment
    mkdir -p /var/run /var/empty/sshd /var/log/sshd
    chmod 755 /var/empty
fi

test -d /data/app/templates || cp -ar ./templates /data/app/

if id -u git >/dev/null 2>&1; then
    echo "found git user, skip init process"
else
    echo "git user does not exist, booting the container"
    adduser -h /data/git -s /bin/sh -D -u 1000 git git
    passwd -u git

    ln -sf /data/app/custom ./custom
    ln -sf /data/app/data ./data
    ln -sf /data/app/log ./log
    ln -sf /data/app/templates ./templates
    ln -sf /data/ssh/config /etc/ssh
    ln -sf /data/ssh/log /var/log/sshd

    mkdir /data/git/.ssh
    touch /data/git/.ssh/authorized_keys
    chmod 0700 /data/git/.ssh
    chmod -R 0600 /data/git/.ssh/*
    chown -R git:git /data/git/.ssh
    chown -R git:git /data /tmp .
fi

if [ ! -s $CONF ]; then
    echo "/etc/ssh/sshd_config not found, Use default sshd_config"
    cp /etc/default/sshd_config $CONF
fi

if [ ! -s /etc/ssh/moduli ]; then
    echo "/etc/ssh/moduli not found, Use default moduli"
    cp -f /etc/default/moduli /etc/ssh/moduli
fi

# generate server key if not exists
$KEYGEN -A

echo "starting sshd..."
$SSHD $OPTIONS &
sshd_pid="$!"
echo "sshd is running"
sleep 1
echo "starting gogs..."
su git -c "./gogs web" &
echo "gogs is running"
gogs_pid="$!"
trap "echo \"gogs and sshd is stopped\"; kill $sshd_pid $gogs_pid; exit 0" exit INT TERM
wait
exit 1
