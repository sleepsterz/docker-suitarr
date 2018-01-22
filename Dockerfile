FROM ubuntu:17.10
MAINTAINER sleepsterz

ARG DEBIAN_FRONTEND=noninteractive
ENV XDG_CONFIG_HOME="/config" XDG_DATA_HOME="/config"
ENV LANG='C.UTF-8' LANGUAGE='C.UTF-8' LC_ALL='C.UTF-8'

# install packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends --no-install-suggests \
        dirmngr && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && echo "deb http://download.mono-project.com/repo/ubuntu xenial main" | tee /etc/apt/sources.list.d/mono-official.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
        jq \
        unzip \
        curl \
        libcurl4-openssl-dev \
        ca-certificates-mono \
        mono-devel \
        sqlite3 \
        python \
		python-dev \
		python-pip \
		build-essential \
		git \
		ffmpeg \
        openjdk-8-jre-headless \
        mediainfo && \
		
RUN pip install requests \
    pip uninstall -y pyOpenSSL \
    pip install pyOpenSSL \
    pip install requests[security] \
    pip install requests-cache \
    pip install babelfish \
    pip install "guessit<2" \
    pip install "subliminal<2" \
    pip uninstall -y stevedore \
    pip install stevedore==1.19.1 \
    pip install python-dateutil \
    pip install qtfaststart \

# install s6-overlay
    curl -s -o - -L "https://github.com/just-containers/s6-overlay/releases/download/v1.20.0.0/s6-overlay-amd64.tar.gz" | tar xzf - -C / && \

# make folders
    mkdir -p /app /config && \

# create user
    useradd -u 1000 -U -d /config -s /bin/false hotio && \
    usermod -G users hotio && \

# clean up
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY root/ /

VOLUME ["/config"]

ENTRYPOINT ["/init"]
