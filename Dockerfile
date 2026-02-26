FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf \
    imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 \
    libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync \
    schedtool squashfs-tools xsltproc zip zlib1g-dev python-is-python3 openjdk-8-jdk \
    sudo wget nano htop tmux tzdata rclone git-lfs pigz tar && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN git lfs install --skip-repo

RUN ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN curl -o /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo && \
    chmod a+x /usr/local/bin/repo

RUN useradd -m -s /bin/bash cirrus && \
    usermod -aG sudo cirrus && \
    echo "cirrus ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/cirrus && \
    chmod 0440 /etc/sudoers.d/cirrus

USER cirrus

WORKDIR /home/cirrus
