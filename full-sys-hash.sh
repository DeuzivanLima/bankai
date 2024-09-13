#!/bin/bash

# -- Colors
GREEN="\033[32m"
RESET="\033[0m"

RUNNING="$GREEN[+]$RESET"

FILES=""
HASHES=""
TARGETS="/usr /boot /root /home /var/mail /var/spool /var/lib /var/local /var/opt /var/backups /etc /mnt /opt /srv"

find_files() {
        FILES+="$(find "$1" -type f 2>/dev/null | grep -v "cache" | sort)"
}

cauculate_hash() {
        HASHES+="$(md5sum "$1" 2>/dev/null | cut -f1 -d' ') "
}

echo -e "$RUNNING Getting all files..."
for target in $TARGETS; do
        find_files $target
        echo -e "$RUNNING target: $target"
done

echo -e "$RUNNING Cauculate hashes..."
for file in $FILES; do
        cauculate_hash $file
        #echo -ne "$RUNNING file: $file"
done

echo -e "\n\nYour Final Hash: $GREEN$(echo $HASHES | tr ' ' '\n' | sort | sha256sum | cut -f1 -d' ')$RESET"
