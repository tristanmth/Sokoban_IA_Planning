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
bash script.sh ~/IdeaProjects/pddl4j/src/test/resources/benchmarks/pddl/ipc2000/logistics target/classes/TP/HSP target/classes/TP2/MTC
```

sur LINUX/MacOS

```
./script.sh  <chemin_vers_un_benchmark> target/classes/TP/HSP target/classes/TP2/HSP
```

Les résultats sont affichés dans le fichier [tableau.md](tableau.md)

Même commande pour le SAT planner mais avec TP3/SAT

Pour lancer un benchmark avec un timeout dynamique (de 10 secondes au départ).
Vous pouvez lancer pour avoir de l'aide :

```
./script.sh -h
```

Les résultats sont affichés dans le fichier [tableauSAT.md](tableauSAT.md) 

Les Differences Score et Time sont cumulées sur tout le domaine.

```
./script.sh  <chemin_vers_un_benchmark> target/classes/TP/HSP target/classes/TP3/SAT
```

Pour lancer avec un timeout fixe de 30s mais avec un validateur de plan.

Les résultats sont affichés dans le fichier [SATResults10Problems.md](SATResults10Problems.md)

```
python SatResultsScript.py
```

### Exercice 2

L’encodage n’a généralement pas d’impact significatif sur la difficulté de résolution, sauf en cas d’encodage inefficace
ou de structures spécifiques qui pourraient influencer les performances de certains solveurs. Toutefois, un encodage structuré et bien conçu peut parfois simplifier la résolution en facilitant l’exploitation des contraintes du problème. La difficulté dépend donc principalement de la qualité de l’encodage et des caractéristiques du problème, plutôt que de l’encodage en lui-même.

(source utilisée : [On the Empirical Time Complexity of Scale-Free 3-SAT at the Phase Transition](https://link.springer.com/chapter/10.1007/978-3-030-17462-0_7) )
