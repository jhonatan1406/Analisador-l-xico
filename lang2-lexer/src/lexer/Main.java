package lexer;

import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

public class Main {
    public static void main(String[] args) {

        if (args.length != 2 || !args[0].equals("-lex")) {
            System.err.println("Uso: java -jar lexer.jar -lex <arquivo.lang2>");
            System.exit(1);
        }

        String filename = args[1];
        Reader reader = null;
        Lang2Lexer lexer = null;

        try {
           
            reader = new FileReader(filename);
            
            
            lexer = new Lang2Lexer(reader);
            
            Token t;
    
            while ((t = lexer.yylex()) != null) {
                System.out.println(t.toString());
            }

        } catch (IOException e) {
            System.err.println("Erro de I/O ao ler o arquivo: " + filename);
            System.err.println(e.getMessage());
            System.exit(2);
        
        } catch (Lang2Lexer.LexerException e) {
            System.err.println(e.getMessage());
            System.exit(3);
        
        } catch (Exception e) {
            System.err.println("Erro inesperado durante a análise:");
            e.printStackTrace();
            System.exit(4);

        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    System.err.println("Erro ao fechar o arquivo: " + e.getMessage());
                }
            }
        }
    }
}
