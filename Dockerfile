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
# Ugly fix
# RUN ln -s /usr/include/tirpc/rpc/* /usr/include/rpc/
# RUN ln -s /usr/include/tirpc/* /usr/include/ || true
# Ugly fix 2, download old sun rpc definitions from glibc
RUN mkdir -p /tmp/glibc && \
    pushd /tmp/glibc && \
    wget --quiet 'https://ftp.gnu.org/gnu/glibc/glibc-2.28.tar.gz' && \
    tar --wildcards -xvzf glibc-2.28.tar.gz 'glibc-2.28/include/rpc/*' && \
    cp -n ./glibc-2.28/include/rpc/* /usr/include/rpc/ && \
    popd && \
    rm -fr /tmp/glibc

# Install codesynthesis
# RUN mkdir -p /tmp/xsd && \
#     pushd /tmp/xsd && \
#     wget --quiet 'http://www.codesynthesis.com/download/xsd/4.0/linux-gnu/x86_64/xsd-4.0.0-1.x86_64.rpm' && \
#     rpm -ivh xsd-4.0.0-1.x86_64.rpm && \
#     popd && \
#     rm -rf /tmp/xsd

# Install boost for CentOS < 8, since these install boost <= 1.56 which
# has problems with the header only library includes
#RUN mkdir -p /tmp/boost && \
#        pushd /tmp/boost && \
#        wget --quiet -0 boost_1_67_0.tar.bz2 https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_67_0.tar.bz2' && \
#        tar xjf boost_1_67_0.tar.bz2 && \
#        cd boost_1_67_0/ && \
#        ./bootstrap.sh && \
#        ./b2 address-model=64 threading=multi -j4 --with-system \
#          --with-filesystem --with-serialization -d0 && \
#        popd && \
#        rm -rf /tmp/boost

RUN yum clean all

# Build directory
RUN mkdir -p /base
WORKDIR /base
