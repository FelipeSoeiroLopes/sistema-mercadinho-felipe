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

## 🎯 Guia de Uso do Sistema

### 📋 Fluxo Completo de Operação

#### 1️⃣ Primeiro Acesso - Configuração Inicial

1. **Executar o script do banco de dados** (`script_bancodedados.sql`)
2. **Fazer login como ADMIN** (admin/admin123)
3. **Cadastrar fornecedores** antes de cadastrar produtos
4. **Cadastrar produtos** vinculando aos fornecedores
5. **Cadastrar clientes** para realizar vendas

#### 2️⃣ Operação Diária - Funcionário

```
1. Login no sistema (func/func123)
2. Consultar produtos disponíveis
3. Registrar vendas
   ↓
   O sistema automaticamente:
   ✓ Valida estoque disponível
   ✓ Calcula valores (unitário × quantidade)
   ✓ Registra a venda
   ✓ Atualiza o estoque
4. Consultar histórico de vendas
```

#### 3️⃣ Gerenciamento - Administrador

```
📦 PRODUTOS
├── Cadastrar novos produtos
├── Consultar por ID ou Nome
├── Alterar preços e categorias
├── Atualizar estoque manualmente
└── Excluir produtos (se não houver vendas)

🏢 FORNECEDORES
├── Cadastrar com CNPJ único
├── Consultar informações
├── Alterar dados de contato
└── Excluir (produtos ficam sem fornecedor)

👥 CLIENTES
├── Cadastrar com CPF único
├── Consultar dados
├── Alterar informações
└── Excluir (apenas se não houver vendas)

💰 VENDAS
├── Registrar nova venda
├── Consultar histórico completo
├── Alterar vendas (ajusta estoque)
└── Excluir vendas (restaura estoque)
```

### 🔄 Sistema de Transações (ACID)

O sistema garante a integridade dos dados através de transações:

**Exemplo: Cadastro de Venda**
```
1. Usuário informa: ID Cliente, ID Produto, Quantidade
2. Sistema executa TRANSAÇÃO:
   ├─ Verifica se cliente existe
   ├─ Verifica se produto existe
   ├─ Verifica se há estoque suficiente
   ├─ Calcula valor total
   ├─ Insere registro na tabela vendas
   └─ Atualiza estoque do produto
3. Se TUDO OK → COMMIT (confirma)
4. Se ALGUM ERRO → ROLLBACK (desfaz tudo)
```

**Exemplo: Exclusão de Venda**
```
1. Admin solicita exclusão da venda
2. Sistema executa TRANSAÇÃO:
   ├─ Busca dados da venda
   ├─ Exclui registro da venda
   └─ Restaura quantidade no estoque
3. COMMIT ou ROLLBACK
```

### 🔐 Diferenças entre Perfis de Acesso

| Funcionalidade | ADMIN | FUNCIONÁRIO |
|---|:---:|:---:|
| **Produtos** |  |  |
| Consultar | ✅ | ✅ |
| Cadastrar | ✅ | ❌ |
| Alterar | ✅ | ❌ |
| Excluir | ✅ | ❌ |
| **Fornecedores** |  |  |
| Consultar | ✅ | ✅ |
| Cadastrar | ✅ | ❌ |
| Alterar | ✅ | ❌ |
| Excluir | ✅ | ❌ |
| **Clientes** |  |  |
| Consultar | ✅ | ✅ |
| Cadastrar | ✅ | ✅ |
| Alterar | ✅ | ❌ |
| Excluir | ✅ | ❌ |
| **Vendas** |  |  |
| Consultar | ✅ | ✅ |
| Cadastrar | ✅ | ✅ |
| Alterar | ✅ | ❌ |
| Excluir | ✅ | ❌ |

### ⚡ Funcionalidades Especiais

#### 🔍 Busca Inteligente de Produtos

- **Por ID**: Busca exata do produto
- **Por Nome Completo**: Retorna produto específico
- **Por Nome Parcial**: Busca todos os produtos que contêm o termo
  - Exemplo: buscar "arroz" encontra "Arroz Integral 1kg", "Arroz Branco 5kg", etc.

#### 📊 Controle Automático de Estoque

1. **Ao Cadastrar Venda**:
   - Quantidade do produto é reduzida automaticamente
   - Sistema impede venda se estoque insuficiente

2. **Ao Alterar Venda**:
   - Se aumentar quantidade: diminui mais do estoque
   - Se diminuir quantidade: devolve ao estoque
   - Se mudar de produto: ajusta estoque de ambos

3. **Ao Excluir Venda**:
   - Quantidade vendida retorna ao estoque
   - Restauração automática

#### 💵 Cálculo Automático de Valores

- **Valor Unitário**: Buscado automaticamente do cadastro do produto
- **Valor Total**: Calculado como `quantidade × valor_unitario`
- **Atualização Dinâmica**: Ao alterar quantidade, valor total recalcula

#### ⏰ Registro de Data e Hora

- **Timezone**: America/Sao_Paulo (Brasília)
- **Formato**: dd/MM/yyyy HH:mm:ss
- **Precisão**: Milissegundos (Timestamp)

### 🎨 Interface do Usuário

- **Design Responsivo**: Funciona em diferentes tamanhos de tela
- **Cores por Módulo**:
  - 💗 **Rosa**: Produtos
  - 💙 **Azul**: Fornecedores
  - 💚 **Verde**: Clientes
  - 🧡 **Laranja/Amarelo**: Vendas
