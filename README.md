gogs
====

Gogs is a painless self-hosted Git Service written in Go.

Microbox repackage Gogs from the latest source and make it into a solid and easy-to-use docker image.

Launch your Gogs server and store gogs data at local. You can easily upgrade to a newer version later.

```bash
docker run -d -p 22:22 -p 3000:3000 -v /data/gogs:/data microbox/gogs:latest
```

### Name

- microbox/gogs

### Version

- 0.5.6

### Components

- gogs 0.5.6
- sshd 6.0-p1

### Image Size

-  ~ 39.54 MB

