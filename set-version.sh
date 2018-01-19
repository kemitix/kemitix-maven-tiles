#!/usr/bin/env bash

if test $# != 2
then
    echo "current and next version missing"
    exit
fi

CURRENT=$1
NEXT=$2

echo Updating version from $CURRENT to $NEXT

./mvnw versions:set -DnewVersion=$NEXT
perl -p -i -e "s,$CURRENT</,$NEXT</," all/tile.xml README.md
