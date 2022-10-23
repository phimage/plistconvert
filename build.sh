#!/bin/bash
mode=release
bin=.build/$mode/plistconvert

rm -f $bin

swift build -c $mode

$bin --help
