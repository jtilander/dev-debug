FROM jtilander/alpine
MAINTAINER Jim Tilander

RUN apk add --no-cache \
		g++ \
		gcc \
		nodejs \
		nodejs-dev \
		py-pip \
		py-raven \
		py-requests \
		python \
		ruby \
		ruby-bundler \
		ruby-dev \
		ruby-json \
		ruby-rake \
		libuv \
		libuv-dev \
		zsh

ENV VISUAL=vi
ENV P4CONFIG=.p4config

ENV MYHOME=/home/jenkins

COPY new-*.sh /usr/local/bin/

RUN mkdir -p $MYHOME && chmod g+rwx $MYHOME

RUN npm install -g \
		bower \
		generator-angular \
		generator-karma \
		grunt-cli \
		yo

ENV UID=1000
RUN adduser -D -u $UID jenkins

RUN mkdir -p /etc/skel
COPY bash-prompt.sh /etc/profile.d

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["make"]

USER jenkins
WORKDIR $MYHOME
VOLUME ["$MYHOME"]

# Default port for grunt serve
EXPOSE 9000
