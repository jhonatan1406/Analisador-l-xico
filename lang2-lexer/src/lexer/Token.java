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
    public final String lexeme;

    public Token(int line, int column) {
        this.line = line;
        this.column = column;
        this.lexeme = null;
    }

    public Token(int line, int column, String lexeme) {
        this.line = line;
        this.column = column;
        this.lexeme = lexeme;
    }

    @Override
    public String toString() {
        if (lexeme == null) {
            return String.format("(%d,%d)", line, column);
        }
        return String.format("(%d,%d) %s", line, column, lexeme);
    }
}
