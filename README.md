[![Docker Build Statu](https://img.shields.io/docker/build/hotio/suitarr.svg?style=flat-square)](https://hub.docker.com/r/hotio/suitarr)
[![Docker Automated buil](https://img.shields.io/docker/automated/hotio/suitarr.svg?style=flat-square)](https://hub.docker.com/r/hotio/suitarr)
[![Docker Pulls](https://img.shields.io/docker/pulls/hotio/suitarr.svg?style=flat-square)](https://hub.docker.com/r/hotio/suitarr)
[![Docker Stars](https://img.shields.io/docker/stars/hotio/suitarr.svg?style=flat-square)](https://hub.docker.com/r/hotio/suitarr)
[![Maintenance](https://img.shields.io/maintenance/yes/2017.svg?style=flat-square)](https://github.com/hotio/docker-suitarr)

```
    _________      __  __
   /   _____/__ __|__|/  |______ ______________
   \_____  \|  |  \  \   __\__  \\_  __ \_  __ \
   /        \  |  /  ||  |  / __ \|  | \/|  | \/
  /_______  /____/|__||__| (____  /__|   |__|
          \/                    \/
```

## What is Suitarr?

Suitarr is one docker image that can run Radarr, Sonarr, Jackett and NZBHydra. By using the environment variable `-e APP=......`, the supported application will be downloaded and installed when starting the container.
This requires a lot less building of the images and all you need to do if you want to update the application is restart the container.

## Starting the container

#### Radarr

```
docker run --rm \
           --name radarr \
           -p 7878:8080 \
           -e APP=radarr \
           -e PUID=1000 \
           -e PGID=1000 \
           -e UMASK=022 \
           -e VERSION=stable \
           -e BACKUP=yes \
           -v /etc/localtime:/etc/localtime:ro \
           -v /<local_path>/config:/config \
           -v /<local_path>/downloads:/downloads \
           -v /<local_path>/movies:/movies \
           hotio/suitarr
```

#### Sonarr

```
docker run --rm \
           --name sonarr \
           -p 8989:8080 \
           -e APP=sonarr \
           -e PUID=1000 \
           -e PGID=1000 \
           -e UMASK=022 \
           -e VERSION=stable \
           -e BACKUP=yes \
           -v /etc/localtime:/etc/localtime:ro \
           -v /<local_path>/config:/config \
           -v /<local_path>/downloads:/downloads \
           -v /<local_path>/tvshows:/tvshows \
           hotio/suitarr
```

#### Jackett

```
docker run --rm \
           --name jackett \
           -p 9117:8080 \
           -e APP=jackett \
           -e PUID=1000 \
           -e PGID=1000 \
           -e UMASK=022 \
           -e VERSION=stable \
           -e BACKUP=yes \
           -v /etc/localtime:/etc/localtime:ro \
           -v /<local_path>/config:/config \
           hotio/suitarr
```

#### NZBHydra

```
docker run --rm \
           --name nzbhydra \
           -p 5075:8080 \
           -e APP=nzbhydra \
           -e PUID=1000 \
           -e PGID=1000 \
           -e UMASK=022 \
           -e VERSION=stable \
           -e BACKUP=yes \
           -v /etc/localtime:/etc/localtime:ro \
           -v /<local_path>/config:/config \
           hotio/suitarr
```

## Installing a different version

By default the latest stable version is installed. You can however change this behaviour with the following environment variable.
The value `unstable` will install the latest unstable version, using a version number as a value, installs the specified version.

```
# Radarr
-e VERSION=unstable
-e VERSION=0.2.0.307

# Sonarr
-e VERSION=unstable
-e VERSION=2.0.0.4578

# Jackett
-e VERSION=unstable
-e VERSION=0.7.1001

# NZBHydra
-e VERSION=unstable
-e VERSION=f60a628cc5d2a17677e6c9b6bb12ad41063ea4e0
```

## In case of problems

When the auto installation of the app fails for whatever reason, you can provide a file location to the installation files.
Or if you are modifying/self-compiling any app, you can use this feature to test your version. All files should be in a `tar.gz` file.

```
-e FILE=/config/Radarr.develop.0.2.0.817.linux.tar.gz
```

## Additional environment variables

You can use the following environment variable to pass on additional arguments to your app.

```
-e ARGS="--ProxyConnection localhost:8118"
```
