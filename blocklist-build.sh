#!/bin/sh
curl -s https://www.iblocklist.com/lists.json | \
    jq -r '.lists[] | select(.subscription == "false") | .list' | \
    awk '{ print "http://list.iblocklist.com/?fileformat=p2p&archiveformat=gz&list=" $0 }' | \
    xargs wget -O - | \
    gunzip | \
    egrep -v '^#' | \
    gzip > blocklist.gz
