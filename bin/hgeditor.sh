#!/bin/bash

EDITOR="vim -f -o"

HGTMP=""
cleanup_exit() {
    rm -rf "$HGTMP"
}

# Remove temporary files even if we get interrupted
trap "cleanup_exit" 0 # normal exit
trap "exit 255" 1 2 3 6 15 # HUP INT QUIT ABRT TERM

HGTMP="${TMPDIR-/tmp}/hgeditor.$RANDOM.$RANDOM.$RANDOM.$$"
(umask 077 && mkdir "$HGTMP") || {
    echo "Could not create temporary directory! Exiting." 1>&2
    exit 1
}

(
    grep '^HG: changed' "$1" | cut -b 13- | while read changed; do
        "$HG" diff "$changed" >> "$HGTMP/diff"
    done
)

cat "$1" > "$HGTMP/msg"

MD5=$(which md5sum 2>/dev/null) || \
    MD5=$(which md5 2>/dev/null)
[ -x "${MD5}" ] && CHECKSUM=`${MD5} "$HGTMP/msg"`
if [ -s "$HGTMP/diff" ]; then
    $EDITOR "+e $HGTMP/diff" '+set cmdheight=2 buftype=help filetype=diff' "+vsplit $HGTMP/msg" '+set cmdheight=1' || exit $?
else
    $EDITOR "$HGTMP/msg" || exit $?
fi
[ -x "${MD5}" ] && (echo "$CHECKSUM" | ${MD5} -c >/dev/null 2>&1 && exit 13)

mv "$HGTMP/msg" "$1"

exit $?

