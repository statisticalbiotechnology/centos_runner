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
RUN dnf -y install gtest
RUN dnf -y config-manager --set-enabled powertools
RUN dnf -y update
RUN dnf -y --enablerepo=powertools install tokyocabinet-devel
RUN dnf -y install xerces-c-devel xsd
RUN dnf -y install boost-static boost-devel

RUN dnf clean all

# Build directory
RUN mkdir -p /base
WORKDIR /base
