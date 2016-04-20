# Build using: docker build -f Dockerfile.gocd-server -t gocd-server .
FROM phusion/baseimage:0.9.18
MAINTAINER Aravind SV <arvind.sv@gmail.com>

RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
RUN apt-get update \
	&& apt-get install -y -q \
		git \
		mercurial \
		openjdk-7-jre-headless \
		subversion \
		unzip \
	&& apt-get clean

RUN mkdir /etc/service/go-server

ADD https://download.go.cd/binaries/16.3.0-3183/deb/go-server-16.3.0-3183.deb /tmp/go-server.deb

RUN groupadd -r go -g 998 \
	&& useradd -r -u 998 -c "Go User" -g go -d /var/go -m -s /bin/bash go \
	&& mkdir -p /var/lib/go-server/addons /var/log/go-server /etc/go /go-addons \
	&& chown -R go:go /var/lib/go-server /var/log/go-server /etc/go /go-addons /var/go

#VOLUME ["/var/lib/go-server", "/var/log/go-server", "/etc/go", "/go-addons", "/var/go"]

WORKDIR /tmp
RUN dpkg -i --debug=10 /tmp/go-server.deb \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN sed -i -e 's/DAEMON=Y/DAEMON=N/' /etc/default/go-server
EXPOSE 8153 8154

ADD go-server-start.sh /etc/service/go-server/run
ADD log4j.properties /etc/service/go-server/

CMD ["/etc/service/go-server/run"]
