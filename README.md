Xtext 2 Java 2 Objc
===================

This project is a demo on how to transpile to Obj C from Xtend.

While using advanced concepts like [active annotations](http://todo).

How to get this project up and running
--------------------------------------

In a (tmux) terminal:

**Prepare j2objc-gradle**

0. Install [brew](http://brew.sh/)
1. First, install java jdk 1.7: `brew tap caskroom/versions ; brew cask install caskroom/versions/java7`, otherwise you will get a _café babe_. Caveat: **Do not run the install-osx-jdk7.sh** script unless you want to lose all your JDKs.
2. Build the `cd j2objc-gradle ; JAVA_HOME=$(/usr/libexec/java_home --failfast --version 1.7) ./gradlew clean build`
3. run `./systemTests/install.sh && ./systemTests/run-all.sh` to verify you have a working system

**Prepare Xtendroid**

1. Determine the development branch on Xtendroid: `cd Xtendroid ; git branch --all`
2. Change to the development branch:
    `git checkout $(git branch --all | egrep -o "v[0-9]+\.[0-9]+_development") ; ./gradlew :Xtendroid:clean :Xtendroid:build`


