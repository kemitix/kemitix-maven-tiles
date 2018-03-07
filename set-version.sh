#!/usr/bin/env bash

cd `dirname $0`
PROJECT=`basename $PWD`

if test $# != 1
then
    echo "next version missing"
    exit
fi

CURRENT=`grep -C 2 "<artifactId>${PROJECT}</artifactId>" pom.xml | grep '<version>' | sed 's/.*>\(.*\)<.*/\1/'`
NEXT=$1

echo Updating version from $CURRENT to $NEXT

./mvnw versions:set -DnewVersion=$NEXT
./mvnw -pl parent versions:set -DnewVersion=$NEXT
perl -p -i -e "s,$CURRENT</,$NEXT</," all/tile.xml README.md
