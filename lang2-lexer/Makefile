# Alunos: Jhonatan Figueiredo almeida - 20.1.8164 e Laura Lima Marques - 21.1.8022
JLEX = jflex

JC = javac
JFLAGS = -g -Xlint:none

# Diretorios
SRC_ROOT = src
BIN_DIR = bin
LEXER_PKG_DIR = $(SRC_ROOT)/lexer

# Arquivos Fonte
# O arquivo .jflex é a fonte para o .java
LEXER_DEF = $(LEXER_PKG_DIR)/Lang2Lexer.jflex
LEXER_JAVA = $(LEXER_PKG_DIR)/Lang2Lexer.java

# Outros arquivos Java estáticos
OTHER_JAVA = $(LEXER_PKG_DIR)/Main.java $(LEXER_PKG_DIR)/Token.java

# Arquivo de saida
JAR_FILE = lexer.jar
MAIN_CLASS = lexer.Main

# --- Targets ---

# Target principal: constrói o JAR executável
all: $(JAR_FILE)

# Cria o JAR
$(JAR_FILE): compile
	@echo "Criando JAR executável: $(JAR_FILE)..."
	jar cfe $(JAR_FILE) $(MAIN_CLASS) -C $(BIN_DIR) .
	@echo "Build completo. Use 'make run-lex FILE=...' para executar."

# Compila os fontes Java para .class
compile: $(LEXER_JAVA) $(OTHER_JAVA)
	@echo "Compilando fontes Java para o diretório $(BIN_DIR)..."
	mkdir -p $(BIN_DIR)
	$(JC) $(JFLAGS) -d $(BIN_DIR) $(LEXER_JAVA) $(OTHER_JAVA)

# Gera o Lang2Lexer.java a partir do Lang2Lexer.jflex
# Esta regra é chamada automaticamente se 'compile' precisar dela
$(LEXER_JAVA): $(LEXER_DEF)
	@echo "Gerando $(LEXER_JAVA) a partir de $(LEXER_DEF) usando JFlex..."
	$(JLEX) $(LEXER_DEF)

# Executa o analisador léxico
# Exemplo de uso: make run-lex FILE=exemplo.lang2
run-lex: $(JAR_FILE)
	@if [ -z "$(FILE)" ]; then \
		echo "Erro: Especifique o arquivo de entrada."; \
		echo "Exemplo: make run-lex FILE=exemplo.lang2"; \
		exit 1; \
	fi
	@echo "Executando analisador léxico em $(FILE)..."
	java -jar $(JAR_FILE) -lex $(FILE)

# Limpa os arquivos gerados
clean:
	@echo "Limpando arquivos gerados..."
	rm -rf $(BIN_DIR)
	rm -f $(LEXER_JAVA)
	rm -f $(JAR_FILE)
	@echo "Limpeza concluída."

# Declara targets que não geram arquivos
.PHONY: all compile run-lex clean
