#!/bin/bash

# -- Colors
GREEN="\033[32m"
RESET="\033[0m"

RUNNING="$GREEN[+]$RESET"

FILES=""
HASHES=""
TARGETS="$1"

find_files() {
        FILES+="$(find "$1" -type f 2>/dev/null)"
}

cauculate_hash() {
        HASHES+="$(sha256sum "$1" 2>/dev/null | cut -f1 -d' ') "
}

echo -e "$RUNNING Getting all files..."
for target in $TARGETS; do
        find_files $target
        echo -e "$RUNNING target: $target"
done
echo -e "$RUNNING File list strlen: ${#FILES}"

echo -e "$RUNNING Cauculate hashes..."
for file in $FILES; do
        cauculate_hash $file
        echo -ne "\033[K$RUNNING file: $file$RESET\r"
done
echo -e "$RUNNING Hashes list strlen: ${#HASHES}"

echo -e "\n\nYour Final Hash: $GREEN$(echo $HASHES | sha256sum | cut -f1 -d' ')$RESET"
