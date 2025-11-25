<h1 align="center">🛒 Sistema de Gestão - Mercadinho do Felipe</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white" alt="Java">
  <img src="https://img.shields.io/badge/JSP-007396?style=for-the-badge&logo=java&logoColor=white" alt="JSP">
  <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL">
  <img src="https://img.shields.io/badge/Apache%20Tomcat-F8DC75?style=for-the-badge&logo=apache-tomcat&logoColor=black" alt="Tomcat">
</p>

<p align="center">
  <strong>Sistema web completo para gestão de pequenos mercados</strong><br>
  Gerenciamento de clientes, fornecedores, produtos e vendas com controle de estoque automatizado
</p>

<p align="center">
  <a href="#-características">Características</a> •
  <a href="#-tecnologias">Tecnologias</a> •
  <a href="#-começando">Começando</a> •
  <a href="#-estrutura">Estrutura</a> •
  <a href="#-desenvolvedores">Desenvolvedores</a>
</p>

---

## ✨ Características

### 🎯 Funcionalidades Principais

- **👥 Gerenciamento de Clientes**
  - ✅ Cadastro completo com validação de CPF único
  - 🔍 Consulta geral e por ID
  - ✏️ Alteração de dados cadastrais
  - 🗑️ Exclusão direta para página de confirmação

- **🏢 Gerenciamento de Fornecedores**
  - ✅ Cadastro com validação de CNPJ único
  - 🔍 Consulta geral e por ID
  - ✏️ Alteração de informações
  - 🗑️ Exclusão direta para página de confirmação

- **📦 Gerenciamento de Produtos**
  - ✅ Cadastro com vinculação opcional a fornecedor
  - 🔍 Consulta geral, por ID e por nome (busca parcial)
  - 📊 Controle de estoque integrado
  - ✏️ Alteração de dados e estoque
  - 🗑️ Exclusão direta para página de confirmação

- **💰 Gerenciamento de Vendas**
  - 🛒 Registro de vendas com validação de estoque
  - 🔄 Atualização automática do estoque ao realizar venda
  - 💵 Cálculo automático de valores (unitário e total)
  - 🔍 Consulta geral e por ID com exibição de nomes de clientes e produtos
  - ✏️ Alteração de vendas com ajuste de estoque
  - ♻️ Exclusão com restauração automática do estoque

### 🔐 Segurança e Controle de Acesso

- 🔑 **Sistema de Login Robusto**: Autenticação de usuários com diferentes níveis de acesso
- 🛡️ **Controle de Sessão**: Verificação automática em todas as páginas protegidas
- 👑 **ADMIN**: Acesso completo a todas as funcionalidades
- 👤 **FUNCIONÁRIO**: Acesso limitado (consulta e cadastro de vendas)
- 🔒 **Transações de Banco de Dados**: Garantia de integridade dos dados (ACID)

---

## 🚀 Tecnologias

<table>
  <tr>
    <td align="center"><strong>Backend</strong></td>
    <td>Java 8+, JSP (JavaServer Pages)</td>
  </tr>
  <tr>
    <td align="center"><strong>Frontend</strong></td>
    <td>HTML5, CSS3, JavaScript</td>
  </tr>
  <tr>
    <td align="center"><strong>Banco de Dados</strong></td>
    <td>MySQL 5.7+ / MariaDB 10.2+</td>
  </tr>
  <tr>
    <td align="center"><strong>Servidor</strong></td>
    <td>Apache Tomcat 8.5+</td>
  </tr>
  <tr>
    <td align="center"><strong>Driver JDBC</strong></td>
    <td>MySQL Connector/J 8.0+</td>
  </tr>
  <tr>
    <td align="center"><strong>Arquitetura</strong></td>
    <td>MVC + DAO Pattern</td>
  </tr>
</table>

---

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- ☕ **Java JDK 8** ou superior
- 🐬 **MySQL 5.7** ou superior (ou MariaDB 10.2+)
- 🐱 **Apache Tomcat 8.5** ou superior
- 🌐 Navegador moderno (Chrome, Firefox, Edge, Safari)

---

## 🎯 Começando

### 1️⃣ Clone o Repositório

```bash
git clone https://github.com/seu-usuario/ProjMercadinhoFelipe.git
cd ProjMercadinhoFelipe
```

### 2️⃣ Configure o Banco de Dados

```bash
# Entre no MySQL
mysql -u root -p

# Execute o script do banco de dados
source script_bancodedados.sql
```

Ou importe o arquivo `script_bancodedados.sql` diretamente no MySQL Workbench.

