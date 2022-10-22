#!/usr/bin/env bash

TMP="${TMPDIR}"
if [ "x$TMP" = "x" ]; then
  TMP="/tmp/"
fi
TMP="${TMP}plistconvert.$$"
rm -rf "$TMP" || true
mkdir "$TMP"
if [ $? -ne 0 ]; then
  echo "failed to mkdir $TMP" >&2
  exit 1
fi

cd $TMP

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  . /etc/lsb-release
  if [ "$DISTRIB_ID" != "Ubuntu" ]; then
    echo "Only ubuntu supported"
    exit 1
  fi
  if [ "$DISTRIB_CODENAME" != "focal" ]; then
    echo "Only ubuntu focal supported"
    exit 1
  fi
  if [ -z "$(which swift)" ]; then
    archiveName=plistconvert-x86_64-static-ubuntu-$DISTRIB_CODENAME.zip
  else
    archiveName=plistconvert-X86_64-dynamic_swift_5.7-ubuntu-$DISTRIB_CODENAME.zip
  fi
elif [[ "$OSTYPE" == "darwin"* ]]; then  # Mac OSX
  archiveName=plistconvert.zip
else
  echo "Unknown os type $OSTYPE, macOS or ubuntu"
  exit 1
fi

archive=$TMP/$archiveName
curl -sL https://github.com/phimage/plistconvert/releases/latest/download/$archiveName -o $archive

if [[ "$OSTYPE" == "darwin"* ]]; then  # Mac OSX
  unzip -q $archive -d $TMP/
else
  tar -zxf $archive -C $TMP/
fi

binary=$TMP/plistconvert 

dst="/usr/local/bin"
echo "Install into $dst/plistconvert"
sudo rm -f $dst/plistconvert
sudo cp $binary $dst/

rm -rf "$TMP"
