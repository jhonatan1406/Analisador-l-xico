/*
 * Classe Token
 * Autor: Seu Nome / Matrícula
 */
package lexer;

/**
 * Representa um token léxico.
 * Armazena o tipo (classe), o lexema e as coordenadas (linha, coluna).
 */
public class Token {
    public final int line;
    public final int column;
    public final String type;
    public final String lexeme;

    /**
     * Construtor para Tokens (ex: Símbolos) onde o lexema é o próprio tipo.
     */
    public Token(int line, int column, String type) {
        this.line = line;
        this.column = column;
        this.type = type;
        this.lexeme = null; // Ou podemos usar o 'type' aqui, mas null é mais limpo
    }

    /**
     * Construtor principal para Tokens com lexema.
     */
    public Token(int line, int column, String type, String lexeme) {
        this.line = line;
        this.column = column;
        this.type = type;
        this.lexeme = lexeme;
    }

    /**
     * Formata o token para a saída padrão conforme especificado.
     * Formato: (linha,coluna) CLASSE(lexema)
     */
    @Override
    public String toString() {
        // O formato de saída pedido é (linha,coluna) CLASSE(lexema)
        // Se o lexema for nulo (o que não deve acontecer com o makeToken atual),
        // adaptamos, mas o padrão é sempre incluir o lexema.
        if (lexeme == null) {
            return String.format("(%d,%d) %s", line, column, type);
        }
        return String.format("(%d,%d) %s(%s)", line, column, type, lexeme);
    }
}
