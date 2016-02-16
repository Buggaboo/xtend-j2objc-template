=Xtext 2 Java 2 Objc=

This project is a demo on how to transpile to Obj C from Xtend.

While using advanced concepts like [active annotations](http://todo).

How to get this project up and running
--------------------------------------

In a (tmux) terminal:

**Prepare j2objc-gradle**
1. First, downgrade your java 1.7: `cd j2objc-gradle ; ./install-osx-jdk7.sh`
2. Build the project: `JAVA_HOME=$(/usr/libexec/java_home --failfast --version 1.7) ./gradlew clean build./gradlew clean build`
3. run `./systemTests/install.sh && ./systemTests/run-all.sh` to verify you have a working system

**Prepare Xtendroid**
?. Determine the development branch on Xtendroid: `cd Xtendroid ; git branch --all`
?. Change to the correct branch:
    `git checkout $(git branch --all | egrep -o "v[0-9]+\.[0-9]+_development") ; ./gradlew :Xtendroid:clean :Xtendroid:build`


