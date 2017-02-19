#!/bin/bash
set -e

case "$1" in 
	make)
		shift
		exec /usr/bin/make $*
		;;
	bash)
		shift
		exec /bin/bash $*
		;;
	pingtest)
		exec /bin/ping -c 10 8.8.8.8
		;;
esac

exec "$@"