### 3️⃣ Configure a Conexão

Edite o arquivo `src/java/Config/ConectaBanco.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/mercadinho_felipe?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
private static final String USER = "root";
private static final String PASSWORD = "sua_senha";
```

### 4️⃣ Adicione o Driver MySQL

Baixe o [MySQL Connector/J](https://dev.mysql.com/downloads/connector/j/) e coloque o arquivo `.jar` em:
```
web/WEB-INF/lib/
```

### 5️⃣ Compile e Execute

1. **No NetBeans/Eclipse/IntelliJ:**
   - Abra o projeto
   - Configure o servidor Tomcat
   - Clique em "Run" (F6)

2. **Manualmente:**
   ```bash
   # Compile o projeto
   ant clean build
   
   # Deploy no Tomcat
   cp dist/ProjMercadinhoFelipe.war $TOMCAT_HOME/webapps/
   
   # Inicie o Tomcat
   $TOMCAT_HOME/bin/startup.sh  # Linux/Mac
   $TOMCAT_HOME\bin\startup.bat  # Windows
   ```

### 6️⃣ Acesse o Sistema

Abra seu navegador e acesse:
```
http://localhost:8080/ProjMercadinhoFelipe/
```

### 🔑 Credenciais Padrão

**Administrador:**
- 👤 Login: `admin`
- 🔐 Senha: `admin123`

**Funcionário:**
- 👤 Login: `func`
- 🔐 Senha: `func123`

---

## 📁 Estrutura do Projeto

```
ProjMercadinhoFelipe/
│
├── 📂 src/java/
│   ├── 📂 Config/
│   │   └── 🔧 ConectaBanco.java          # Gerenciamento de conexão e transações
│   └── 📂 model/
│       ├── 📄 Clientes.java              # Bean Cliente
│       ├── 📄 Fornecedores.java          # Bean Fornecedor
│       ├── 📄 Funcionario.java           # Bean Funcionário
│       ├── 📄 Produtos.java              # Bean Produto
│       ├── 📄 Vendas.java                # Bean Venda
│       └── 📂 DAO/
│           ├── 💾 ClienteDAO.java        # CRUD Clientes
│           ├── 💾 FornecedorDAO.java     # CRUD Fornecedores
│           ├── 💾 FuncionarioDAO.java    # Autenticação e CRUD
│           ├── 💾 ProdutoDAO.java        # CRUD Produtos
│           └── 💾 VendaDAO.java          # CRUD Vendas
│
├── 📂 web/
│   ├── 🏠 index.jsp                      # Página principal
│   ├── 🔐 login.jsp                      # Autenticação
│   ├── 🚪 logout.jsp                     # Encerramento de sessão
│   ├── 🛡️ verificar_sessao.jsp           # Verificação de sessão
│   ├── 📂 clientes/                      # Módulo Clientes
│   ├── 📂 fornecedores/                  # Módulo Fornecedores
│   ├── 📂 produtos/                      # Módulo Produtos
│   ├── 📂 vendas/                        # Módulo Vendas
│   └── 📂 style_geral/                   # Arquivos CSS
│       ├── 🎨 estilos.css
│       └── 🎨 tabela.css
│
├── 📜 script_bancodedados.sql            # Script do banco de dados
├── 📖 README.md                          # Documentação
└── 🔧 build.xml                          # Configuração Ant
```

---

## 🗄️ Estrutura do Banco de Dados

### Tabelas Principais

#### 👥 `clientes`
```sql
pk_id        INT (PK)
nome         VARCHAR
cpf          VARCHAR (UNIQUE)
telefone     VARCHAR
email        VARCHAR
endereco     VARCHAR
```

#### 🏢 `fornecedores`
```sql
pk_id        INT (PK)
nome         VARCHAR
cnpj         VARCHAR (UNIQUE)
telefone     VARCHAR
email        VARCHAR
endereco     VARCHAR
```

#### 📦 `produtos`
```sql
pk_id           INT (PK)
nome            VARCHAR
valor           DECIMAL
qtd             INT (Estoque)
categoria       VARCHAR
id_fornecedor   INT (FK → fornecedores)
```

#### 💰 `vendas`
```sql
pk_id           INT (PK)
id_cliente      INT (FK → clientes)
id_produto      INT (FK → produtos)
quantidade      INT
valor_unitario  DECIMAL
valor_total     DECIMAL
data_venda      DATETIME
```

#### 👤 `funcionarios`
```sql
pk_id        INT (PK)
nome         VARCHAR
cpf          VARCHAR (UNIQUE)
telefone     VARCHAR
email        VARCHAR
login        VARCHAR (UNIQUE)
senha        VARCHAR
tipo_acesso  ENUM('ADMIN', 'FUNCIONARIO')
```

### 🔗 Relacionamentos

- 🏢 **Fornecedores** → 📦 **Produtos** (1:N)
- 👥 **Clientes** → 💰 **Vendas** (1:N)
- 📦 **Produtos** → 💰 **Vendas** (1:N)

### 🛡️ Regras de Integridade

- ✅ Ao excluir um fornecedor, produtos associados têm `id_fornecedor` = NULL
- ❌ Não é permitido excluir cliente com vendas registradas
- ❌ Não é permitido excluir produto presente em vendas

---

## 🏗️ Arquitetura

### Padrão MVC (Model-View-Controller)

```
┌─────────────┐
│    VIEW     │  ← JSP Pages (Apresentação)
│   (JSP)     │
└──────┬──────┘
       │
┌──────▼──────┐
│ CONTROLLER  │  ← Servlets/JSP (Lógica de Controle)
│   (JSP)     │
└──────┬──────┘
       │
┌──────▼──────┐
│    MODEL    │  ← JavaBeans + DAO (Lógica de Negócios)
│ (Java/DAO)  │
└──────┬──────┘
       │
┌──────▼──────┐
│  DATABASE   │  ← MySQL (Persistência)
│   (MySQL)   │
└─────────────┘
```

### 🔄 Sistema de Transações (ACID)

Todas as operações críticas utilizam transações para garantir:

- **A**tomicidade: Tudo ou nada
- **C**onsistência: Estado sempre válido
- **I**solamento: Operações independentes
- **D**urabilidade: Alterações permanentes

**Exemplo de Transação:**
```java
// Ao registrar uma venda:
1. Verifica estoque suficiente
2. Insere registro da venda
3. Atualiza estoque do produto
4. COMMIT (sucesso) ou ROLLBACK (falha)
```

---

## 📸 Fluxos de Trabalho

### 🛒 Cadastro de Venda

```
1. Acessa módulo de Vendas
2. Seleciona "Cadastrar Venda"
3. Informa ID do cliente
4. Informa ID do produto
5. Informa quantidade
   ↓
   Sistema valida:
   ✓ Cliente existe?
   ✓ Produto existe?
   ✓ Há estoque suficiente?
   ↓
6. Sistema calcula valores
7. Registra venda + Atualiza estoque (TRANSAÇÃO)
8. ✅ Sucesso!
```

### 🗑️ Exclusão Direta

```
1. Acessa módulo desejado
2. Na tabela de consulta geral, clica no ícone da lixeira
3. Sistema redireciona para página de confirmação
4. Visualiza todos os dados do registro
5. Confirma ou cancela a exclusão
6. Sistema executa a exclusão (se confirmado)
7. ✅ Resultado exibido
```

---

## 🐛 Troubleshooting

### ❌ Erro de conexão com o banco

**Solução:**
- ✅ Verifique se o MySQL está rodando
- ✅ Confirme credenciais em `ConectaBanco.java`
- ✅ Verifique se o banco `mercadinho_felipe` existe

### ❌ Erro 404 ao acessar páginas

**Solução:**
- ✅ Confirme que o projeto foi compilado
- ✅ Verifique se o `.war` está em `webapps/`
- ✅ Confira os logs do Tomcat

### ❌ Erro de permissão negada

**Solução:**
- ✅ Faça login como ADMIN para exclusões
- ✅ Verifique se a sessão não expirou

### ❌ Estoque não atualiza

**Solução:**
- ✅ Verifique logs do servidor
- ✅ Confirme que transações estão funcionando

---

## 👨‍💻 Desenvolvedores

<table align="center">
  <tr>
    <td align="center">
      <strong>Felipe Soeiro Lopes</strong>
    </td>
  </tr>
  <tr>
    <td align="center">
      <strong>Giovanna de Paula Lopes Santos</strong>
    </td>
  </tr>
  <tr>
    <td align="center">
      <strong>Kauã da Silveira Nascimento Machado</strong>
    </td>
  </tr>
  <tr>
    <td align="center">
      <strong>Victor Guimarães Felipe</strong>
    </td>
  </tr>
</table>

---

## 📄 Licença

Este projeto foi desenvolvido para fins **acadêmicos** como parte da disciplina de programação.

---

<p align="center">
  <strong>⭐ Dê uma estrela se este projeto te ajudou!</strong>
</p>
