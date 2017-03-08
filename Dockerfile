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
		@angular/cli \
		bower \
		grunt-cli \
		gulp-tslint \
		gulp-typescript \
		karma \
		ts-node \
		tslint \
		typescript

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
