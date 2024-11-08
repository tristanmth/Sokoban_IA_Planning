Maven est nécessaire.

Installer pddl4j (https://github.com/pellierd/pddl4j) dans votre dépôt Maven local. :

faire de même pour le fichier json-20230618.jar (https://mavenlibs.com/jar/file/org.json/json)
```
mvn install:install-file -Dfile=<chemin-au-fichier-pddl4j-4.0.0.jar> -DgroupId="fr.uga" -DartifactId=pddl4j -Dversion="4.0.0" -Dpackaging=jar -DgeneratePom=true
 ```
Travailler avec maven dans le projet:
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
      -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout 
      -q):target/test-classes/:target/classes" 
      TP.JsonDecoder config/<fichier.json>
```
Les fichiers "result.pddl" sont générés à la racine du projet.
Si celui-ci existe déjà, un fichier "result(1).pddl" sera créé, etc.

Pour résoudre un problème Sokoban :
```
java --add-opens java.base/java.lang=ALL-UNNAMED 
      -server -Xms2048m -Xmx2048m 
      -cp target/sokoban-1.0-SNAPSHOT-jar-with-dependencies.jar 
     TP.SimplePlanner sokoban.pddl result.pddl 
```
ou
```
java --add-opens java.base/java.lang=ALL-UNNAMED 
      -server -Xms2048m -Xmx2048m 
      -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout 
      -q):target/test-classes/:target/classes" 
      TP.SimplePlanner sokoban.pddl result.pddl 
```
Les commandes ci-dessus sortent les résultats du planner. 
Pour pouvoir récupérer la séquence d'action solution du problème.
Il faut, après avoir écrit la commande, rediriger la sortie standard vers un fichier texte.

à l'aide de la commande suivante :
```
 > <nom_du_fichier>.txt
```
Comme par exemple :
```
java --add-opens java.base/java.lang=ALL-UNNAMED \
      -server -Xms2048m -Xmx2048m \
      -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout 
      -q):target/test-classes/:target/classes" \
      TP.SimplePlanner sokoban.pddl result.pddl > result.txt
```
et à l'aide de la commande suivante on peut recupéré la séquence d'action solution du problème.

```
java --add-opens java.base/java.lang=ALL-UNNAMED 
      -server -Xms2048m -Xmx2048m 
      -cp target/sokoban-1.0-SNAPSHOT-jar-with-dependencies.jar 
      TP.Regex result.txt
```
ou
```
java --add-opens java.base/java.lang=ALL-UNNAMED
       -server -Xms2048m -Xmx2048m
       -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout
        -q):target/test-classes/:target/classes"   
        TP.Regex result.txt
```

Qui devrait afficher la séquence d'action solution du problème.
(Dans notre cas : "urdddluruulllddrdrruuuuuldrddddllurdruuuldrddlluluur")
   
IL faut rentrer la séquence dans Agent.java et le test.json dans SokobanMain.java et recompiler

Pour run l'interface
```
java --add-opens java.base/java.lang=ALL-UNNAMED -server -Xms2048m -Xmx2048m -cp target/sokoban-1.0-SNAPSHOT-jar-with-dependencies.jar sokoban.SokobanMain
```

Voir les solutions de planification à http://localhost:8888/test.html

Pour lancer le script : 

sur Windows
```
bash script.sh
~/IdeaProjects/pddl4j/src/test/resources/benchmarks/pddl/ipc2000/logistics 
~/IdeaProjects/Sokoban_IA_Planning/target/classes/TP/HSP 
~/IdeaProjects/sokoban/target/classes/TP2/MTC
```

sur LINUX/MacOS
```
./ script.sh 
~/IdeaProjects/pddl4j/src/test/resources/benchmarks/pddl/ipc2000/logistics 
~/IdeaProjects/Sokoban_IA_Planning/target/classes/TP/HSP 
~/IdeaProjects/sokoban/target/classes/TP2/MTC
```