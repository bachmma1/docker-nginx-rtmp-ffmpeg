# [bachmma1/docker-ffserver](https://github.com/bachmma1/docker-ffserver)
Based on ghcr.io/linuxserver/baseimage-alpine from [LinuxServer.io](https://linuxserver.io)

[![GitHub](https://img.shields.io/github/stars/bachmma1/docker-ffserver.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/bachmma1/docker-ffserver)
[![Docker Pulls](https://img.shields.io/docker/pulls/bachmma1/docker-ffserver.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/bachmma1/docker-ffserver)

The [ffserver](https://trac.ffmpeg.org/wiki/ffserver)
The [ffmpeg](https://ffmpeg.org)

## Usage

Here are some example snippets to help you get started creating a container.

### docker-compose

Compatible with docker-compose v2 schemas.

```yaml
---
version: "2.1"
services:
  ffserver:
    image: bachmma1/ffserver
    container_name: ffserver
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - FFMPEG_COMMAND=-i http://192.168.0.100/video/mpegts.cgi -framerate 25 -c:v mjpeg -q:v 3 -nostats -loglevel panic -an http://localhost:8080/camera.ffm
    volumes:
      - /path/to/appdata/config:/config
      - /path/to/data:/data
    ports:
      - 8080:8080
    restart: unless-stopped
```

### docker cli

```
docker run -d \
  --name=ffserver \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e FFMPEG_COMMAND=-i http://192.168.0.100/video/mpegts.cgi -framerate 25 -c:v mjpeg -q:v 3 -nostats -loglevel panic -an http://localhost:8080/camera.ffm \
  -p 8080:8080 \
  -v /path/to/appdata/config:/config \
  -v /path/to/data:/data \
  --restart unless-stopped \
  bachmma1/ffserver
```


## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 8080` | http webcam stream |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London |
| `-e FFMPEG_COMMAND=-i http://192.168.0.100/video/mpegts.cgi -framerate 25 -c:v mjpeg -q:v 3 -nostats -loglevel panic -an http://localhost:8080/camera.ffm` | Adjust the ffmpeg command to your needs.|
| `-v /config` | Contains all relevant configuration files. |
| `-v /data` | Location of ffserver data on disk. |

## Environment variables from files (Docker secrets)

You can set any environment variable from a file by using a special prepend `FILE__`.

As an example:

```
-e FILE__PASSWORD=/run/secrets/mysecretpassword
```

Will set the environment variable `PASSWORD` based on the contents of the `/run/secrets/mysecretpassword` file.

## Umask for running applications

For all of our images we provide the ability to override the default umask settings for services started within the containers using the optional `-e UMASK=022` setting.
Keep in mind umask is not chmod it subtracts from permissions based on it's value it does not add. Please read up [here](https://en.wikipedia.org/wiki/Umask) before asking for support.

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


## Player Setup

### Video
```bash
$ ffplay http://[YOUR_FFSERVER_DOCKER_IP]:8090/camera.mjpeg
$ vlc http://[YOUR_FFSERVER_DOCKER_IP]:8090/camera.mjpeg
$ firefox http://[YOUR_FFSERVER_DOCKER_IP]:8090/camera.mjpeg
```

### Snapshot
```bash
$ firefox http://[YOUR_FFSERVER_DOCKER_IP]:8090/static-camera.jpg
```

## Versions

* **15.04.21:** - Initial Release.
