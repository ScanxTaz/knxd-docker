from debian:latest
MAINTAINER Scanxtaz scanxtaz@gmail.com

run apt-get -y update
run apt-get -y upgrade
run apt-get -y install git libtool build-essential libusb-1.0 autoconf file make cmake sudo libev-dev
run apt-get -y install libsystemd-dev pkg-config
RUN id build 2>/dev/null || useradd -m build
RUN echo "build ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
RUN git clone https://github.com/knxd/knxd.git
WORKDIR /knxd
RUN git checkout master
RUN sh bootstrap.sh
RUN ./configure --enable-eibnetip --enable-eibnetserver --enable-eibnetipserver --enable-usb --enable-busmonitor
RUN make
RUN make install
COPY ./conf /knxd
CMD knxd /knxd/knxd.conf

