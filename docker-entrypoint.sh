#!/bin/sh
set -e

case "$1" in 
	make)
		shift
		exec /usr/bin/make $*
		;;
	grunt)
		shift
		exec /usr/bin/grunt $*
		;;
	bash)
		shift
		export TERM=xterm
		exec /bin/bash --init-file /etc/profile.d/bash-prompt.sh $*
		;;
	zsh)
		shift
		export TERM=xterm
		exec /bin/zsh $*
		;;
	pingtest)
		exec /bin/ping -c 10 8.8.8.8
		;;
esac

exec "$@"
