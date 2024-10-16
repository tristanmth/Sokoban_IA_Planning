Maven is needed.

Install pddl4j (https://github.com/pellierd/pddl4j) in your local maven repo:

faire de même pour le fichier json-20230618.jar (https://mavenlibs.com/jar/file/org.json/json)
```
mvn install:install-file -Dfile=<path-to-file-pddl4j-4.0.0.jar> -DgroupId="fr.uga" -DartifactId=pddl4j -Dversion="4.0.0" -Dpackaging=jar -DgeneratePom=true
 ```
Work with maven
```
mvn clean compile package
```

Pour décoder un fichier json :
```
java --add-opens java.base/java.lang=ALL-UNNAMED 
    -server -Xms2048m -Xmx2048m 
    -cp target/sokoban-1.0-SNAPSHOT-jar-with-dependencies.jar 
    TP.JsonDecoder config/<fichier.json>  

```
ou
```
java --add-opens java.base/java.lang=ALL-UNNAMED
      -server -Xms2048m -Xmx2048m 
      -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q):target/test-classes/:target/classes" 
      TP.JsonDecoder config/<fichier.json>
```
Les fichiers "result.pddl" sont générés à la racine du projet.
Si celui-ci existe déjà, un fichier "result(1).pddl" sera créé; etc.

Pour résoudre un problème Sokoban :
```
java --add-opens java.base/java.lang=ALL-UNNAMED 
      -server -Xms2048m -Xmx2048m 
      -cp target/sokoban-1.0-SNAPSHOT-jar-with-dependencies.jar 
     TP.SimplePlanner sokoban.pddl result.pddl 
```
ou
```
java --add-opens java.base/java.lang=ALL-UNNAMED \
      -server -Xms2048m -Xmx2048m \
      -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q):target/test-classes/:target/classes" \
      TP.SimplePlanner sokoban.pddl result.pddl 
```
Les commandes ci-dessus sortent les résultats du planner. 
Pour pouvoir récupérer la séquence d'action solution du problème.
Il faut après avoir écrit la commande, rediriger la sortie standard vers un fichier texte.

à l'aide de la commande suivante :
```
 > <nom_du_fichier>.txt
```
Comme par exemple :
```
java --add-opens java.base/java.lang=ALL-UNNAMED \
      -server -Xms2048m -Xmx2048m \
      -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q):target/test-classes/:target/classes" \
      TP.SimplePlanner sokoban.pddl result.pddl > result.txt
```
et à l'aide de la commande suivante on peut recupéré la séquence d'action solution du problème.
```
java --add-opens java.base/java.lang=ALL-UNNAMED
       -server -Xms2048m -Xmx2048m
       -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout
        -q):target/test-classes/:target/classes"   TP.Regex result.txt
```
Qui devrait afficher la séquence d'action solution du problème.
(Dans notre cas : "urdddluruulllddrdrruuuuuldrddddllurdruuuldrddlluluur")
   
IL faut rentrer la séquence dans Agent.java et le test.json dans SokobanMain.java et recompiler

Pour run l'interface
```
java --add-opens java.base/java.lang=ALL-UNNAMED -server -Xms2048m -Xmx2048m -cp target/sokoban-1.0-SNAPSHOT-jar-with-dependencies.jar sokoban.SokobanMain
```

See planning solutions at http://localhost:8888/test.html