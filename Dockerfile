FROM scratch

MAINTAINER e2tox <e2tox@microbox.io>

ADD rootfs.tar      /
ADD gogs.sh         /app/gogs.sh
ADD sshd_config     /etc/default/sshd_config

# gogs require environment variable of USER
ENV USER git

# ssh-keygen require the home variable
ENV HOME /data/git

VOLUME ["/data"]

WORKDIR /app

EXPOSE 22 3000

ENTRYPOINT ["/usr/bin/env"]
CMD ["./gogs.sh"]