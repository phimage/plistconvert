#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then  # Mac OSX
    cmd=.build/apple/Products/Release/plistconvert
else
    cmd=.build/release/plistconvert
fi
file=.build/checkouts/XcodeProjKit/Tests/ok/advance.56412ec.project

if [[ ! -f "$cmd" ]]
then
    ./build.sh
fi

exitStatus=0

# json
$cmd  --convert "json" --extension "json" $file.pbxproj

bin=$([[ "$OSTYPE" == "darwin"* ]] && echo "jsonlint"  || echo "jsonlint-php")
if [ -z "$(which $bin)" ]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install jsonlint
    else
        sudo apt-get -y install jsonlint
    fi
fi
if "$bin" $file.json > /dev/null
then
    echo "✅ json"
else
    echo "🚫 json"
    exitStatus=1
fi
rm $file.json 

# json stdout
$cmd  --convert "json" --output - $file.pbxproj > $file.stdout

if "$bin" $file.stdout > /dev/null
then
    echo "✅ json in stdout"
else
    echo "🚫 json in stdout"
    exitStatus=1
fi
rm $file.stdout

# xml
$cmd  --convert "xml" --extension "xml" $file.pbxproj
if [ -z "$(which xmllint)" ]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install xmllint
    else
        sudo apt-get -y install libxml2-utils 
    fi
fi
if xmllint --noout $file.xml > /dev/null 2>&1
then
    echo "✅ xml"
else
    echo "🚫 xml"
    exitStatus=1
fi
rm $file.xml 

# binary
$cmd  --convert "binary" --extension "binary" $file.pbxproj
if file --mime-encoding $file.binary | grep "binary" | wc -l > /dev/null; 
then
    echo "✅ binary"
else
    echo "🚫 binary"
    exitStatus=1
fi
rm $file.binary 

exit $exitStatus
