#!/bin/sh
URL_TCZ=$1

download_tcz() {
    # Ignore empty/whitespace only
    [ -z "$(echo $1)" ] && return
    [ -f "$1" ] && return
    curl -SLO $URL_TCZ/$1 >/dev/null
    # Attempt to download .dep, but it might not exist
    curl --fail -LO $URL_TCZ/$1.dep >/dev/null 2>&1
    # Make sure the .dep has an empty last line
    [ -f "$1.dep" ] && echo >> "$1.dep"
}

# Download squashfs-tools.tcz
download_tcz squashfs-tools.tcz

# Download any found dependencies, repeat 4 times for "recursion"
if [ -f squashfs-tools.tcz.dep ]; then
    COUNTDOWN=5
    while [ "$COUNTDOWN" -gt 0 ]; do
        COUNTDOWN=$(($COUNTDOWN - 1))
        for t in $(cat *.dep|sort|uniq); do
            download_tcz $t
        done
    done
fi

