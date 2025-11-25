-- ============================================================================
-- Script de criação do banco de dados para o Mercadinho do Felipe
-- Java 24
-- Versão: 2.0 - Atualizado com todas as funcionalidades
-- 
-- Desenvolvedores:
-- - Felipe Soeiro Lopes
-- - Giovanna de Paula Lopes Santos
-- - Kauã da Silveira Nascimento Machado
-- - Victor Guimarães Felipe
-- ============================================================================

-- ============================================================================
-- 1. CRIAR BANCO DE DADOS
-- ============================================================================
CREATE DATABASE IF NOT EXISTS mercadinho_felipe 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE mercadinho_felipe;

-- ============================================================================
-- 2. CRIAR TABELAS (ordem respeitando dependências de foreign keys)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 2.1 Tabela de Fornecedores (sem dependências)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS fornecedores (
    pk_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(255),
    endereco VARCHAR(255),
    INDEX idx_nome (nome)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- 2.2 Tabela de Clientes (sem dependências)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS clientes (
    pk_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(255),
    endereco VARCHAR(255),
    INDEX idx_nome (nome)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- 2.3 Tabela de Funcionários (sem dependências)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS funcionarios (
    pk_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(255),
    login VARCHAR(50) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    tipo_acesso ENUM('FUNCIONARIO', 'ADMIN') NOT NULL DEFAULT 'FUNCIONARIO',
    INDEX idx_login (login),
    INDEX idx_tipo (tipo_acesso)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- 2.4 Tabela de Produtos (depende de fornecedores)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS produtos (
    pk_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    qtd INT NOT NULL DEFAULT 0,
    categoria VARCHAR(100),
    id_fornecedor INT,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(pk_id) ON DELETE SET NULL,
    INDEX idx_nome (nome),
    INDEX idx_fornecedor (id_fornecedor)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- 2.5 Tabela de Vendas (depende de clientes e produtos)
-- Sistema transacional completo com:
-- - ID da venda
-- - ID do cliente
-- - ID e nome do produto (via JOIN)
-- - Quantidade do pedido
-- - Valor unitário do pedido
-- - Valor total do pedido
-- - Data e hora no padrão Brasil (Brasília) - DATETIME
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS vendas (
    pk_id INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10, 2) NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    data_venda DATETIME NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(pk_id) ON DELETE RESTRICT,
    FOREIGN KEY (id_produto) REFERENCES produtos(pk_id) ON DELETE RESTRICT,
    INDEX idx_data (data_venda),
    INDEX idx_cliente (id_cliente),
    INDEX idx_produto (id_produto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 3. INSERIR DADOS DE EXEMPLO (opcional)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 3.1 Inserir Fornecedores
-- ----------------------------------------------------------------------------
INSERT INTO fornecedores (nome, cnpj, telefone, email, endereco) VALUES
('Distribuidora ABC Ltda', '12.345.678/0001-90', '(11) 1234-5678', 'contato@abc.com.br', 'Rua das Flores, 123 - São Paulo/SP'),
('Atacadão XYZ', '98.765.432/0001-10', '(11) 9876-5432', 'vendas@xyz.com.br', 'Av. Principal, 456 - São Paulo/SP');

-- ----------------------------------------------------------------------------
-- 3.2 Inserir Clientes
-- ----------------------------------------------------------------------------
INSERT INTO clientes (nome, cpf, telefone, email, endereco) VALUES
('João Silva', '123.456.789-00', '(11) 99999-8888', 'joao@email.com', 'Rua A, 10 - São Paulo/SP'),
('Maria Santos', '987.654.321-00', '(11) 88888-7777', 'maria@email.com', 'Rua B, 20 - São Paulo/SP');

-- ----------------------------------------------------------------------------
-- 3.3 Inserir Funcionários
-- Admin: login=admin, senha=admin123
-- Funcionário: login=func, senha=func123
-- ----------------------------------------------------------------------------
INSERT INTO funcionarios (nome, cpf, telefone, email, login, senha, tipo_acesso) VALUES
('Administrador Sistema', '000.000.000-00', '(11) 0000-0000', 'admin@mercadinho.com', 'admin', 'admin123', 'ADMIN'),
('Funcionário Teste', '111.111.111-11', '(11) 1111-1111', 'func@mercadinho.com', 'func', 'func123', 'FUNCIONARIO');

-- ----------------------------------------------------------------------------
-- 3.4 Inserir Produtos (após fornecedores devido à foreign key)
-- ----------------------------------------------------------------------------
INSERT INTO produtos (nome, valor, qtd, categoria, id_fornecedor) VALUES
('Arroz 5kg', 25.90, 100, 'Alimentos', 1),
('Feijão 1kg', 8.50, 150, 'Alimentos', 1),
('Óleo de Soja 900ml', 6.99, 200, 'Alimentos', 2),
('Açúcar 1kg', 5.50, 120, 'Alimentos', 2);

-- ============================================================================
-- FIM DO SCRIPT
-- ============================================================================
-- 
-- ESTRUTURA DO BANCO:
-- 
-- 1. FORNECEDORES
--    - pk_id (PK, AUTO_INCREMENT)
--    - nome, cnpj, telefone, email, endereco
-- 
-- 2. CLIENTES
--    - pk_id (PK, AUTO_INCREMENT)
--    - nome, cpf, telefone, email, endereco
-- 
-- 3. FUNCIONARIOS
--    - pk_id (PK, AUTO_INCREMENT)
--    - nome, cpf, telefone, email, login, senha, tipo_acesso
-- 
-- 4. PRODUTOS
--    - pk_id (PK, AUTO_INCREMENT)
--    - nome, valor, qtd, categoria
--    - id_fornecedor (FK -> fornecedores.pk_id)
-- 
-- 5. VENDAS (Sistema Transacional)
--    - pk_id (PK, AUTO_INCREMENT) - ID da venda
--    - id_cliente (FK -> clientes.pk_id) - ID do cliente
--    - id_produto (FK -> produtos.pk_id) - ID do produto
--    - quantidade - Quantidade do pedido vendido
--    - valor_unitario - Valor unitário do pedido
--    - valor_total - Valor total do pedido vendido
--    - data_venda (DATETIME) - Data e hora padrão Brasil (Brasília)
-- 
-- OBSERVAÇÕES:
-- - Todas as tabelas usam UTF-8 (utf8mb4) para suportar caracteres especiais
-- - Todas as consultas ordenam por ID (menor para maior)
-- - Sistema transacional completo para vendas
-- - Foreign keys garantem integridade referencial
-- ============================================================================

