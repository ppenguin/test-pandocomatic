#!/usr/bin/env bash

for F in "$@"; do
    OFILE="$(sed -rn 's/^(.*)(\.md)$/\1.pdf/p' <<<"$F")"
    [[ -f "$OFILE" ]] && mv "$OFILE" "$OFILE".bak
    set -x
    pandocomatic -b --data-dir="$(dirname "$F")" -o "$OFILE" "$F" 1>&2 && echo "$OFILE"
    set +x
done