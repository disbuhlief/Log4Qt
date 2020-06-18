#!/bin/bash -e

echo -n "Checking installed cmake3, cpack3 versions .. "
cmake3_ver=$(rpm -q --queryformat '%{VERSION}' cmake3) || (echo "Not installed, aborting" && exit 1)
echo -n "cmake3 version: ${cmake3_ver}"

[[ "$cmake3_ver" < "3.17.2" ]] && (echo "Incompatible version, aborting" && exit 1)

if [ -z "$1"   ]
then
    BUILD_DIR=build-Release
    BUILD_TYPE=Release
else
    BUILD_DIR=build-$1
    BUILD_TYPE=$1
fi

rm -R $BUILD_DIR
mkdir $BUILD_DIR
cd $BUILD_DIR

cmake3 ..
cmake3 --build . --target package
