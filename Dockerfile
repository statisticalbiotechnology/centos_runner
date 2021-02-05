FROM centos:centos8

RUN dnf -y update

RUN dnf -y install wget git

# RUN yum -y install yum-utils
RUN dnf -y install gcc gcc-c++ make
RUN dnf -y install wget rpm-build cmake libxml2-devel libuuid-devel
RUN dnf -y install sqlite-devel zlib-devel bzip2-devel
RUN dnf -y install libtirpc libtirpc-devel
RUN dnf -y install dnf-plugins-core
RUN dnf -y install epel-release
RUN dnf -y config-manager --set-enabled powertools
RUN dnf -y update
RUN dnf -y --enablerepo=powertools install tokyocabinet-devel
RUN dnf -y install xerces-c-devel xsd
RUN dnf -y install boost-static boost-devel
RUN mkdir -p /tmp/glibc && \
    pushd /tmp/glibc && \
    wget --quiet 'https://ftp.gnu.org/gnu/glibc/glibc-2.28.tar.gz' && \
    tar --wildcards -xvzf glibc-2.28.tar.gz 'glibc-2.28/sunrpc/rpc/*' && \
    cp -n ./glibc-2.28/sunrpc/rpc/* /usr/include/rpc/ && \
    popd && \
    rm -fr /tmp/glibc

RUN dnf clean all

# Build directory
RUN mkdir -p /base
WORKDIR /base
