#!/bin/bash

if [ $# -lt 1 ]; then
    echo "usage: [apk file]"
    exit 0
fi

APK=$1
APKTOOL=apktool
DEX2JAR=d2j-dex2jar
JAD=jad
OUT=`echo $APK | sed 's/\.apk//g'`
TMPDIR=tmp

# apk -> AndroidManifest.xml smali res
echo $APKTOOL d $APK -o $OUT
$APKTOOL d $APK -o $OUT

# unzip apk to temp
unzip $APK -d $TMPDIR

# classes.jar -> classes/
mkdir $TMPDIR/classes
$DEX2JAR $TMPDIR/classes.dex -o $TMPDIR/classes/classes.jar

cd $TMPDIR/classes
jar xvf classes.jar

# decompile classes/ to src/
$JAD -s java -d ../src -r ./**/*.class
cd -

mv $TMPDIR/src $OUT/

# remove temp dir
rm -rf $TMPDIR
