#!/bin/sh

VERSION=1.0.1

export J2OBJC_ROOT=~/j2objcDist
mkdir -p $J2OBJC_ROOT; pushd $J2OBJC_ROOT
curl -L https://github.com/google/j2objc/releases/download/${VERSION}/j2objc-${VERSION}.zip > j2objc-${VERSION}.zip
unzip j2objc-${VERSION}.zip; popd
test -e local.properties || touch local.properties
sed -i '' '/j2objc.home/d' local.properties
echo j2objc.home=$J2OBJC_ROOT/j2objc-${VERSION} >> local.properties
