/*
 * Especificação JFlex para o Analisador Léxico Lang2 (TP1)
 * Autor: Seu Nome / Matrícula
 */
package lexer;

import java.util.Set;
import java.util.HashSet;

%%

/* --- Seção 1: Configurações e Código de Usuário --- */

// Configurações do JFlex
%class Lang2Lexer
%public
%unicode
%line
%column
%type Token

%{

    public static class LexerException extends RuntimeException {
        public LexerException(int line, int column, String message) {
            // Adiciona +1 na linha e coluna pois JFlex é 0-based
            super(String.format("LEX ERROR (%d,%d): %s", line + 1, column + 1, message));
        }
    }

    private static final Set<String> KEYWORDS = new HashSet<>();
    static {
        // Comandos e Estruturas
        KEYWORDS.add("if");
        KEYWORDS.add("else");
        KEYWORDS.add("iterate");
        KEYWORDS.add("data");
        KEYWORDS.add("class");
        KEYWORDS.add("instance");
        KEYWORDS.add("for");
        KEYWORDS.add("return");
        KEYWORDS.add("new");
        
        // Tipos Primitivos (são reservados)
        KEYWORDS.add("Int");
        KEYWORDS.add("Char");
        KEYWORDS.add("Float");
        KEYWORDS.add("Bool");
        KEYWORDS.add("Void");

        // Literais (são reservados)
        KEYWORDS.add("true");
        KEYWORDS.add("false");
        KEYWORDS.add("null");
    }

    private Token makeToken(String lexeme) {
        return new Token(yyline + 1, yycolumn + 1, lexeme);
    }

%}

/* --- Seção 2: Definições de Macros (Expressões Regulares) --- */

// Quebra de linha
EOL = \r|\n|\r\n

// Espaço em branco (sem incluir EOL)
WHITESPACE_CHARS = [ \t\f]

// Espaço em branco geral (ignorar)
WHITESPACE = {WHITESPACE_CHARS}+ | {EOL}

/* --- Comentários --- */
// Comentário de linha: -- até o fim da linha
LINE_COMMENT = "--" [^\r\n]*

/* --- Literais --- */
// Inteiro: [0-9]+
INT = [0-9]+

// Float: [0-9]*\.[0-9]+ (aceita .123, 1.0, 123.456)
FLOAT = [0-9]* \. [0-9]+

