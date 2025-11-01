Analisador Léxico Lang2 (TP1)Este projeto contém um analisador léxico completo para a linguagem lang2, implementado em Java usando o gerador de lexer JFlex.Estrutura de Arquivoslang2-lexer/
├── src/
│   └── lexer/
│       ├── Lang2Lexer.jflex  (Definição do Lexer)
│       ├── Main.java         (Driver CLI)
│       └── Token.java        (Classe de Token)
├── Makefile
└── exemplo.lang2         (Arquivo de teste)
RequisitosJava (JDK)JFlex (instalado e disponível no seu PATH como jflex)makeComo Compilar e ExecutarCompilar o Projeto:O Makefile automatiza todo o processo:Executa o JFlex para gerar src/lexer/Lang2Lexer.java.Compila todos os arquivos .java para o diretório bin/.Cria um JAR executável lexer.jar.make
(ou make all)Executar o Analisador Léxico:Use o target run-lex do Makefile, especificando o arquivo de entrada com a variável FILE.make run-lex FILE=exemplo.lang2
Isso é um atalho para o comando completo:java -jar lexer.jar -lex exemplo.lang2
Limpar os Arquivos Gerados:Para remover o diretório bin/, o lexer.jar e o Lang2Lexer.java gerado:make clean
