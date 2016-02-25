#!/bin/sh

export J2OBJC_ROOT=~/j2objcDist
mkdir -p $J2OBJC_ROOT; pushd $J2OBJC_ROOT
curl -L https://github.com/google/j2objc/releases/download/0.9.8.2.1/j2objc-0.9.8.2.1.zip > j2objc-0.9.8.2.1.zip
unzip j2objc-0.9.8.2.1.zip; popd
test -e local.properties || touch local.properties
sed -i '' '/j2objc.home/d' local.properties
echo j2objc.home=$J2OBJC_ROOT/j2objc-0.9.8.2.1 >> local.properties
