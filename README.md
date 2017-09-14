# ANF Large Image

Based on [ANF Base Image](https://github.com/aquaron/anf).
This image attempts to include all CPAN modules needed to run most features for a general purpose site.

# Quick Start

### Get Image

```
$ docker pull aquaron/anf-large[:ovn|debian]
```

### Initialize Enviornment

All options are required:

```
$ docker run -it --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v <data-dir>:/usr/share/nginx \
    -v <nginx-conf-dir>:/etc/nginx \
    -v <nginx-log-dir>:/var/log/nginx \
    -p <port>:80 \
    -h <container-host-name> \
    --name <container-label> \
    aquaron/anf-large \
    init
```

Sample:

```
$ docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock \
    -v /usr/www-data:/usr/share/nginx \
    -v /etc/nginx:/etc/nginx \
    -v /var/log/nginx:/var/log/nginx \
    -p 9992:80 -h debiannginx --name dnf-large aquaron/anf-large:debian init
```

### Install Startup Script

```
$ cd /etc/nginx
$ sudo ./install-systemd.sh
```

### Start Server

Start using `systemctl`:

```
$ systemctl start docker-dnf-large.service
```

Start using `docker`:

```
$ docker run -d -v /var/run/docker.sock:/var/run/docker.sock \
    -v /usr/www-data:/usr/share/nginx \
    -v /etc/nginx:/etc/nginx \
    -v /var/log/nginx:/var/log/nginx \
    -p 9992:80 -h debiannginx --name dnf-large aquaron/anf-large:debian
```

### Stop Server

```
$ systemctl stop docker-dnf-large
```

Or, with `docker`:
```
$ docker stop -t 2 dnf-large
$ docker rm dnf-large
```
