/*
 * Classe Main (Driver)
 * Autor: Seu Nome / Matrícula
 */
package lexer;

import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

/**
 * Classe principal que gerencia a execução do analisador léxico
 * pela linha de comando.
 */
public class Main {
    public static void main(String[] args) {
        // 1. Validar os argumentos da linha de comando
        if (args.length != 2 || !args[0].equals("-lex")) {
            System.err.println("Uso: java -jar lexer.jar -lex <arquivo.lang2>");
            System.exit(1);
        }

        String filename = args[1];
        Reader reader = null;
        Lang2Lexer lexer = null;

        try {
            // 2. Abrir o arquivo fonte
            reader = new FileReader(filename);
            
            // 3. Instanciar o analisador léxico
            lexer = new Lang2Lexer(reader);
            
            Token t;
            // 4. Ler e imprimir tokens até o fim do arquivo (EOF)
            while ((t = lexer.nextToken()) != null) {
                System.out.println(t.toString());
            }

        } catch (IOException e) {
            // Erro de I/O (ex: arquivo não encontrado)
            System.err.println("Erro de I/O ao ler o arquivo: " + filename);
            System.err.println(e.getMessage());
            System.exit(2);
        
        } catch (Lang2Lexer.LexerException e) {
            // Erro léxico customizado vindo do JFlex
            System.err.println(e.getMessage());
            System.exit(3);
        
        } catch (Exception e) {
            // Outros erros inesperados
            System.err.println("Erro inesperado durante a análise:");
            e.printStackTrace();
            System.exit(4);

        } finally {
            // 5. Garantir que o arquivo seja fechado
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
