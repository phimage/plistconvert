#!/bin/bash
if [[ "$OSTYPE" == "darwin"* ]]; then  # Mac OSX
    bin=.build/apple/Products/Release/plistconvert
else
    bin=.build/release/plistconvert
fi

rm -f $bin

if [[ "$OSTYPE" == "darwin"* ]]; then  # Mac OSX
    swift build -c release --arch arm64 --arch x86_64
else
    swift build -c release
fi

$bin --help