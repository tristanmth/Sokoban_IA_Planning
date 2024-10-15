
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.json.*;

public class JsonDecoder {
    public static void main(String[] args) {
        new JsonDecoder(args);
        
    }

    JsonDecoder(String[] args) {
        try {
            Path path = Paths.get(args[0]);// On récupère le chemin du fichier json
            long size = Files.size(path);// On récupère la taille du fichier
            FileReader input = new FileReader(path.toString()); // On crée un FileReader pour lire le fichier
            char[] array = new char[(int) size]; // On crée un tableau de char de la taille du fichier
            input.read(array);// On remplit le tableau avec le contenu du fichier
            JSONObject obj = new JSONObject(new String(array));// On parse le contenu du fichier en JSON
            String testIn = (String) obj.get("testIn");// On récupère la valeur de la clé "testIn"
            exportPDDL(testIn);
        } catch (Exception e) {
            System.out.println("Erreur lors de la lecture du fichier "+e);
        }
    }

    void exportPDDL(String testIn) throws IOException {
        String filePath = "result.pddl";
        File file = new File(filePath);
        int i = 1;
        while (file.exists()) {
            file = new File(filePath.replace("result", "result" + "(" + i++ + ")"));
        }
        BufferedWriter writer = new BufferedWriter(new FileWriter(file.getAbsolutePath(), true));
        String positions = objectPositions(testIn);
        String walls = objectWalls(testIn);
        String agent = positionAgent(testIn);
        String boxes = positionBoxes(testIn);
        String relatives = objectRelatives(testIn);
        String goals = objectGoals(testIn);
        String sb = "(define (problem Sokoban)\n" +
                "\t\t(:domain sokoban)\n" +
                "\t\t(:objects" + positions + " - position agent - guard)\n" +
                "\t\t(:INIT " + walls + "\n" +
                agent + "\n" +
                boxes + "\n" +
                relatives + "\n" +
                ")\n" +
                "\t\t(:goal (AND" + goals + "))\n" +
                ")\n";
        writer.append(sb);
        writer.close();
    }

    String objectPositions(String testIn) {
        String[] positions = testIn.split("\n");
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < positions.length; i++) {
            boolean first = false;
            for (int j = 0; j < positions[i].length(); j++) {
                if (positions[i].charAt(j) == '#') {
                    first = true;
                } if (first) {
                    sb.append(" ").append((char) (j + 65)).append(i);
                    /*le ((char) (j+65)) permet de convertir un entier en char 
                    (pas necessaire mais facilite le debugage)
                    */
                }
            }
        }
        return sb.toString();
    }

    String objectWalls(String testIn) {
        String[] positions = testIn.split("\n");
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < positions.length; i++) {
            for (int j = 0; j < positions[i].length(); j++) {
                if (positions[i].charAt(j) == '#') {
                    sb.append(" (isWall ").append((char)(j + 65)).append(i).append(")");
                }
            }
        }
        return sb.toString();
    }

    String positionAgent(String testIn) {
        String[] positions = testIn.split("\n");
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < positions.length; i++) {
            for (int j = 0; j < positions[i].length(); j++) {
                if (positions[i].charAt(j) == '@' || positions[i].charAt(j) == '+') {
                    sb.append(" (at agent ").append((char)(j + 65)).append(i).append(")");
                    return sb.toString();
                }
            }
        }
        return sb.toString();
    }

    String positionBoxes(String testIn) {
        String[] positions = testIn.split("\n");
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < positions.length; i++) {
            for (int j = 0; j < positions[i].length(); j++) {
                if (positions[i].charAt(j) == '$' || positions[i].charAt(j) == '*') {
                    sb.append(" (isBox ").append((char)(j + 65)).append(i).append(")");
                }
            }
        }
        return sb.toString();
    }

    String objectRelatives(String testIn) {
        String[] positions = testIn.split("\n");
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < positions.length; i++) {
            boolean first = false;
            for (int j = 0; j < positions[i].length(); j++) {
                if (positions[i].charAt(j) == '#') {
                    first = true;
                }
                if (first && positions[i].charAt(j) != '#') {
                    if ((i + 1 < positions.length) && positions[i + 1].charAt(j) != '#'){
                        sb.append(" (haut ").append((char) (j + 65)).append(i).append(" ").append((char) (j + 65)).append(i + 1).append(")");
                        sb.append(" (bas ").append((char)(j + 65)).append(i + 1).append(" ").append((char)(j + 65)).append(i).append(")\n");
                    }    
                    if ((j + 1 < positions[i].length()) && positions[i].charAt(j + 1) != '#'){
                        sb.append(" (gauche ").append((char)(j + 65)).append(i).append(" ").append((char)(j+1+65)).append(i).append(")");
                        sb.append(" (droite ").append((char)(j + 1 + 65)).append(i).append(" ").append((char) (j+65)).append(i).append(")\n");
                    }
                }
            }
        }
        return sb.toString();
    }
    
    String objectGoals(String testIn) {
        String[] positions = testIn.split("\n");
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < positions.length; i++) {
            for (int j = 0; j < positions[i].length(); j++) {
                if (positions[i].charAt(j) == '.' || positions[i].charAt(j) == '+' || positions[i].charAt(j) == '*') {
                    sb.append(" (isBox ").append((char)(j + 65)).append(i).append(")");
                }
            }
        }
        return sb.toString();
    }
}
