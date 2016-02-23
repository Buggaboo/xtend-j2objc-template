#!/bin/sh


ln -s ../j2objc-gradle/gradlew .
ln -s ../j2objc-gradle/systemTests/common/local.properties .
echo "symbolic links created, you may run \"./gradlew clean build\""