- **Ícones Intuitivos**:
  - ✏️ Lápis: Editar
  - 🗑️ Lixeira: Excluir
- **Mensagens de Feedback**:
  - ✅ Verde: Sucesso
  - ⚠️ Amarelo: Aviso
  - ❌ Vermelho: Erro

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

## 📸 Screenshots do Sistema

### 🔐 Login e Dashboard

<table>
  <tr>
    <td align="center">
      <img src="img/Login Admin/05-admin-tela-login.png" alt="Tela de Login" width="400"/>
      <br><b>Tela de Login</b>
    </td>
    <td align="center">
      <img src="img/Login Admin/06-admin-dashboard-principal.png" alt="Dashboard Admin" width="400"/>
      <br><b>Dashboard do Administrador</b>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="img/Login Func/01-func-tela-login.png" alt="Login Funcionário" width="400"/>
      <br><b>Login de Funcionário</b>
    </td>
    <td align="center">
      <img src="img/Login Func/02-func-dashboard-principal.png" alt="Dashboard Funcionário" width="400"/>
      <br><b>Dashboard do Funcionário</b>
    </td>
  </tr>
</table>

### 📦 Gerenciamento de Produtos

<table>
  <tr>
    <td align="center">
      <img src="img/Login Admin/07-admin-menu-produtos.png" alt="Menu Produtos" width="400"/>
      <br><b>Menu de Produtos</b>
    </td>
    <td align="center">
      <img src="img/Login Admin/11-admin-cadastrar-produto-form.png" alt="Cadastrar Produto" width="400"/>
      <br><b>Formulário de Cadastro</b>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="img/Login Admin/13-admin-consulta-geral-produtos.png" alt="Consulta Produtos" width="400"/>
      <br><b>Consulta Geral de Produtos</b>
    </td>
    <td align="center">
      <img src="img/Login Admin/20-admin-alterar-produto-form.png" alt="Alterar Produto" width="400"/>
      <br><b>Alterar Produto</b>
    </td>
  </tr>
</table>

### 🏢 Gerenciamento de Fornecedores

<table>
  <tr>
    <td align="center">
      <img src="img/Login Admin/25-admin-cadastrar-fornecedor-form.png" alt="Cadastrar Fornecedor" width="400"/>
      <br><b>Cadastro de Fornecedor</b>
    </td>
    <td align="center">
      <img src="img/Login Admin/27-admin-consulta-geral-fornecedores.png" alt="Consulta Fornecedores" width="400"/>
      <br><b>Consulta Geral de Fornecedores</b>
    </td>
  </tr>
</table>

### 👥 Gerenciamento de Clientes

<table>
  <tr>
    <td align="center">
      <img src="img/Login Admin/35-admin-cadastrar-cliente-form.png" alt="Cadastrar Cliente" width="400"/>
      <br><b>Cadastro de Cliente</b>
    </td>
    <td align="center">
      <img src="img/Login Admin/37-admin-consulta-geral-clientes.png" alt="Consulta Clientes" width="400"/>
      <br><b>Consulta Geral de Clientes</b>
    </td>
  </tr>
</table>

### 💰 Gerenciamento de Vendas e Controle de Estoque

<table>
  <tr>
    <td align="center">
      <img src="img/Login Admin/45-admin-cadastrar-venda-form.png" alt="Cadastrar Venda" width="400"/>
      <br><b>Registro de Venda</b>
    </td>
    <td align="center">
      <img src="img/Login Admin/47-admin-consulta-geral-vendas.png" alt="Consulta Vendas" width="400"/>
      <br><b>Consulta Geral de Vendas</b>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="img/Login Admin/48-admin-estoque-atualizado-apos-venda.png" alt="Estoque Atualizado" width="400"/>
      <br><b>Estoque Atualizado Automaticamente</b>
    </td>
    <td align="center">
      <img src="img/Login Admin/54-admin-venda-excluida-estoque-restaurado.png" alt="Estoque Restaurado" width="400"/>
      <br><b>Estoque Restaurado ao Excluir Venda</b>
    </td>
  </tr>
</table>

### 🗄️ Banco de Dados e Transações

<table>
  <tr>
    <td align="center">
      <img src="img/Login Admin/02-admin-phpmyadmin-banco-dados.png" alt="Banco de Dados" width="400"/>
      <br><b>Estrutura do Banco de Dados</b>
    </td>
    <td align="center">
      <img src="img/Login Admin/03-admin-tabela-vendas-inicial-transacional.png" alt="Tabela Vendas" width="400"/>
      <br><b>Tabela de Vendas no Banco com transacional</b>
    </td>
  </tr>
</table>

### 🔒 Controle de Acesso por Perfil

<table>
  <tr>
    <td align="center">
      <img src="img/Login Func/03-func-menu-produtos-acesso-limitado.png" alt="Acesso Limitado Produtos" width="400"/>
      <br><b>Funcionário - Acesso Limitado em Produtos</b>
    </td>
    <td align="center">
      <img src="img/Login Func/06-func-menu-vendas-completo.png" alt="Acesso Completo Vendas" width="400"/>
      <br><b>Funcionário - Acesso Completo em Vendas</b>
    </td>
  </tr>
</table>

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
