
# 🧩 Analisador Léxico — Lang2 (TP1)

Este projeto implementa um **analisador léxico completo** para a linguagem **Lang2**, desenvolvido em **Java** utilizando o **gerador de lexer JFlex**.

---

## 📁 Estrutura de Arquivos

```
lang2-lexer/
├── src/
│   └── lexer/
│       ├── Lang2Lexer.jflex   # Definição do Lexer
│       ├── Main.java          # Programa principal (CLI)
│       └── Token.java         # Classe que representa um Token
├── Makefile
└── exemplo.lang2              # Arquivo de teste
```

---

## ⚙️ Requisitos

Antes de executar o projeto, certifique-se de ter instalado:

* **Java (JDK)**
* **JFlex** (disponível no seu `PATH` como `jflex`)
* **make**

---

## 🏗️ Como Compilar e Executar

### 🔧 Compilar o Projeto

O **Makefile** automatiza todo o processo:

1. Executa o **JFlex** para gerar o arquivo `src/lexer/Lang2Lexer.java`.
2. Compila todos os arquivos `.java` para o diretório `bin/`.
3. Cria um **JAR executável** chamado `lexer.jar`.

```bash
make
# ou
make all
```

---

### ▶️ Executar o Analisador Léxico

Para rodar o analisador em um arquivo de entrada, use o target `run-lex`:

```bash
make run-lex FILE=exemplo.lang2
```

Esse comando é um atalho para:

```bash
java -jar lexer.jar -lex exemplo.lang2
```

---

### 🧹 Limpar os Arquivos Gerados

Para remover arquivos compilados (`bin/`), o `lexer.jar` e o `Lang2Lexer.java` gerado:

```bash
make clean
```

---

## 🧠 Observações

* O analisador foi desenvolvido para fins didáticos, seguindo as especificações da linguagem **Lang2**.
* É possível ajustar o arquivo `.jflex` para suportar novos tokens ou regras léxicas.

---

## 👨‍💻 Autor

**Jhonatan Almeida\n**
**Laura**
📘 Trabalho Prático 1 — Compiladores

