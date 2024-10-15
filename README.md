Maven is needed.

Install pddl4j (https://github.com/pellierd/pddl4j) in your local maven repo:
```
mvn install:install-file -Dfile=<path-to-file-pddl4j-4.0.0.jar> -DgroupId="fr.uga" -DartifactId=pddl4j -Dversion="4.0.0" -Dpackaging=jar -DgeneratePom=true
 ```  

Work with maven
```
mvn clean compile package
```

For result file
```
java --add-opens java.base/java.lang=ALL-UNNAMED -server -Xms2048m -Xmx2048m -cp target/sokoban-1.0-SNAPSHOT-jar-with-dependencies.jar JsonDecoder .\config\test1.json  

```

For run graphical interface
```
java --add-opens java.base/java.lang=ALL-UNNAMED -server -Xms2048m -Xmx2048m -cp target/sokoban-1.0-SNAPSHOT-jar-with-dependencies.jar sokoban.SokobanMain
```

See planning solutions at http://localhost:8888/test.html