FROM alpine:3.5
MAINTAINER Jim Tilander

RUN apk add --no-cache \
		bash \
		curl \
		g++ \
		gcc \
		git \
		make \
		nodejs \
		py-pip \
		py-raven \
		py-requests \
		python \
		zsh

ENV P4_VERSION 16.1
RUN curl -sSL -O http://cdist2.perforce.com/perforce/r${P4_VERSION}/bin.linux26x86_64/p4 && mv p4 /usr/bin/p4 && chmod +x /usr/bin/p4

ENV VISUAL=vi
ENV P4CONFIG=.p4config

ENV MYHOME=/home/jenkins

RUN mkdir -p $MYHOME
WORKDIR $MYHOME
COPY test/Makefile $MYHOME/
VOLUME ["$MYHOME"]

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["make"]
