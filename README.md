=Xtext 2 Java 2 Objc=

This project is a demo on how to transpile to Obj C from Xtend.

While using advanced concepts like [active annotations](http://todo).

How to get this project up and running
--------------------------------------

In a (tmux) terminal:

**Prepare j2objc-gradle**
0. Go to the project directory, make sure you have all the required submodules
1. `cd j2objc-gradle ; ./gradlew build`
2. run `./systemTests/install.sh && ./systemTests/run-all.sh` to verify you have a working system

**Prepare Xtendroid**
?. Determine the development branch on Xtendroid: `cd Xtendroid ; git branch --all`
?. `git checkout $(git branch --all | egrep -o "v[0-9]+\.[0-9]+_development") ; ./gradlew :Xtendroid:clean :Xtendroid:build`


