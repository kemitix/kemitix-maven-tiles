#!/usr/bin/env bash

if test $# != 1
then
    echo "next version missing"
    exit
fi

CURRENT=`grep '<version>' pom.xml | sed 's/.*>\(.*\)<.*/\1/'`
NEXT=$1

echo Updating version from $CURRENT to $NEXT

./mvnw versions:set -DnewVersion=$NEXT
./mvnw -pl parent versions:set -DnewVersion=$NEXT
perl -p -i -e "s,$CURRENT</,$NEXT</," release/pom.xml all/tile.xml README.md
