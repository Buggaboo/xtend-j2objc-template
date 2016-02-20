Xtend 2 Java 2 Objective C
==========================

This project is a demo on how to transpile to Obj C from Xtend.

While using advanced concepts like [active annotations](http://todo).

How to get this project up and running
--------------------------------------

In a (tmux) terminal:

**Prepare j2objc-gradle**

0. Install [brew](http://brew.sh/)
1. First, install java jdk 1.7: `brew tap caskroom/versions ; brew cask install caskroom/versions/java7`, otherwise you will get a _café babe_. Caveat: **Do not run the install-osx-jdk7.sh** script unless you want to lose all your JDKs.
2. Install [jenv](http://www.jenv.be/) and add your jdk environments to jenv: `brew install jenv ; find /Library/Java/JavirtualMachines -name 'Home' -exec jenv add {} \;`
3. Build the `jenv shell 1.7 ; cd j2objc-gradle ; ./gradlew clean build`
4. run `./systemTests/install.sh && ./systemTests/run-all.sh` to verify you have a working system

**Prepare Xtendroid**

0. Be consistent and build with jdk 1.7: `jenv shell 1.7`
1. Determine the development branch on Xtendroid: `cd Xtendroid ; git branch --all`
2. Change to the development branch:
    `git checkout $(git branch --all | egrep -o "v[0-9]+\.[0-9]+_development") ; ./gradlew :Xtendroid:clean :Xtendroid:build`
    
Workflow
--------

1. Import ':xtendshared' into your IDE (intellij / Android Studio), work from there as usual; ':xtendshared' is its own gradle rootProject, because ':xtendshared' requires gradle-2.10, and j2objc-gradle requires gradle-2.3.
2. Every time ':xtendshared' is built (`./gradlew build`), the java files will be copied to the ':shared' project.
3. The same applies to `./gradlew cAT`, these will be transpiled to Objective C as well
3. Transpiling to j2objc, requires you run (`./gradlew build j2objcBuild`) in the directory _allPlatforms_


Roadmap
-------

* Write a quotation apps in XCode (swift) and Android Studio (>2.0.0 alpha) that uses the :shared project.
* When j2obcj-gradle finally upgrades to >gradle-2.8, then we can merge the Xtendroid part