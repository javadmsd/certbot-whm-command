#!/bin/bash

DIR="$(dirname "$0")"
source "$DIR/config.sh"

log() {
    echo "$1" >> "$LOG_FILE"
}

log "DOMAIN: ${RECORD_DOMAIN}"

RECORDS=$(whmapi1 dumpzone domain="$RECORD_DOMAIN")

RECORD_LINE=$(echo "$RECORDS" | sed ':a;N;$!ba;s/\n/ /g' | sed 's/ \+/ /g' | grep -oP 'Line: \d+ char_str_list.*?name: '"$RECORD_NAME"'.*?type: TXT' | grep -oP 'Line: \K\d+')

if [[ -n "$RECORD_LINE" ]]; then
    RESPONSE=$(whmapi1 removezonerecord zone="$RECORD_DOMAIN" line="$RECORD_LINE")

    log "Removed record at line index $RECORD_LINE"
else
    log "No matching TXT record found for removal."
fi
