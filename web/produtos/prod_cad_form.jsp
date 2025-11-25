<%-- 
    Document   : Formulário de Cadastro de Produtos
    Mercadinho do Felipe
    Java 24
    Desenvolvedores:
    - Felipe Soeiro Lopes
    - Giovanna de Paula Lopes Santos
    - Kauã da Silveira Nascimento Machado
    - Victor Guimarães Felipe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../verificar_sessao.jsp"%>
<%@page import="java.util.*"%>
<%@page import="model.Fornecedores"%>
<%@page import="model.DAO.FornecedorDAO"%>

<%
    // Verificar se é admin
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/index.jsp?error=acesso_negado");
        return;
    }
    
    // Carregar lista de fornecedores
    List<Fornecedores> listaFornecedores = new ArrayList<>();
    try {
        FornecedorDAO fornDAO = new FornecedorDAO();
        listaFornecedores = fornDAO.consultar_geral();
        if (listaFornecedores == null) {
            listaFornecedores = new ArrayList<>();
        }
    } catch (Exception ex) {
        listaFornecedores = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Cadastrar Produto - Mercadinho do Felipe</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                margin: 0;
                padding: 20px;
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .container {
                background-color: #fff;
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
                width: 100%;
                max-width: 500px;
            }
            h2 {
                margin-bottom: 20px;
                color: #f5576c;
                font-size: 24px;
                text-align: center;
            }
            label {
                display: block;
                margin-bottom: 6px;
                font-weight: 500;
                color: #333;
            }
            input[type="text"], input[type="number"], select {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #dcdfe3;
                border-radius: 4px;
                font-size: 16px;
                transition: border-color 0.3s;
                box-sizing: border-box;
            }
            input:focus, select:focus {
                border-color: #f5576c;
                outline: none;
            }
            .buttons {
                display: flex;
                justify-content: space-between;
            }
            button {
                padding: 10px 20px;
                font-size: 16px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .submit-btn {
                background-color: #f5576c;
                color: white;
            }
            .submit-btn:hover {
                background-color: #d13b4f;
            }
            .reset-btn {
                background-color: #e0e0e0;
                color: #333;
            }
            .reset-btn:hover {
                background-color: #c2c2c2;
            }
            a {
                display: inline-block;
                margin-top: 15px;
                color: #f5576c;
                text-decoration: none;
            }
            .info {
                padding: 10px;
                background: #fff3cd;
                border: 1px solid #ffc107;
                border-radius: 4px;
                margin-bottom: 20px;
                color: #856404;
                font-size: 14px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Cadastrar Produto</h2>
            <% if (listaFornecedores.isEmpty()) { %>
                <div class="info">
                    ⚠️ Nenhum fornecedor cadastrado. Por favor, cadastre um fornecedor antes de cadastrar produtos.
                </div>
            <% } %>
            <form method="post" action="prod_cad.jsp" accept-charset="UTF-8">
                <label for="nome">Nome do Produto:</label>
                <input type="text" id="nome" name="nome" required>
                
                <label for="valor">Valor (R$):</label>
                <input type="number" id="valor" name="valor" step="0.01" min="0" required>
      
                <label for="qtd">Quantidade:</label>
                <input type="number" id="qtd" name="qtd" step="1" min="0" required>
                
                <label for="categoria">Categoria:</label>
                <input type="text" id="categoria" name="categoria" required>
                
                <label for="idFornecedor">Fornecedor:</label>
                <select id="idFornecedor" name="idFornecedor">
                    <option value="0">Selecione um fornecedor (opcional)</option>
                    <% 
                        for (Fornecedores forn : listaFornecedores) {
                            out.println("<option value=\"" + forn.getId() + "\">" + 
                                       (forn.getNome() != null ? forn.getNome() : "") + 
                                       "</option>");
                        }
                    %>
                </select>
               
                <div class="buttons">
                    <button type="submit" class="submit-btn">Salvar</button>
                    <button type="reset" class="reset-btn">Limpar</button>
                </div>
            </form>
            <a href="index.jsp">&larr; Voltar</a>
        </div>
    </body>
</html>

