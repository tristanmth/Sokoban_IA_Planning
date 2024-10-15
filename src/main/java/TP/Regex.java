package TP;
import java.io.FileReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class Regex {

    public static void main(String[] args) {
        try {
            Path path = Paths.get(args[0]);// On récupère le chemin du fichier
            long size = Files.size(path);// On récupère la taille du fichier
            FileReader input = new FileReader(path.toString()); // On crée un FileReader pour lire le fichier
            char[] array = new char[(int) size]; // On crée un tableau de char de la taille du fichier
            input.read(array);// On remplit le tableau avec le contenu du fichier
            StringBuilder match = new StringBuilder();
            StringBuilder returner = new StringBuilder();
            Pattern pattern = Pattern.compile("((p[rlud])|(m[rlud])) ");
            Matcher matcher = pattern.matcher(match.append(array));
            while (matcher.find()) {
                returner.append(matcher.group().split("")[1]);
            }
            System.out.println(returner);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
