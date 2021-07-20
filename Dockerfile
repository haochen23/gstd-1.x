FROM ubuntu:20.04

ARG HTTP_PROXY
ARG HTTPS_PROXY

RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

ARG APT_ARGS="-y"

# Update package(s)
RUN apt-get ${APT_ARGS} update  &&\
    apt-get ${APT_ARGS} upgrade &&\
    apt-get clean

RUN apt-get install -y \ 
    automake \
    libtool \
    pkg-config \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    libglib2.0-dev \
    libjson-glib-dev \
    gtk-doc-tools \
    libreadline-dev \
    libncursesw5-dev \
    libdaemon-dev \
    libjansson-dev \
    libsoup2.4-dev

RUN ./autogen.sh &&./configure && make && make install

EXPOSE 5000 8080 22
CMD ['/bin/bash', 'gstd']