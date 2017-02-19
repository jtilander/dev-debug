FROM jtilander/alpine
MAINTAINER Jim Tilander

RUN apk add --no-cache \
		g++ \
		gcc \
		nodejs \
		py-pip \
		py-raven \
		py-requests \
		python \
		zsh

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
