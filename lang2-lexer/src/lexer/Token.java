// Alunos: Jhonatan Figueiredo almeida - 20.1.8164 e Laura Lima Marques - 21.1.8022
package lexer;

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
