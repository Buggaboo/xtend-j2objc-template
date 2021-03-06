Xtend 2 Java 2 Objective C (2 Swift?)
=====================================

This project is a demo on how to transpile to Obj C from Xtend.

How to get this project up and running
--------------------------------------

In a (tmux) terminal:

**Prepare j2objc-gradle**

0. Install [brew](http://brew.sh/)
1. First, install java jdk 1.7: `brew tap caskroom/versions ; brew cask install caskroom/versions/java7`, otherwise you will get a [_café babe_](https://en.wikipedia.org/wiki/Java_class_file). Caveat: **Do not run the install-osx-jdk7.sh** script unless you want to lose all your JDKs.
2. Install [jenv](http://www.jenv.be/) and add your jdk environments to jenv: `brew install jenv ; find /Library/Java/JavaVirtualMachines -name 'Home' -exec jenv add {} \;`
3. Build the `jenv shell 1.7 ; cd j2objc-gradle ; ./gradlew clean build`
4. Prepare the project itself, setup 'local.properties' for j2objc: `cd xtendAllPlatforms ; ./run-me-first`

**Prepare Xtendroid**

0. Be consistent and build with jdk 1.7: `jenv shell 1.7`
1. Determine the development branch on Xtendroid: `cd Xtendroid ; git branch --all`
2. Change to the development branch:
    `git checkout $(git branch --all | egrep -o "v[0-9]+\.[0-9]+_development")`
    
Workflow
--------
0. Be consistent and build with jdk 1.7: `jenv shell 1.7`
1. Import ':xtendshared' into your IDE (intellij / Android Studio), work from there as usual; ':xtendshared' has its own gradle rootProject, because ':xtendshared' requires gradle-2.10, and j2objc-gradle requires gradle-2.3.
2. Run `gradle wrapper` to generate a `gradlew` file 
3. Every time ':xtendshared' is built (`./gradlew build`), the java files will be copied to the ':shared' project, ':xtendapp' can also make ':xtendshared' start building
4. The same applies to `./gradlew cAT`, these will be transpiled to Objective C as well
5. Transpiling to j2objc, requires you run (`./gradlew build j2objcBuild`) in the directory `xtendAllPlatforms`


Roadmap
-------
* Create a task that determines the xtend code's package name, then obliterates ':shared' copy of the java files depending on that package name
* Write a wiki quote apps in XCode (swift) and Android Studio (>2.0.0 alpha) that uses the :shared project, just like [the wikiquotes-api project](https://github.com/natetyler/wikiquotes-api).
* [Eliminate dead code, with proguard and j2objc](http://j2objc.org/docs/Dead-Code-Elimination.html)
* When j2obcj-gradle finally upgrades to >gradle-2.8, then we can merge the Xtendroid part

Handy things to know
--------------------
* Forget about URI.Builder, also forget UrlBuilder, roll your own
* Run unit tests with `xtendAllPlatforms> ./gradlew cleanTest test` and if you're confident `./gradlew build`
* Transpile from Xtend to java with `xtendshared> ./gradlew build cAT`, which triggers the copy actions
* `HttpUrlConnection` is very broken when cast to a `java.net.ssl.HttpsUrlConnection`, IosHttpsUrlConnection seems to be promising, must do additional testing on j2objc-1.0.1.
