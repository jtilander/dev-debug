FROM jtilander/alpine:0.0.2
MAINTAINER Jim Tilander

RUN apk add --no-cache \
		g++ \
		gcc \
		libuv \
		libuv-dev \
		nodejs \
		nodejs-dev \
		openssh \
		py-pip \
		py-raven \
		py-requests \
		python \
		rsync \
		ruby \
		ruby-bundler \
		ruby-dev \
		ruby-json \
		ruby-rake \
		zsh

ENV VISUAL=vi
ENV P4CONFIG=.p4config

ENV MYHOME=/home/jenkins
ENV HOME=/home/jenkins

COPY new-*.sh /usr/local/bin/

RUN mkdir -p $MYHOME && chmod g+rwx $MYHOME

RUN npm install -g \
		@angular/cli \
		karma \
		npm-check-updates \
		ts-node \
		tslint \
		typescript \
		yarn

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

# Default port for angular2 typescript
EXPOSE 4200

# Default port for angular2 javascript
EXPOSE 3000
