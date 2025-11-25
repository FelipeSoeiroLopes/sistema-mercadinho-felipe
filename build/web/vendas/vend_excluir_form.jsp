<%-- 
    Document   : Formulário de Exclusão de Venda
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
<%@page import="model.Vendas"%>
<%@page import="model.DAO.VendaDAO"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    // Verificar se é admin
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/index.jsp?error=acesso_negado");
        return;
    }

    String idParam = request.getParameter("id");
    Vendas venda = null;
    String errorMessage = null;
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

    if (idParam != null && !idParam.isEmpty()) {
        try {
            int vendaId = Integer.parseInt(idParam);
            Vendas v = new Vendas();
            v.setId(vendaId);
            
            VendaDAO vDAO = new VendaDAO();
            venda = vDAO.consultar_id(v);

            if (venda == null) {
                errorMessage = "Venda com ID " + vendaId + " não encontrada.";
            }
        } catch (NumberFormatException e) {
            errorMessage = "ID da venda inválido.";
        } catch (Exception e) {
            errorMessage = "Erro ao consultar venda: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Excluir Venda</title>
    <meta charset="UTF-8">
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2, h1 { color: #fa709a; }
        label { display: block; margin-top: 15px; margin-bottom: 5px; }
        input[type="number"] { width: 100%; padding: 8px; margin-bottom: 10px; border-radius: 4px; border: 1px solid #ccc; }
        .button { padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; color: white; text-decoration: none; }
        .btn-danger { background-color: #dc3545; }
        .btn-secondary { background-color: #6c757d; }
        .data-details { margin-top: 20px; padding: 15px; background: #f8f9fa; border-radius: 8px; }
        .data-details p { margin: 8px 0; }
        .error { color: red; padding: 10px; background: #f8d7da; border-radius: 5px; margin-bottom: 15px; }
        .confirmation-buttons { margin-top: 20px; display: flex; gap: 10px; }
        .back-link { display: inline-block; margin-top: 20px; color: #fa709a; text-decoration: none; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Excluir Venda</h2>
        
        <form method="get" action="vend_excluir_form.jsp">
            <label for="id">Digite o ID da Venda:</label>
            <input type="number" id="id" name="id" required value="<%= idParam != null ? idParam : "" %>">
            <button type="submit" class="button" style="background-color: #007bff; width: 100%;">Buscar Venda</button>
        </form>

        <% if (errorMessage != null) { %>
            <div class="error"><%= errorMessage %></div>
        <% } %>

        <% if (venda != null) { %>
            <div class="data-details">
                <h3>Dados da Venda a ser Excluída:</h3>
                <p><strong>ID da Venda:</strong> <%= venda.getId() %></p>
                <p><strong>ID do Cliente:</strong> <%= venda.getIdCliente() %></p>
                <p><strong>Produto:</strong> <%= venda.getNomeProduto() %> (ID: <%= venda.getIdProduto() %>)</p>
                <p><strong>Quantidade:</strong> <%= venda.getQuantidade() %></p>
                <p><strong>Valor Unitário:</strong> R$ <%= String.format("%.2f", venda.getValorUnitario()) %></p>
                <p><strong>Valor Total:</strong> R$ <%= String.format("%.2f", venda.getValorTotal()) %></p>
                <p><strong>Data da Venda:</strong> <%= sdf.format(venda.getDataVenda()) %></p>
            </div>

            <div class="confirmation">
                <h4>Tem certeza que deseja excluir esta venda? (O estoque do produto será restaurado)</h4>
                <div class="confirmation-buttons">
                    <form method="post" action="vend_exclui_action.jsp" style="display: inline;">
                        <input type="hidden" name="id" value="<%= venda.getId() %>">
                        <button type="submit" class="button btn-danger">Sim, Excluir</button>
                    </form>
                    <a href="vend_excluir_form.jsp" class="button btn-secondary">Não, Cancelar</a>
                </div>
            </div>
        <% } %>

        <a href="index.jsp" class="back-link">&larr; Voltar</a>
    </div>
</body>
</html>
