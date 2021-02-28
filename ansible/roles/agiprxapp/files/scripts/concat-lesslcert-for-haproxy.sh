#!/bin/bash

# $RENEWED_LINEAGE set to e.g. /etc/letsencrypt/live/example.org
# $RENEWED_DOMAINS set to e.g. example.org www.example.org

#RENEWED_LINEAGE=/etc/letsencrypt/live/example.org
if [ -z "$RENEWED_LINEAGE" ]; then
        echo "Variable RENEWED_LINEAGE not set, haproxy pem packaging failed"
        exit 1
fi

PATHPREFIX=/etc/letsencrypt/live/
if [[ $RENEWED_LINEAGE != $PATHPREFIX* ]]; then
	echo "Variable RENEWED_LINEAGE set to $RENEWED_LINEAGE, but should start with $PATHPREFIX, haproxy pem packaging failed"
        exit 1
fi

PATHPREFIX_LENGTH=${#PATHPREFIX}

SITE=${RENEWED_LINEAGE:PATHPREFIX_LENGTH} 
#echo $SITE
if [ -z "$SITE" ]; then
	echo "Site cannot be detected in $RENEWED_LINEAGE, haproxy pem packaging failed"
	exit 1
else 
	cd $RENEWED_LINEAGE
	cat fullchain.pem privkey.pem > /etc/haproxy/certs/$SITE.pem
fi

exit 0

