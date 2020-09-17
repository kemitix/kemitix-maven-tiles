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

mvn versions:set -DnewVersion=$NEXT
mvn -pl parent versions:set -DnewVersion=$NEXT
