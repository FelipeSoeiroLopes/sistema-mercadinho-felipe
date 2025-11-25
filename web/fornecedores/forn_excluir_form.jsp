<%-- 
    Document   : Formulário de Exclusão de Fornecedor
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
<%@page import="model.Fornecedores"%>
<%@page import="model.DAO.FornecedorDAO"%>

<%
    // Verificar se é admin
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/index.jsp?error=acesso_negado");
        return;
    }

    String idParam = request.getParameter("id");
    Fornecedores fornecedor = null;
    String errorMessage = null;

    if (idParam != null && !idParam.isEmpty()) {
        try {
            int fornecedorId = Integer.parseInt(idParam);
            Fornecedores forn = new Fornecedores();
            forn.setId(fornecedorId);
            
            FornecedorDAO fornDAO = new FornecedorDAO();
            fornecedor = fornDAO.consultar_id(forn);

            if (fornecedor == null) {
                errorMessage = "Fornecedor com ID " + fornecedorId + " não encontrado.";
            }
        } catch (NumberFormatException e) {
            errorMessage = "ID do fornecedor inválido.";
        } catch (Exception e) {
            errorMessage = "Erro ao consultar fornecedor: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Excluir Fornecedor</title>
    <meta charset="UTF-8">
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2, h1 { color: #4facfe; }
        label { display: block; margin-top: 15px; margin-bottom: 5px; }
        input[type="number"] { width: 100%; padding: 8px; margin-bottom: 10px; border-radius: 4px; border: 1px solid #ccc; }
        .button { padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; color: white; text-decoration: none; }
        .btn-danger { background-color: #dc3545; }
        .btn-secondary { background-color: #6c757d; }
        .data-details { margin-top: 20px; padding: 15px; background: #f8f9fa; border-radius: 8px; }
        .data-details p { margin: 8px 0; }
        .error { color: red; padding: 10px; background: #f8d7da; border-radius: 5px; margin-bottom: 15px; }
        .confirmation-buttons { margin-top: 20px; display: flex; gap: 10px; }
        .back-link { display: inline-block; margin-top: 20px; color: #4facfe; text-decoration: none; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Excluir Fornecedor</h2>
        
        <form method="get" action="forn_excluir_form.jsp">
            <label for="id">Digite o ID do Fornecedor:</label>
            <input type="number" id="id" name="id" required value="<%= idParam != null ? idParam : "" %>">
            <button type="submit" class="button" style="background-color: #007bff; width: 100%;">Buscar Fornecedor</button>
        </form>

        <% if (errorMessage != null) { %>
            <div class="error"><%= errorMessage %></div>
        <% } %>

        <% if (fornecedor != null) { %>
            <div class="data-details">
                <h3>Dados do Fornecedor a ser Excluído:</h3>
                <p><strong>ID:</strong> <%= fornecedor.getId() %></p>
                <p><strong>Nome:</strong> <%= fornecedor.getNome() %></p>
                <p><strong>CNPJ:</strong> <%= fornecedor.getCnpj() %></p>
                <p><strong>Telefone:</strong> <%= fornecedor.getTelefone() %></p>
                <p><strong>Email:</strong> <%= fornecedor.getEmail() %></p>
                <p><strong>Endereço:</strong> <%= fornecedor.getEndereco() %></p>
            </div>

            <div class="confirmation">
                <h4>Tem certeza que deseja excluir este fornecedor?</h4>
                <div class="confirmation-buttons">
                    <form method="post" action="forn_exclui_action.jsp" style="display: inline;">
                        <input type="hidden" name="id" value="<%= fornecedor.getId() %>">
                        <button type="submit" class="button btn-danger">Sim, Excluir</button>
                    </form>
                    <a href="forn_excluir_form.jsp" class="button btn-secondary">Não, Cancelar</a>
                </div>
            </div>
        <% } %>

        <a href="index.jsp" class="back-link">&larr; Voltar</a>
    </div>
</body>
</html>