// Char: (Conteúdo complexo)
// 1. Escapes simples: \n, \t, \b, \r, \\, \', \"
CHAR_ESCAPE_SIMPLE = \\ [ntbr'\" \\]
// 2. Escapes octais: \ddd (ex: \065)
CHAR_ESCAPE_OCTAL = \\ [0-9]{3}
// 3. Qualquer outro caractere válido (que não seja ', \, ou quebra de linha)
CHAR_REGULAR = [^ \\ ' \n \r]
// 4. O corpo do caractere
CHAR_BODY = ( {CHAR_ESCAPE_SIMPLE} | {CHAR_ESCAPE_OCTAL} | {CHAR_REGULAR} )
// 5. O literal CHAR completo
CHAR = \' {CHAR_BODY} \'

/* --- Identificadores --- */
// ID: letra minúscula, seguida de letras, dígitos ou _
ID = [a-z] [a-zA-Z0-9_]*

// TYID: letra maiúscula, seguida de letras, dígitos ou _
TYID = [A-Z] [a-zA-Z0-9_]*


/* --- Estados --- */
// Estado para processar comentários em bloco {- ... -}
%state BLOCK_COMMENT

%%


<YYINITIAL> {
    
    // 1. Ignorar Espaços em Branco e Quebras de Linha
    {WHITESPACE}          { /* Ignorar */ }

    // 2. Ignorar Comentários
    {LINE_COMMENT}        { /* Ignorar */ }
    
    // 3. Início do Comentário em Bloco
    // Transiciona para o estado BLOCK_COMMENT
    "{-"                  { yybegin(BLOCK_COMMENT); }

    /*
     * 4. Símbolos e Operadores
     * (Os mais longos devem vir primeiro)
     */
    "::"                  { return makeToken("::"); }
    "=="                  { return makeToken("=="); }
    "!="                  { return makeToken("!="); }
    "&&"                  { return makeToken("&&"); }
    
    // Símbolos simples (1 caractere)
    "("                   { return makeToken("("); }
    ")"                   { return makeToken(")"); }
    "["                   { return makeToken("["); }
    "]"                   { return makeToken("]"); }
    "{"                   { return makeToken("{"); }
    "}"                   { return makeToken("}"); }
    ">"                   { return makeToken(">"); }
    ";"                   { return makeToken(";"); }
    ":"                   { return makeToken(":"); }
    "."                   { return makeToken("."); }
    ","                   { return makeToken(","); }
    "="                   { return makeToken("="); }
    "<"                   { return makeToken("<"); }
    "+"                   { return makeToken("+"); }
    "-"                   { return makeToken("-"); }
    "*"                   { return makeToken("*"); }
    "/"                   { return makeToken("/"); }
    "%"                   { return makeToken("%"); }
    "!"                   { return makeToken("!"); }
    
    /*
     * 5. Literais
     * (FLOAT deve vir antes de INT para tratar casos como "1.0")
     */
    {FLOAT}               { return makeToken(yytext()); }
    {INT}                 { return makeToken(yytext()); }
    {CHAR}                { return makeToken(yytext()); }

    /*
     * 6. Identificadores (ID e TYID)
     * (ID usa o helper para checar se é Palavra Reservada)
     */
    {ID}                  { return makeToken(yytext()); }
    {TYID}                { return makeToken(yytext()); }

    /*
     * 7. Tratamento de Erros para Literais CHAR mal formados
     */
    // Char vazio
    \'\'                  { throw new LexerException(yyline, yycolumn, "Literal char vazio"); }
    // Char com mais de um caractere
    \' {CHAR_BODY} {CHAR_BODY}+ \' { throw new LexerException(yyline, yycolumn, "Literal char muito longo: " + yytext()); }
    // Char com escape inválido (ex: '\z')
    \' \\ [^ntbr'\" \\ 0-9] [^\']* \' { throw new LexerException(yyline, yycolumn, "Sequência de escape inválida no char: " + yytext()); }
    // Char com octal incompleto (ex: '\01' ou '\0')
    \' \\ [0-9]{1,2} [^\'0-9] [^\']* \' { throw new LexerException(yyline, yycolumn, "Escape octal deve ter 3 dígitos: " + yytext()); }
    // Char não terminado (pega ' no final da linha)
    \' [^ \n \r]* {EOL}   { throw new LexerException(yyline, yycolumn, "Literal char não terminado na linha"); }
    // Char não terminado (pega ' solto)
    \'                    { throw new LexerException(yyline, yycolumn, "Literal char não terminado"); }
}


/*
 * Regras para o estado de Comentário em Bloco
 */
<BLOCK_COMMENT> {
    
    // 1. Fim do comentário
    "-}"                  { yybegin(YYINITIAL); }
    
    // 2. Conteúdo do comentário (qualquer coisa que não seja "-}")
    // [^-}]+ consome tudo que não é '-' ou '}' (otimização)
    [^-}]+                { /* Consome bloco de comentário */ }
    
    // Consome '-' ou '}' sozinhos
    "-" | "}"             { /* Consome */ }
    
    // 3. Erro: Fim de arquivo (EOF) dentro de um comentário em bloco
    <<EOF>>               { throw new LexerException(yyline, yycolumn, "Comentário em bloco não terminado (EOF)"); }
}


/*
 * 8. Erro Léxico Genérico (Catch-all)
 * [^] corresponde a *qualquer* caractere que não foi casado
 * pelas regras anteriores.
 */
[^]                   { throw new LexerException(yyline, yycolumn, "Caractere inválido: " + yytext()); }
