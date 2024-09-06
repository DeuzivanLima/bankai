#!/bin/sh

# -- Colors
GREEN="\033[32m"
RED="\033[32m"
RESET="\033[0m"
RUNNING="$GREEN[+]$RESET"
ERROR="$RED[-]$RESET"

# -- Public vars
FILES=""
#TARGETS=$HOME/Documents/bankai
TARGETS="/usr /boot /root /home /var/mail /var/spool /var/lib /var/local /var/opt /var/backups /etc /mnt /opt /srv"

find_files () {
	FILES+="$(find "$1" -type f 2>/dev/null)" 
}

sort_files () {
	FILES=$(echo $FILES | tr ' ' '\n' | sort)
}

cauculate_hash () {
	HASHES+="$(sha256sum "$1" 2>/dev/null | cut -f1 -d' ') "
}

log () {
	echo -ne "$RUNNING $1\n"
}

error () {
	echo -ne "$ERROR $1\n"
	sleep 1
	exit
}

log "Finding files..."
find_files $TARGETS

log "Sorting files on variable..."
sort_files

echo -e $FILES | tr ' ' '\n' > dump.txt
log "Done."
