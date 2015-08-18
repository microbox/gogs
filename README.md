gogs
====

Gogs is a painless self-hosted Git Service written in Go.

Microbox repackage Gogs from the latest source and make it into a solid and easy-to-use docker image.

#### Launch gogs and persistent data to local

```
docker run -d -p 22:22 -p 3000:3000 -v /data/gogs:/data microbox/gogs:latest --name gogs
```

#### Upgrade to a newer version

```
docker stop gogs
docker rm gogs
docker run -d -p 22:22 -p 3000:3000 -v /data/gogs:/data microbox/gogs:latest --name gogs
```

### Name

- microbox/gogs

### Version

- 0.6.4
- 0.6.1
- 0.5.6

### Components

- gogs 0.6.1
- openssh 6.0p1
- git 1.7.10.4

### Image Size

-  ~ 39.54 MB
